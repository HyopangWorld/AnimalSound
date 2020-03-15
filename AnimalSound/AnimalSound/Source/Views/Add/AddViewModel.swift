//
//  AddViewModel.swift
//  AnimalSound
//
//  Created by 김효원 on 16/03/2020.
//  Copyright © 2020 김효원. All rights reserved.
//

import RxSwift
import RxCocoa

struct AddViewModel: AddViewBindable {
    let saveData = PublishRelay<Animal>()
    let saveAnimal: Signal<[Animal]>
    
    init(model: AddModel = AddModel()) {
        saveAnimal = saveData
            .map(model.saveAnimal(animal:))
            .filterNil()
            .asSignal(onErrorSignalWith: .empty())
    }
}
