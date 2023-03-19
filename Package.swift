// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "wordle-cli",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "SwiftCursesTerm", url: "https://github.com/rderik/SwiftCursesTerm.git", from: "0.1.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "wordle",
            dependencies: []),
        .executableTarget(
            name: "wordle-cli",
            dependencies: ["wordle"]),
        .executableTarget(name: "ncurses-mock",
                          linkerSettings:[LinkerSetting.linkedLibrary("ncurses")]),
        .executableTarget(name: "swift-curses-mock1",
                          linkerSettings:[LinkerSetting.linkedLibrary("ncurses")]),
        .executableTarget(name: "swift-curses-mock2",
                          dependencies: ["SwiftCursesTerm"]),
        .executableTarget(name: "wordle-tui",
                          dependencies: ["wordle", "SwiftCursesTerm"]),
        .testTarget(
            name: "wordle-cliTests",
            dependencies: ["wordle-cli"]),
    ]
)
