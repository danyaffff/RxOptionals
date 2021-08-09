    import Foundation
    import RxSwift
    import RxCocoa
    import Nimble
    import Quick
    import RxOptionals

    final class RxOptionalsSpec: QuickSpec {
        override func spec() {
            context("subscribe") {
                it("subscribe nil") {
                    let nilBinder: Binder<Int>? = nil
                    let potentialDisposable = Observable.just(0).subscribe(nilBinder)
                    expect(potentialDisposable).to(beNil())
                    potentialDisposable?.dispose()
                }
                
                it("subscribe optional") {
                    let optionalBinder: Binder<Int>? = {
                        Binder(self) { (_, value: Int) in
                            expect(value).to(equal(0))
                        }
                    }()
                    let potentialDisposable = Observable.just(0).subscribe(optionalBinder)
                    expect(potentialDisposable).toNot(beNil())
                    potentialDisposable?.dispose()
                }
            }
            
            context("drive") {
                it("drive nil") {
                    let nilBinder: Binder<Int>? = nil
                    let potentialDisposable = Driver.just(0).drive(nilBinder)
                    expect(potentialDisposable).to(beNil())
                    potentialDisposable?.dispose()
                }
                
                it("drive optional") {
                    let optionalBinder: Binder<Int>? = {
                        Binder(self) { (_, value: Int) in
                            expect(value).to(equal(0))
                        }
                    }()
                    let potentialDisposable = Driver.just(0).drive(optionalBinder)
                    expect(potentialDisposable).toNot(beNil())
                    potentialDisposable?.dispose()
                }
                
                it("drive multiple nil and one not nil") {
                    let nilBinder0: Binder<Int>? = nil
                    let nilBinder1: Binder<Int>? = nil
                    let nilBinder2: Binder<Int>? = nil
                    let nilBinder3: Binder<Int>? = nil
                    let optionalBinder: Binder<Int>? = {
                        Binder(self) { (_, value: Int) in
                            expect(value).to(equal(0))
                        }
                    }()
                    let potentialDisposable = Driver.just(0).drive(nilBinder0, nilBinder1, nilBinder2, nilBinder3, optionalBinder)
                    expect(potentialDisposable).toNot(beNil())
                    potentialDisposable?.dispose()
                }
            }
            
            context("bind") {
                it("bind(to:) nil") {
                    let nilBinder: Binder<Int>? = nil
                    let potentialDisposable = Observable.just(0).bind(to: nilBinder)
                    expect(potentialDisposable).to(beNil())
                    potentialDisposable?.dispose()
                }
                
                it("bind(to:) optional") {
                    let optionalBinder: Binder<Int>? = {
                        Binder(self) { (_, value: Int) in
                            expect(value).to(equal(0))
                        }
                    }()
                    let potentialDisposable = Observable.just(0).bind(to: optionalBinder)
                    expect(potentialDisposable).toNot(beNil())
                    potentialDisposable?.dispose()
                }
                
                it("bind(onNext:) with element nil") {
                    let nilClosure: ((Int) -> Void)? = nil
                    Observable.just(0).bind(onNext: nilClosure).dispose()
                }
                
                it("bind(onNext:) with element optional") {
                    let optionalClosure: ((Int) -> Void)? = {
                        expect($0).to(equal(0))
                    }
                    Observable.just(0).bind(onNext: optionalClosure).dispose()
                }
                
                it("bind(onNext:) without element nil") {
                    let nilClosure: (() -> Void)? = nil
                    Observable.just(0).bind(onNext: nilClosure).dispose()
                }
                
                it("bind(onNext:) without element optional") {
                    let notification = Notification(name: Notification.Name("Test"))
                    let optionalClosure: (() -> Void)? = { NotificationCenter.default.post(notification) }
                    expect {
                        Observable.just(0).bind(onNext: optionalClosure).dispose()
                    }.to(postNotifications(equal([notification])))
                }
            }

            context("combineLatest") {
                it("combineLatest(_:_:) nil nil") {
                    let disposeBag = DisposeBag()
                    let firstSubject: PublishSubject<Bool>? = nil
                    let secondSubject: PublishSubject<Bool>? = nil
                    Observable.combineLatest(firstSubject, secondSubject)?.map { $0 && $1 }.subscribe(onNext: { _ in
                        fail()
                    }).disposed(by: disposeBag)
                    firstSubject?.onNext(true)
                    secondSubject?.onNext(true)
                }
                
                it("combineLatest(_:_:) optional nil") {
                    let disposeBag = DisposeBag()
                    let firstSubject: PublishSubject<Bool>? = PublishSubject()
                    let secondSubject: PublishSubject<Bool>? = nil
                    Observable.combineLatest(firstSubject, secondSubject)?.map { $0 && $1 }.subscribe(onNext: { _ in
                        fail()
                    }).disposed(by: disposeBag)
                    firstSubject?.onNext(true)
                    secondSubject?.onNext(true)
                }
                
                it("combineLatest(_:_:) optional optional") {
                    let disposeBag = DisposeBag()
                    let firstSubject: PublishSubject<Bool>? = PublishSubject()
                    let secondSubject: PublishSubject<Bool>? = PublishSubject()
                    Observable.combineLatest(firstSubject, secondSubject)?.map { $0 && $1 }.subscribe(onNext: { value in
                        expect(value).to(equal(true))
                    }).disposed(by: disposeBag)
                    firstSubject?.onNext(true)
                    secondSubject?.onNext(true)
                }
            }
            
            context("disposable") {
                it("disposeBag nil") {
                    var nilDisposeBag: DisposeBag? = nil
                    let subject = PublishSubject<Int>()
                    subject.subscribe(onNext: { _ in
                        fail("This shouldn't be called")
                    }).disposed(by: nilDisposeBag)
                    subject.onNext(0)
                    nilDisposeBag = DisposeBag()
                }
                
                it("disposeBag optional") {
                    var nilDisposeBag: DisposeBag? = DisposeBag()
                    let subject = PublishSubject<Int>()
                    subject.subscribe(onNext: { value in
                        expect(value).to(equal(0))
                    }).disposed(by: nilDisposeBag)
                    subject.onNext(0)
                    nilDisposeBag = DisposeBag()
                }
            }
        }
    }
