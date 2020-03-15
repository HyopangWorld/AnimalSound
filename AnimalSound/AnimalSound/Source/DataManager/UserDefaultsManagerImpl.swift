//
//  UserDefaultsManagerImpl.swift
//  AnimalSound
//
//  Created by 김효원 on 15/03/2020.
//  Copyright © 2020 김효원. All rights reserved.
//

import Foundation

struct UserDefaultsManagerImpl: UserDefaultsManager {
    private let dataKey = "Animal"
    private let dummyData = Animal(date: Date(), type: .cat, name: "")

    func getAnimalList() -> [Animal]? {
        guard let list = UserDefaults.standard.dictionary(forKey: dataKey) else { return nil }
        
        return parseListToAnimal(list: list)
    }
    
    func removeMemo(date: Date) -> [Animal]? {
        guard var list = UserDefaults.standard.dictionary(forKey: dataKey) else { return nil }
        list.removeValue(forKey: "\(date)")
        UserDefaults.standard.set(list, forKey: dataKey)
        UserDefaults.standard.synchronize()
        
        return parseListToAnimal(list: list)
    }
    
    func getId() -> Date {
        return Date()
    }
}

extension UserDefaultsManagerImpl {
    private func parseListToAnimal(list: [String: Any]) -> [Animal] {
        return list.values.map { dictionary -> Animal in
            guard let animal = dictionary as? [String: Any] else { return dummyData }
            
            return Animal(date: animal["date"] as? Date ?? Date(),
                          type: animal["type"] as? AnimalType ?? AnimalType.dog,
                          name: animal["name"] as? String ?? "")
        }
    }
    
    private func parseListToAnimal(animal: Animal) -> [String: Any] {
        return [ "date": animal.date,
                 "type": animal.type,
                 "name": animal.name]
    }
}
