//
//  AnimalCell.swift
//  AnimalSound
//
//  Created by 김효원 on 15/03/2020.
//  Copyright © 2020 김효원. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Kingfisher
import Then

class AnimalListCell: UITableViewCell {
    typealias CellData = (id: Int, type: AnimalType, name: String)
    private typealias UI = Constants.UI.IndexCell
    
    let typeLabel = UILabel()
    let nameLabel = UILabel()
    
    var id: Int?
    var type: AnimalType?
    
    override init(style: UITableViewCell.CellStyle = .default, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        typeLabel.text = nil
        nameLabel.text = nil
    }
    
    func setData(data: CellData) {
        id = data.id
        type = data.type
        typeLabel.text = "\(data.type)"
        nameLabel.text = data.name
    }
    
    private func layout() {
        self.backgroundColor = Constants.UI.Base.backgroundColor
        
        nameLabel.font = UI.nameFont
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(UI.sideMargin)
            $0.width.equalToSuperview().dividedBy(2)
            $0.centerY.equalToSuperview()
        }
        
        typeLabel.font = UI.typeFont
        self.addSubview(typeLabel)
        typeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(UI.sideMargin)
            $0.centerY.equalToSuperview()
        }
    }
}
