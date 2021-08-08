//
//  Disposable+Optionals.swift
//  RxOptionals
//
//  Created by Даниил Храповицкий on 04.08.2021.
//

#if !RX_NO_MODULE

import RxSwift

#endif

public extension Disposable {
    
    /// If `DisposeBag` not exists, disposes `Observable` immediately.
    /// - Parameter bag: `DisposeBag` to add `self` to.
    func disposed(by bag: DisposeBag?) {
        if let bag = bag {
            disposed(by: bag)
        } else {
            self.dispose()
        }
    }
}
