//
//  IndexModel.swift
//  AnimalSound
//
//  Created by 김효원 on 15/03/2020.
//  Copyright © 2020 김효원. All rights reserved.
//

import Foundation
import RxSwift

struct IndexModel {
    
    init() {
    }
    
    func getAnimalList() -> [Animal]? {
        return []
    }
    
    func deleteAnimal(id: Int) -> [Animal]? {
        return []
    }
    
    func parseAnimal(animalList: [Animal]) -> [AnimalListCell.CellData] {
        return sortAsce(list: animalList).map { (id: $0.id,
                               type: $0.type,
                               name: $0.name) }
    }
    
    private func sortDesc(list: [Animal]) -> [Animal] {
        return list.sorted { $0.id < $1.id }
    }
    
    private func sortAsce(list: [Animal]) -> [Animal] {
        return list.sorted { $0.id > $1.id }
    }
}