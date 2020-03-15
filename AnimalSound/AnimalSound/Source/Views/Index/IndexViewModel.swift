//
//  IndexViewModel.swift
//  AnimalSound
//
//  Created by 김효원 on 15/03/2020.
//  Copyright © 2020 김효원. All rights reserved.
//

import RxSwift
import RxCocoa
import RxOptional

struct IndexViewModel: IndexViewBindable {
    let viewWillAppear = PublishRelay<Void>()
    let deleteData = PublishRelay<Int>()
    let cellData: Driver<[AnimalListCell.CellData]>
    let reloadList: Signal<Void>
    
    init(model: IndexModel = IndexModel()) {
        let deleteAnimal = deleteData
            .map(model.deleteAnimal)
        
        let getAnimal = viewWillAppear
            .map(model.getAnimalList)
        
        cellData = Observable.merge(deleteAnimal, getAnimal)
            .filterNil()
            .map(model.parseAnimal(animalList:))
            .asDriver(onErrorDriveWith: .empty())
        
        reloadList = Observable.merge(deleteAnimal, getAnimal)
            .map { _ in Void() }
            .asSignal(onErrorSignalWith: .empty())
    }
}
