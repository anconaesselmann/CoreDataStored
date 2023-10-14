// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreDataStored",
    platforms: [
        .macOS(.v12),
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "CoreDataStored",
            targets: ["CoreDataStored"]),
    ],
    targets: [
        .target(
            name: "CoreDataStored"),
    ]
)
