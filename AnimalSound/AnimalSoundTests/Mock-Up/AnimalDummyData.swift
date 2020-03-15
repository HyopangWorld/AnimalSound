//
//  DummyData.swift
//  AnimalSoundTests
//
//  Created by 김효원 on 16/03/2020.
//  Copyright © 2020 김효원. All rights reserved.
//

import Foundation

@testable import AnimalSound

struct AnimalDummyData {
    static let animalDataList: [String: Any] = [
        "\(Date(timeIntervalSince1970: 86400))": [
            "date": Date(timeIntervalSince1970: 86400),
            "type": "\(AnimalType.parrot)",
            "name": "엘리자베스"
        ],
        "\(Date(timeIntervalSince1970: 86405))": [
            "date": Date(timeIntervalSince1970: 86405),
            "type": "\(AnimalType.cat)",
            "name": "루다"
        ]
    ]
    
    static let animalData: Animal = Animal(date: Date(timeIntervalSince1970: 86410),
                                         type: AnimalType.dog,
                                         name: "까망이")
}
