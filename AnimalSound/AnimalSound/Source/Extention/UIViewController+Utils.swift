//
//  UIViewController+Utils.swift
//  AnimalSound
//
//  Created by 김효원 on 15/03/2020.
//  Copyright © 2020 김효원. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

extension UIViewController {
    func getTopAreaHeight() -> CGFloat {
        return (UIApplication.shared.statusBarFrame.size.height + (navigationController?.navigationBar.frame.height ?? 0))
    }
    
    func setTouchEndEditing(disposeBag: DisposeBag) {
        view.rx.tapGesture()
            .subscribe(onNext: { [weak self] _ in self?.view.endEditing(true) })
            .disposed(by: disposeBag)
    }
}
