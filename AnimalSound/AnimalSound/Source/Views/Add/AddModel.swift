//
//  AddModel.swift
//  AnimalSound
//
//  Created by 김효원 on 16/03/2020.
//  Copyright © 2020 김효원. All rights reserved.
//

struct AddModel {
    let userDefaultsManager: UserDefaultsManager
    
    init(userDefaultsManager: UserDefaultsManager = UserDefaultsManagerImpl()) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    func saveAnimal(animal: Animal) -> [Animal]? {
        return userDefaultsManager.saveAnimal(animal: animal)
    }
}
