//
//  MockUpUserDefaultsManager.swift
//  AnimalSoundTests
//
//  Created by 김효원 on 16/03/2020.
//  Copyright © 2020 김효원. All rights reserved.
//

import Foundation

@testable import AnimalSound

struct MockUpUserDefaultsManager: UserDefaultsManager {
    private let dataKey = "Animal"
    private let dummyData = Animal(date: Date(), type: .cat, name: "")
    
    func getAnimalList() -> [Animal]? {
        let list = AnimalDummyData.animalDataList
        
        return parseListToAnimal(list: list)
    }
    
    func saveAnimal(animal: Animal) -> [Animal]? {
        var list = AnimalDummyData.animalDataList
        list.updateValue(parseAnimalToList(animal: animal), forKey: "\(animal.date)")
        
        return parseListToAnimal(list: list)
    }
    
    func removeAnimal(date: Date) -> [Animal]? {
        var list = AnimalDummyData.animalDataList
        list.removeValue(forKey: "\(date)")
        
        return parseListToAnimal(list: list)
    }
}

extension MockUpUserDefaultsManager {
    private func parseListToAnimal(list: [String: Any]) -> [Animal] {
        return list.values.map { dictionary -> Animal in
            guard let animal = dictionary as? [String: Any] else { return dummyData }
            
            return Animal(date: animal["date"] as? Date ?? Date(),
                          type: AnimalType(rawValue: (animal["type"] as? String ?? "")) ?? AnimalType.dog,
                          name: animal["name"] as? String ?? "")
        }
    }
    
    private func parseAnimalToList(animal: Animal) -> [String: Any] {
        return [ "date": animal.date,
                 "type": "\(animal.type)",
            "name": animal.name]
    }
}
