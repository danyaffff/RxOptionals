# RxOptionals

Sometimes it happens that you need to bind to several optional binders or to an optional method (for example, when using `weak`). To do this, we can resort to large constructs with `guard`, `if`, weak capturing and others.

```swift
weak var someController: SomeController?

func bind() {
    guard let binder = someController?.someView.rx.someBinder else { /*...*/ }
    someRelay.bind(to: binder).disposed(by: bag)
}
```

The `guard` construction looks a bit messy and it would be great to remove it (and put inside called function).

```swift
weak var someController: SomeController?

func bind() {
    someRelay.bind(to: someController?.someView.rx.someBinder).disposed(by: bag)
}
```

It may seem that not so much changes and that the code is getting longer, but after a while you will realize that you saved a lot of time and space, and were able to write cleaner and more functional code (because optionals were created for this) ;)

## Installation
You could install package via [Swift Package manager](https://swift.org/package-manager/):
1. In Xcode, open your project and navigate to File → Swift Packages → Add Package Dependency...
2. Paste the repository URL (https://github.com/danyaffff/RxOptionals) and click Next.
3. For Rules, select Branch (and set __main__ branch) and click Next.
4. Add library to desired Target and click Finish.
