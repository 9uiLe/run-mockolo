import Foundation
import PackagePlugin

@main
struct RunMockoloPlugin: BuildToolPlugin {
    func createBuildCommands(
        context: PluginContext,
        target: Target
    ) async throws -> [Command] {
        guard let targetURL = URL(string: target.directory.string) else {
            throw RunMockoloError.invalidURL(target.directory.string)
        }
        let engine = try RunMockoloEngine(
            pluginWorkDirectory: context.pluginWorkDirectoryURL,
            targetUrl: targetURL,
            mockoloPath: context.tool(named: "mockolo").url
        )
        return engine.build()
    }
}

#if canImport(XcodeProjectPlugin)
    import XcodeProjectPlugin

    extension RunMockoloPlugin: XcodeBuildToolPlugin {

        func createBuildCommands(
            context: XcodeProjectPlugin.XcodePluginContext,
            target: XcodeProjectPlugin
                .XcodeTarget
        ) throws -> [PackagePlugin.Command] {

            let engine = try RunMockoloEngine(
                pluginWorkDirectory: context.pluginWorkDirectoryURL,
                targetUrl: context.xcodeProject.directoryURL,
                mockoloPath: context.tool(named: "mockolo").url
            )
            return engine.build()
        }
    }

#endif

struct RunMockoloEngine {

    let pluginWorkDirectory: URL
    let targetUrl: URL
    let mockoloPath: URL

    func build() -> [Command] {

        let generatedSourcePath = pluginWorkDirectory.appending(
            component: "GeneratedMocks.swift"
        )

        return [
            .prebuildCommand(
                displayName: "Run mockolo",
                executable: mockoloPath,
                arguments: [
                    "-s", targetUrl.path(),
                    "-d", generatedSourcePath.path(),
                ],
                outputFilesDirectory: pluginWorkDirectory
            )
        ]
    }
}
