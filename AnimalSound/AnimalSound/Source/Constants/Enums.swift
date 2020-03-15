//
//  Enums.swift
//  AnimalSound
//
//  Created by 김효원 on 15/03/2020.
//  Copyright © 2020 김효원. All rights reserved.
//

import Foundation

enum AnimalType: String {
    case dog = "강아지"
    case cat = "고양이"
    case parrot = "앵무새"
    case lizard = "도마뱀"
    
    func getAniamlSoud() -> String? {
        switch self {
        case .dog:
            return "멍멍"
        case .cat:
            return "멍멍"
        case .parrot:
            return "멍멍"
        case .lizard:
            return nil
        }
    }
}
