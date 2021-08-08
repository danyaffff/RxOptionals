//
//  ObservableConvertibleType+OptionalBind.swift
//  RxOptionals
//
//  Created by Даниил Храповицкий on 04.08.2021.
//

#if !RX_NO_MODULE

import RxSwift
import RxCocoa

#endif

public extension ObservableConvertibleType {
    
    /// Creates new subscription to `Observable` and sends elements to existed observer(s).
    /// In case error occurs in debug mode, `fatalError` will be raised.
    /// In case error occurs in release mode, `error` will be logged.
    /// - Parameter observers: Optional observers to receives events.
    /// - Warning: Uses `unsafeBitCast(_:to:)`.
    /// - Returns: Disposable object that can be used to unsubscribe the observers.
    func bind<Observer: ObserverType>(to observers: Observer?...) -> Disposable where Element == Observer.Element {
        bind(to: observers)
    }
    
    /// Creates new subscription to `Observable` and sends elements to existed observer(s).
    /// - Parameter observers: Optional observers to receives events.
    /// - Warning: Uses `unsafeBitCast(_:to:)`.
    /// - Returns: Disposable object that can be used to unsubscribe the observers.
    func bind<Observer: ObserverType>(to observers: [Observer?]) -> Disposable where Element == Observer.Element {
        let unwrappedObservers = observers.compactMap { $0 }
        let bind: (Observer...) -> Disposable = asObservable().bind(to:)
        return unsafeBitCast(bind, to: (([Observer]) -> Disposable).self)(unwrappedObservers)
    }
    
    /// Creates new subscription to `Observable` and sends elements to existed publish relay(s).
    /// In case error occurs in debug mode, `fatalError` will be raised.
    /// In case error occurs in release mode, `error` will be logged.
    /// - Parameter relays: Target optional publish relays for sequence elements.
    /// - Warning: Uses `unsafeBitCast(_:to:)`.
    /// - Returns: Disposable object that can be used to unsubscribe the observer.
    func bind(to relays: PublishRelay<Element>?...) -> Disposable {
        bind(to: relays)
    }
    
    /// Creates new subscription to `Observable` and sends elements to existed publish relay(s).
    /// In case error occurs in debug mode, `fatalError` will be raised.
    /// In case error occurs in release mode, `error` will be logged.
    /// - Parameter relays: Target optional publish relays for sequence elements.
    /// - Warning: Uses `unsafeBitCast(_:to:)`.
    /// - Returns: Disposable object that can be used to unsubscribe the observer.
    func bind(to relays: [PublishRelay<Element>?]) -> Disposable {
        let unwrappedRelays = relays.compactMap { $0 }
        let bind: (PublishRelay<Element>...) -> Disposable = asObservable().bind(to:)
        return unsafeBitCast(bind, to: (([PublishRelay]) -> Disposable).self)(unwrappedRelays)
    }
    
    /// Creates new subscription to `Observable` and sends elements to existed behavior relay(s).
    /// In case error occurs in debug mode, `fatalError` will be raised.
    /// In case error occurs in release mode, `error` will be logged.
    /// - Parameter relays: Target optional behavior relays for sequence elements.
    /// - Warning: Uses `unsafeBitCast(_:to:)`.
    /// - Returns: Disposable object that can be used to unsubscribe the observer.
    func bind(to relays: BehaviorRelay<Element>?...) -> Disposable {
        bind(to: relays)
    }
    
    /// Creates new subscription to `Observable` and sends elements to existed behavior relay(s).
    /// In case error occurs in debug mode, `fatalError` will be raised.
    /// In case error occurs in release mode, `error` will be logged.
    /// - Parameter relays: Target optional behavior relays for sequence elements.
    /// - Warning: Uses `unsafeBitCast(_:to:)`.
    /// - Returns: Disposable object that can be used to unsubscribe the observer.
    func bind(to relays: [BehaviorRelay<Element>?]) -> Disposable {
        let unwrappedRelays = relays.compactMap { $0 }
        let bind: (BehaviorRelay<Element>...) -> Disposable = asObservable().bind(to:)
        return unsafeBitCast(bind, to: (([BehaviorRelay]) -> Disposable).self)(unwrappedRelays)
    }
}
