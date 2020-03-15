//
//  Constants.swift
//  AnimalSound
//
//  Created by 김효원 on 15/03/2020.
//  Copyright © 2020 김효원. All rights reserved.
//

import Foundation
import UIKit

public struct Constants {
    struct UI {
        struct Base {
            static let backgroundColor: UIColor = UIColor(displayP3Red: (244/255), green: (244/255), blue: (244/255), alpha: 1)
            static let foregroundColor: UIColor = UIColor(displayP3Red: (250/255), green: (174/255), blue: (9/255), alpha: 1)
            @available(iOS 11.0, *)
            static let safeAreaInsetsTop: CGFloat = (UIApplication.shared.windows.first { $0.isKeyWindow })?.safeAreaInsets.top ?? 0
            static let toolBarHeight: CGFloat = 50
            static let lineHeight: CGFloat = 1
        }
        
        struct IndexCell {
            static let height: CGFloat = 65
            static let sideMargin: CGFloat = 20
            
            static let emojiFont: UIFont = .systemFont(ofSize: 35)
            static let emojiHeight: CGFloat = 50
            
            static let nameFont: UIFont = .systemFont(ofSize: 20)
            static let nameColor: UIColor = UIColor(displayP3Red: (24/255), green: (24/255), blue: (24/255), alpha: 1)
            static let nameTopMargin: CGFloat = 5
            
            static let typeFont: UIFont = .systemFont(ofSize: 15)
            static let typeColor: UIColor = UIColor(displayP3Red: (180/255), green: (180/255), blue: (180/255), alpha: 1)
            static let typeHeight: CGFloat = 50
        }
        
        struct Add {
            static let noticeFont: UIFont = .systemFont(ofSize: 35, weight: .bold)
            static let noticeColor: UIColor = UIColor(displayP3Red: (180/255), green: (180/255), blue: (180/255), alpha: 1)
            
            static let typePickerSide: CGFloat = 10
            static let typePickerSize: CGFloat = 50
            
            static let nameSide: CGFloat = 20
            static let nameHeight: CGFloat = 50
            
            static let noticeSide: CGFloat = 10
            static let noticeHeight: CGFloat = 100
        }
    }
    
    struct TEXT {
        struct Add {
            static let typeNotice = "이 동물은 어떤 종류인가요?"
            static let nameNotice = "의 이름은 무엇인가요?"
        }
    }
}
