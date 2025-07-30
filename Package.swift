// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "run-mockolo",
    products: [
        .plugin(name: "Core", targets: ["Core"])
    ],
    dependencies: [
        .package(url: "https://github.com/uber/mockolo", exact: "2.4.0")
    ],
    targets: [
        .plugin(
            name: "Core",
            capability: .buildTool(),
            dependencies: [.target(name: "mockolo")]
        ),
        .binaryTarget(
            name: "mockolo",
            url: "https://github.com/uber/mockolo/releases/download/2.4.0/mockolo.artifactbundle.zip",
            checksum: "740787a5c532dc1a16e9b6940c7ef844caa1f7c02cb85b740e4f44f49a25dc68"
        )
    ]
)
