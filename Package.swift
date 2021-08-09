// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxOptionals",
    platforms: [.macOS(.v10_10), .iOS(.v9), .tvOS(.v9), .watchOS(.v3)],
    products: [
        .library(name: "RxOptionals", targets: ["RxOptionals"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.2.0")),
        
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "9.2.0"))
    ],
    targets: [
        .target(name: "RxOptionals", dependencies: [
            .product(name: "RxSwift", package: "RxSwift"),
            .product(name: "RxCocoa", package: "RxSwift")
        ], exclude: [
            "Supporting Files/Info.plist"
        ]),
        .testTarget(name: "RxOptionalsTests", dependencies: [
            "RxOptionals",
            .product(name: "RxSwift", package: "RxSwift"),
            .product(name: "RxCocoa", package: "RxSwift"),
            .product(name: "Quick", package: "Quick"),
            .product(name: "Nimble", package: "Nimble")
        ]),
    ],
    swiftLanguageVersions: [.v5]
)
