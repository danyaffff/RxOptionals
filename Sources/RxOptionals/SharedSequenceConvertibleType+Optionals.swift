//
//  SharedSequenceConvertibleType+Optionals.swift
//  RxOptionals
//
//  Created by Даниил Храповицкий on 09.08.2021.
//

#if !RX_NO_MODULE

import RxSwift
import RxCocoa

#endif

// MARK: - drive
public extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {
    
    /**
     Creates new subscription and sends elements to optional observer.
     This method can be only called from `MainThread`.
     
     In this form it's equivalent to `subscribe` method, but it communicates intent better.
     
     - parameter observers: Optional observers that receives events.
     - warning: Uses `unsafeBitCast(_:to:)`.
     - returns: Disposable object that can be used to unsubscribe the observer from the subject.
     */
    func drive<Observer: ObserverType>(_ observers: Observer?...) -> Disposable? where Element == Observer.Element {
        drive(observers)
    }
    
    /**
     Creates new subscription and sends elements to observer.
     This method can be only called from `MainThread`.
     
     In this form it's equivalent to `subscribe` method, but it communicates intent better.
     
     - parameter observers: Array of optional observers that receives events.
     - warning: Uses `unsafeBitCast(_:to:)`.
     - returns: Disposable object that can be used to unsubscribe the observer from the subject.
     */
    func drive<Observer: ObserverType>(_ observers: [Observer?]) -> Disposable? where Element == Observer.Element {
        let unwrappedObservers = observers.compactMap { $0 }
        guard unwrappedObservers.count > 0 else { return nil }
        let drive: (Observer...) -> Disposable = drive
        return unsafeBitCast(drive, to: (([Observer]) -> Disposable).self)(unwrappedObservers)
    }
}
