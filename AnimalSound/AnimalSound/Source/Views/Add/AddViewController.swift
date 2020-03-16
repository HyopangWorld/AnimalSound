//
//  AddViewController.swift
//  AnimalSound
//
//  Created by 김효원 on 15/03/2020.
//  Copyright © 2020 김효원. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa
import RxOptional
import KRWordWrapLabel

protocol AddViewBindable {
    var saveData: PublishRelay<Animal> { get }
    var saveAnimal: Signal<[Animal]> { get }
}

final class AddViewController: ViewController<AddViewBindable> {
    private typealias UI = Constants.UI.Add
    private typealias TEXT = Constants.TEXT.Add
    
    let noticeLabel = KRWordWrapLabel()
    let nameTextField = UITextField()
    let typePicker = UIButton()
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
    
    var animal = Animal(date: Date(), type: .dog, name: "")
    
    override func bind(_ viewModel: AddViewBindable) {
        self.disposeBag = DisposeBag()
        
        viewModel.saveAnimal.asObservable()
            .subscribe(onNext: { [weak self] _ in self?.navigationController?.popToRootViewController(animated: true) })
            .disposed(by: disposeBag)
        
        doneButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.animal.name = self?.nameTextField.text ?? ""
                guard let animal = self?.animal else { return }
                viewModel.saveData.accept(animal)
            })
            .disposed(by: disposeBag)
    }
    
    override func layout() {
        view.backgroundColor = Constants.UI.Base.backgroundColor
        self.setTouchEndEditing(disposeBag: disposeBag)
        
        navigationController?.navigationBar.barTintColor = Constants.UI.Base.backgroundColor
        navigationController?.navigationBar.tintColor = Constants.UI.Base.foregroundColor
        navigationItem.rightBarButtonItem = doneButton
        doneButton.isEnabled = false
        
        buildNoticeLabel(text: TEXT.typeNotice)
        buildTypePicker()
    }
}

extension AddViewController {
    private func buildTypePicker() {
        typePicker.do {
            $0.setTitle("선택", for: .normal)
            $0.setTitleColor(.black, for: .normal)
        }
        view.addSubview(typePicker)
        typePicker.snp.makeConstraints {
            $0.top.equalTo(noticeLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(UI.typePickerSide)
            $0.width.height.equalTo(UI.typePickerSize)
        }
        
        let actionSheet = buildActionSheet()
        typePicker.rx.tap
            .subscribe { [weak self] _ in
                self?.present(actionSheet, animated: true, completion: nil)
        }
        .disposed(by: disposeBag)
    }
    
    private func buildNameLabel(_ type: String) {
        self.noticeLabel.text = type + TEXT.nameNotice
        self.typePicker.isHidden = true
        
        nameTextField.do {
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.borderStyle = .line
            $0.layer.borderWidth = 1
        }
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(noticeLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(UI.nameSide)
            $0.height.equalTo(UI.nameHeight)
        }
        
        nameTextField.rx.text
            .subscribe { [weak self] event in
                guard let text = event.element else { return }
                if (text?.count ?? 0) > 0 { self?.navigationItem.rightBarButtonItem?.isEnabled = true } else { self?.navigationItem.rightBarButtonItem?.isEnabled = false }
        }
        .disposed(by: disposeBag)
    }
    
    private func buildNoticeLabel(text: String) {
        noticeLabel.do {
            $0.text = text
            $0.font = UI.noticeFont
            $0.textColor = UI.noticeColor
            $0.numberOfLines = 10
            $0.lineBreakMode = .byWordWrapping
        }
        
        view.addSubview(noticeLabel)
        noticeLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().offset(UI.noticeSide)
            $0.top.equalToSuperview().inset(self.getTopAreaHeight())
            $0.height.equalTo(UI.noticeHeight)
        }
    }
    
    private func buildActionSheet() -> UIAlertController {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: AnimalType.dog.getAnimalName(), style: .default, handler: { [weak self] _ in
            self?.animal.type = AnimalType.dog
            self?.buildNameLabel(AnimalType.dog.getAnimalName() ?? "")
        }))
        actionSheet.addAction(UIAlertAction(title: AnimalType.cat.getAnimalName(), style: .default, handler: { [weak self] _ in
            self?.animal.type = AnimalType.cat
            self?.buildNameLabel(AnimalType.cat.getAnimalName() ?? "")
        }))
        actionSheet.addAction(UIAlertAction(title: AnimalType.parrot.getAnimalName(), style: .default, handler: { [weak self] _ in
            self?.animal.type = AnimalType.parrot
            self?.buildNameLabel(AnimalType.parrot.getAnimalName() ?? "")
        }))
        actionSheet.addAction(UIAlertAction(title: AnimalType.lizard.getAnimalName(), style: .default, handler: { [weak self] _ in
            self?.animal.type = AnimalType.lizard
            self?.buildNameLabel(AnimalType.lizard.getAnimalName() ?? "")
        }))
        
        return actionSheet
    }
}
