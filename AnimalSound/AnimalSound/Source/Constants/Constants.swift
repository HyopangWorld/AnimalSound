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
        }
    }
}
