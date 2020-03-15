//
//  AddTests.swift
//  AnimalSoundTests
//
//  Created by 김효원 on 16/03/2020.
//  Copyright © 2020 김효원. All rights reserved.
//

import XCTest
import RxSwift

@testable import AnimalSound

class AddTests: XCTestCase {
    let disposeBag = DisposeBag()
    let dataManager = MockUpUserDefaultsManager()
    var viewModel: AddViewModel!
    var model: AddModel!

    override func setUp() {
        self.model = AddModel(userDefaultsManager: dataManager)
        self.viewModel = AddViewModel(model: model)
    }

    func testSaveAnimal() {
        let animalList = model.saveAnimal(animal: AnimalDummyData.animalData)
        assert(animalList?.contains(where: { $0.date == AnimalDummyData.animalData.date }) ?? false, "Memo Update & Save Success")
    }
    
    func testGetAndParse() {
        viewModel.saveAnimal
            .emit(onNext: { data in
                assert(data.contains(where: { $0.date == AnimalDummyData.animalData.date }))
            })
            .disposed(by: disposeBag)
        
        viewModel.saveData.accept(AnimalDummyData.animalData)
    }
}
