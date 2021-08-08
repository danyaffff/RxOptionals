//
//  ObservableType+OptionalCombineLatest.swift
//  RxOptionals
//
//  Created by Даниил Храповицкий on 04.08.2021.
//

#if !RX_NO_MODULE

import RxSwift
import RxCocoa

#endif

public extension ObservableType {
    
    /**
    Subscribes optional `observer` to receive events for this sequence.
    
    ### Grammar
    
    **Next\* (Error | Completed)?**
    
    * sequences can produce zero or more elements so zero or more `Next` events can be sent to `observer`
    * once an `Error` or `Completed` event is sent, the sequence terminates and can't produce any other elements
    
    It is possible that events are sent from different threads, but no two events can be sent concurrently to
    `observer`.
    
    ### Resource Management
    
    When sequence sends `Complete` or `Error` event all internal resources that compute sequence elements
    will be freed.
    
    To cancel production of sequence elements and free resources immediately, call `dispose` on returned
    subscription.
    
    - returns: Subscription for `observer` that can be used to cancel production of sequence elements and free resources.
    */
    func subscribe<Observer: ObserverType>(_ observer: Observer?) -> Disposable? where Element == Observer.Element {
        guard let observer = observer else { return nil }
        return subscribe(observer)
    }
}

// MARK: - bind
public extension ObservableType {
    
    /// Creates new subscription to `Observable` and sends elements to existed observer(s).
    /// In case error occurs in debug mode, `fatalError` will be raised.
    /// In case error occurs in release mode, `error` will be logged.
    /// - Parameter observers: Optional observers to receives events.
    /// - Warning: Uses `unsafeBitCast(_:to:)`.
    /// - Returns: Disposable object that can be used to unsubscribe the observers.
    func bind<Observer: ObserverType>(to observers: Observer?...) -> Disposable? where Element == Observer.Element {
        bind(to: observers)
    }
    
    /// Creates new subscription to `Observable` and sends elements to existed observer(s).
    /// - Parameter observers: Optional observers to receives events.
    /// - Warning: Uses `unsafeBitCast(_:to:)`.
    /// - Returns: Disposable object that can be used to unsubscribe the observers.
    func bind<Observer: ObserverType>(to observers: [Observer?]) -> Disposable? where Element == Observer.Element {
        let unwrappedObservers = observers.compactMap { $0 }
        guard unwrappedObservers.count > 0 else { return nil }
        let bind: (Observer...) -> Disposable = bind(to:)
        return unsafeBitCast(bind, to: (([Observer]) -> Disposable).self)(unwrappedObservers)
    }
    
    /// Subscribes an optional element handler to an observable sequence.
    /// In case error occurs in debug mode, `fatalError` will be raised.
    /// In case error occurs in release mode, `error` will be logged.
    /// - Parameter onNext: Action to invoke for each element in the observable sequence.
    /// - Returns: Disposable object that can be used to unsubscribe the observers.
    func bind(onNext: ((Element) -> Void)?) -> Disposable {
        let unwrappedClosure: (Element) -> Void = { element in onNext?(element) }
        return bind(onNext: unwrappedClosure)
    }
    
    /// Subscribes an optional empty handler to an observable sequence.
    /// In case error occurs in debug mode, `fatalError` will be raised.
    /// In case error occurs in release mode, `error` will be logged.
    /// - Parameter onNext: Action to invoke for each element in the observable sequence.
    /// - Returns: Disposable object that can be used to unsubscribe the observers.
    func bind(onNext: (() -> Void)?) -> Disposable {
        let unwrappedClosure: (Element) -> Void = { _ in onNext?() }
        return bind(onNext: unwrappedClosure)
    }
}

// MARK: - combineLatest
public extension ObservableType where Element == Any {
    
    /// Merges the specified optinal observable sequences into one observable sequence of tuples whenever any of the observable sequences produces an element.
    /// - Returns: An optional observable sequence containing the result of combining elements of the sources.
    static func combineLatest<O1: ObservableType, O2: ObservableType>(_ source1: O1?, _ source2: O2?) -> Observable<(O1.Element, O2.Element)>? {
        guard let unwrappedSource1 = source1?.asObservable(), let unwrappedSource2 = source2?.asObservable() else { return nil }
        return Observable.combineLatest(unwrappedSource1, unwrappedSource2)
    }
    
    /// Merges the specified optinal observable sequences into one observable sequence of tuples whenever any of the observable sequences produces an element.
    /// - Returns: An optional observable sequence containing the result of combining elements of the sources.
    static func combineLatest<O1: ObservableType, O2: ObservableType, O3: ObservableType>(_ source1: O1?, _ source2: O2?, _ source3: O3?) -> Observable<(O1.Element, O2.Element, O3.Element)>? {
        guard let unwrappedSource1 = source1, let unwrappedSource2 = source2, let unwrappedSource3 = source3 else { return nil }
        return Observable.combineLatest(unwrappedSource1, unwrappedSource2, unwrappedSource3)
    }
    
    /// Merges the specified optinal observable sequences into one observable sequence of tuples whenever any of the observable sequences produces an element.
    /// - Returns: An optional observable sequence containing the result of combining elements of the sources.
    static func combineLatest<O1: ObservableType, O2: ObservableType, O3: ObservableType, O4: ObservableType>(_ source1: O1?, _ source2: O2?, _ source3: O3?, _ source4: O4?) -> Observable<(O1.Element, O2.Element, O3.Element, O4.Element)>? {
        guard let unwrappedSource1 = source1, let unwrappedSource2 = source2, let unwrappedSource3 = source3, let unwrappedSource4 = source4 else { return nil }
        return Observable.combineLatest(unwrappedSource1, unwrappedSource2, unwrappedSource3, unwrappedSource4)
    }
    
    /// Merges the specified optinal observable sequences into one observable sequence of tuples whenever any of the observable sequences produces an element.
    /// - Returns: An optional observable sequence containing the result of combining elements of the sources.
    static func combineLatest<O1: ObservableType, O2: ObservableType, O3: ObservableType, O4: ObservableType, O5: ObservableType>(_ source1: O1?, _ source2: O2?, _ source3: O3?, _ source4: O4?, _ source5: O5?) -> Observable<(O1.Element, O2.Element, O3.Element, O4.Element,  O5.Element)>? {
        guard let unwrappedSource1 = source1, let unwrappedSource2 = source2, let unwrappedSource3 = source3, let unwrappedSource4 = source4, let unwrappedSource5 = source5 else { return nil }
        return Observable.combineLatest(unwrappedSource1, unwrappedSource2, unwrappedSource3, unwrappedSource4, unwrappedSource5)
    }
    
    /// Merges the specified optinal observable sequences into one observable sequence of tuples whenever any of the observable sequences produces an element.
    /// - Returns: An optional observable sequence containing the result of combining elements of the sources.
    static func combineLatest<O1: ObservableType, O2: ObservableType, O3: ObservableType, O4: ObservableType, O5: ObservableType, O6: ObservableType>(_ source1: O1?, _ source2: O2?, _ source3: O3?, _ source4: O4?, _ source5: O5?, _ source6: O6?) -> Observable<(O1.Element, O2.Element, O3.Element, O4.Element,  O5.Element, O6.Element)>? {
        guard let unwrappedSource1 = source1, let unwrappedSource2 = source2, let unwrappedSource3 = source3, let unwrappedSource4 = source4, let unwrappedSource5 = source5, let unwrappedSource6 = source6 else { return nil }
        return Observable.combineLatest(unwrappedSource1, unwrappedSource2, unwrappedSource3, unwrappedSource4, unwrappedSource5, unwrappedSource6)
    }
    
    /// Merges the specified optinal observable sequences into one observable sequence of tuples whenever any of the observable sequences produces an element.
    /// - Returns: An optional observable sequence containing the result of combining elements of the sources.
    static func combineLatest<O1: ObservableType, O2: ObservableType, O3: ObservableType, O4: ObservableType, O5: ObservableType, O6: ObservableType, O7: ObservableType>(_ source1: O1?, _ source2: O2?, _ source3: O3?, _ source4: O4?, _ source5: O5?, _ source6: O6?, _ source7: O7?) -> Observable<(O1.Element, O2.Element, O3.Element, O4.Element,  O5.Element, O6.Element, O7.Element)>? {
        guard let unwrappedSource1 = source1, let unwrappedSource2 = source2, let unwrappedSource3 = source3, let unwrappedSource4 = source4, let unwrappedSource5 = source5, let unwrappedSource6 = source6, let unwrappedSource7 = source7 else { return nil }
        return Observable.combineLatest(unwrappedSource1, unwrappedSource2, unwrappedSource3, unwrappedSource4, unwrappedSource5, unwrappedSource6, unwrappedSource7)
    }
    
    /// Merges the specified optinal observable sequences into one observable sequence of tuples whenever any of the observable sequences produces an element.
    /// - Returns: An optional observable sequence containing the result of combining elements of the sources.
    static func combineLatest<O1: ObservableType, O2: ObservableType, O3: ObservableType, O4: ObservableType, O5: ObservableType, O6: ObservableType, O7: ObservableType, O8: ObservableType>(_ source1: O1?, _ source2: O2?, _ source3: O3?, _ source4: O4?, _ source5: O5?, _ source6: O6?, _ source7: O7?, _ source8: O8?) -> Observable<(O1.Element, O2.Element, O3.Element, O4.Element,  O5.Element, O6.Element, O7.Element, O8.Element)>? {
        guard let unwrappedSource1 = source1, let unwrappedSource2 = source2, let unwrappedSource3 = source3, let unwrappedSource4 = source4, let unwrappedSource5 = source5, let unwrappedSource6 = source6, let unwrappedSource7 = source7, let unwrappedSource8 = source8 else { return nil }
        return Observable.combineLatest(unwrappedSource1, unwrappedSource2, unwrappedSource3, unwrappedSource4, unwrappedSource5, unwrappedSource6, unwrappedSource7, unwrappedSource8)
    }
}
