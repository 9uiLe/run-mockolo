# run-mockolo
Mockolo を Swift Package Manager を利用して、導入するための Plugin

## 使い方

### 1. Package.swift で Plugin を設定する

```swift
// MARK: - Plugin

let runMockoloPlugin = Target.PluginUsage.plugin(
    name: "RunMockolo",
    package: "run-mockolo"
)

// MARK: - Module

let interface = Target.target(
    name: "Interface",
    ...
    plugins: [
        runMockoloPlugin
    ]
)

// MARK: - Package
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/9uiLe/run-mockolo", exact: "1.0.1")
    ]
    ...
)
```

### 2. ビルドする

- Xcode でビルドを行う。もしくは `swift build` を実行する

Derived Data 配下にファイルが生成され、DEBUGビルド時のみ利用可能

```text
DerivedData/.../Build/Intermediates.noindex/Plugins/{YOUR MODULE}/MockoloPlugin/.../MockoloMocks.swift
```

## 参考

- [🔗 uber/mockolo](https://github.com/uber/mockolo)
- [🔗 MockoloをSPMで導入する](https://qiita.com/stotic-dev/items/e799f03d59d1c4ac0aac)
