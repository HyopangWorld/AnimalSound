//
//  UserDefaultsManager.swift
//  AnimalSound
//
//  Created by 김효원 on 15/03/2020.
//  Copyright © 2020 김효원. All rights reserved.
//

import Foundation

protocol UserDefaultsManager {
    func getAnimalList() -> [Animal]?
    func saveAnimal(animal: Animal) -> [Animal]?
    func removeAnimal(date: Date) -> [Animal]?
}
