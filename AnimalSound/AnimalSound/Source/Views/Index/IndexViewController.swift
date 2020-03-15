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
    }
    
    override func layout() {
        navigationController?.navigationBar.barTintColor = Constants.UI.Base.backgroundColor
        navigationItem.title = "동물원 소리"
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
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(self.getTopAreaHeight())
        }
    }
}

extension IndexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "삭제") { [weak self] (_, indexPath) in
            guard let cellDate = (self?.tableView.cellForRow(at: indexPath) as! AnimalListCell).id else { return }
            
        }
        
        return [delete]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AnimalListCell else { return }
        
    }
}
