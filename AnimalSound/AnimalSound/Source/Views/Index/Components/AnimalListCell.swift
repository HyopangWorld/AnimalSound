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
import Then

class AnimalListCell: UITableViewCell {
    typealias CellData = (date: Date, type: AnimalType, name: String)
    private typealias UI = Constants.UI.IndexCell
    
    let typeLabel = UILabel()
    let nameLabel = UILabel()
    let emojiLabel = UILabel()
    
    var date: Date?
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
        emojiLabel.text = nil
    }
    
    func setData(data: CellData) {
        date = data.date
        type = data.type
        typeLabel.text = data.type.getAnimalName()
        emojiLabel.text = data.type.getAnimalEmoji()
        nameLabel.text = data.name
    }
    
    private func layout() {
        self.backgroundColor = Constants.UI.Base.backgroundColor
        
        emojiLabel.font = UI.emojiFont
        self.addSubview(emojiLabel)
        emojiLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(UI.sideMargin)
            $0.width.equalTo(UI.emojiHeight)
            $0.height.equalToSuperview()
        }
        
        typeLabel.font = UI.typeFont
        self.addSubview(typeLabel)
        typeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(UI.sideMargin)
            $0.width.equalTo(UI.typeHeight)
            $0.centerY.equalToSuperview()
        }
        
        nameLabel.font = UI.nameFont
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(emojiLabel.snp.trailing).offset(UI.sideMargin)
            $0.trailing.equalTo(typeLabel.snp.leading).inset(UI.sideMargin)
            $0.centerY.equalToSuperview()
        }
    }
}
