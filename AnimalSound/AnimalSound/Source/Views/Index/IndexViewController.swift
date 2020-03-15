//
//  ViewController.swift
//  AnimalSound
//
//  Created by 김효원 on 13/03/2020.
//  Copyright © 2020 김효원. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAppState
import RxDataSources
import Then
import SnapKit

protocol IndexViewBindable {
    var viewWillAppear: PublishRelay<Void> { get }
    var deleteData: PublishRelay<Date> { get }
    var cellData: Driver<[AnimalListCell.CellData]> { get }
    var reloadList: Signal<Void> { get }
}

final class IndexViewController: ViewController<IndexViewBindable> {
    let tableView = UITableView()
    
    let deleteAnimal = PublishRelay<Date>()
    
    override func bind(_ viewModel: IndexViewBindable) {
        self.disposeBag = DisposeBag()
        
        self.rx.viewWillAppear
            .map{ _ in Void() }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)
        
        viewModel.cellData
            .drive(tableView.rx.items(cellIdentifier: String(describing: AnimalListCell.self), cellType: AnimalListCell.self)) { _, data, cell in
                cell.setData(data: data)
            }
            .disposed(by: disposeBag)
        
        viewModel.reloadList
            .emit(onNext: { [weak self] _ in self?.tableView.reloadData() })
            .disposed(by: disposeBag)
        
        self.deleteAnimal
            .bind(to: viewModel.deleteData)
            .disposed(by: disposeBag)
    }
    
    override func layout() {
        navigationController?.navigationBar.barTintColor = Constants.UI.Base.backgroundColor
        navigationItem.title = "동물원"
        navigationItem.rightBarButtonItem = buildAddBtn()
        view.backgroundColor = Constants.UI.Base.backgroundColor
        
        buildMemoList()
    }
}

extension IndexViewController {
    private func buildMemoList() {
        tableView.do {
            $0.register(AnimalListCell.self, forCellReuseIdentifier: String(describing: AnimalListCell.self))
            $0.backgroundColor = Constants.UI.Base.backgroundColor
            $0.separatorInset.left = Constants.UI.IndexCell.sideMargin
            $0.separatorInset.right = Constants.UI.IndexCell.sideMargin
            $0.rowHeight = Constants.UI.IndexCell.height
            $0.delegate = self
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func buildAddBtn() -> UIBarButtonItem {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        
        button.rx.tap
        .subscribe(onNext: { [weak self] _ in
            let addViewController = AddViewController()
            let addViewModel = AddViewModel()
            addViewController.bind(addViewModel)
            self?.navigationController?.pushViewController(addViewController, animated: true)
        })
        .disposed(by: disposeBag)
        
        return button
    }
    
    private func buildSoundAlert(type: AnimalType){
        let alert = UIAlertController(title: nil, message: type.getAnimalSound(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension IndexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "삭제") { [weak self] (_, indexPath) in
            guard let cellDate = (self?.tableView.cellForRow(at: indexPath) as! AnimalListCell).date else { return }
            self?.deleteAnimal.accept(cellDate)
        }
        
        return [delete]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AnimalListCell else { return }
        guard let type = cell.type else { return }
        if type == AnimalType.lizard { return }
        
        buildSoundAlert(type: type)
    }
}
