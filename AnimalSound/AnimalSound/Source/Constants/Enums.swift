//
//  Enums.swift
//  AnimalSound
//
//  Created by 김효원 on 15/03/2020.
//  Copyright © 2020 김효원. All rights reserved.
//

import Foundation

enum AnimalType: String {
    case dog = "dog"
    case cat = "cat"
    case parrot = "parrot"
    case lizard = "lizard"
    
    func getAnimalName() -> String? {
        switch self {
        case .dog:
            return "강아지"
        case .cat:
            return "고양이"
        case .parrot:
            return "앵무새"
        case .lizard:
            return "도마뱀"
        }
    }
    
    func getAnimalSound() -> String? {
        switch self {
        case .dog:
            return "멍멍"
        case .cat:
            return "야옹"
        case .parrot:
            return "짹짹"
        case .lizard:
            return nil
        }
    }
}
