/**
 *  Bash
 *  Copyright (c) Elias Abel 2018
 *  Licensed under the MIT license. See LICENSE.md file.
 */

import Foundation
import Dispatch

// MARK: - API

struct Bash {
    /**
     *  Run a shell command using Bash
     *
     *  - parameter command: The command to run
     *  - parameter arguments: The arguments to pass to the command
     *  - parameter path: The path to execute the commands at
     *  - parameter outputHandle: Any `FileHandle` that any output (STDOUT) should be redirected to
     *              (at the moment this is only supported on macOS)
     *  - parameter errorHandle: Any `FileHandle` that any error output (STDERR) should be redirected to
     *              (at the moment this is only supported on macOS)
     *
     *  - returns: The output of running the command
     *  - throws: `BashError` in case the command couldn't be performed, or it returned an error
     *
     *  For example: `Bash.exec(command: "mkdir", arguments: ["NewFolder"], at: "~/CurrentFolder")`
     */
    @discardableResult
    static func exec(command: String, arguments: [String], at path: String, output outputHandle: FileHandle?, error errorHandle: FileHandle?) throws -> String {
        let process = Process()
        let cmd = "cd \(path.escapingSpaces) && \(command) \(arguments.joined(separator: " "))"
        return try process.launchBash(with: cmd, output: outputHandle, error: errorHandle)
    }
}

extension Bash {
    /**
     *  Run a shell command using Bash
     *
     *  - parameter commands: The commands to run
     *  - parameter path: The path to execute the commands at (defaults to current folder)
     *  - parameter outputHandle: Any `FileHandle` that any output (STDOUT) should be redirected to
     *              (at the moment this is only supported on macOS)
     *  - parameter errorHandle: Any `FileHandle` that any error output (STDERR) should be redirected to
     *              (at the moment this is only supported on macOS)
     *
     *  - returns: The output of running the command
     *
     *  For example: `Bash.exec(commands: "cd SubFloder", "pwd", at: "~/CurrentFolder")`
     */
    @discardableResult
    static func exec(commands: [String], at path: String = ".", output outputHandle: FileHandle? = nil, error errorHandle: FileHandle? = nil) -> String {
        do {
            let command = commands.joined(separator: " && ")
            return try exec(command: command, arguments: [], at: path, output: outputHandle, error: errorHandle)
        } catch {
            return error.localizedDescription
        }
    }
    
    /**
     *  Run a shell command using Bash
     *
     *  - parameter commands: The commands to run
     *  - parameter path: The path to execute the commands at (defaults to current folder)
     *  - parameter outputHandle: Any `FileHandle` that any output (STDOUT) should be redirected to
     *              (at the moment this is only supported on macOS)
     *  - parameter errorHandle: Any `FileHandle` that any error output (STDERR) should be redirected to
     *              (at the moment this is only supported on macOS)
     *
     *  - returns: The output of running the command
     *
     *  For example: `Bash.exec(commands: "cd SubFloder", "pwd", at: "~/CurrentFolder")`
     */
    @discardableResult
    static func exec(commands: String..., at path: String = ".", output outputHandle: FileHandle? = nil, error errorHandle: FileHandle? = nil) -> String {
        return exec(commands: commands, at: path, output: outputHandle, error: errorHandle)
    }
}

extension Bash {
    /**
     *  Run a shell command using Bash
     *
     *  - parameter command: The command to run
     *  - parameter arguments: The arguments to pass to the command
     *  - parameter path: The path to execute the commands at (defaults to current folder)
     *  - parameter outputHandle: Any `FileHandle` that any output (STDOUT) should be redirected to
     *              (at the moment this is only supported on macOS)
     *  - parameter errorHandle: Any `FileHandle` that any error output (STDERR) should be redirected to
     *              (at the moment this is only supported on macOS)
     *
     *  - returns: The output of running the command
     *  - throws: `BashError` in case the command couldn't be performed, or it returned an error
     *
     *  For example: `Bash.run("mkdir", args: ["NewFolder"], at: "~/CurrentFolder")`
     */
    @discardableResult
    static func run(_ command: String, args arguments: [String] = [], at path: String = ".", output outputHandle: FileHandle? = nil, error errorHandle: FileHandle? = nil) throws -> String {
        return try exec(command: command, arguments: arguments, at: path, output: outputHandle, error: errorHandle)
    }
    
    /**
     *  Run a shell command using Bash
     *
     *  - parameter command: The command to run
     *  - parameter arguments: The arguments to pass to the command
     *  - parameter path: The path to execute the commands at (defaults to current folder)
     *  - parameter outputHandle: Any `FileHandle` that any output (STDOUT) should be redirected to
     *              (at the moment this is only supported on macOS)
     *  - parameter errorHandle: Any `FileHandle` that any error output (STDERR) should be redirected to
     *              (at the moment this is only supported on macOS)
     *
     *  - returns: The output of running the command
     *  - throws: `BashError` in case the command couldn't be performed, or it returned an error
     *
     *  For example: `Bash.run("mkdir", args: "NewFolder", at: "~/CurrentFolder")`
     */
    @discardableResult
    static func run(_ command: String, args arguments: String..., at path: String = ".", output outputHandle: FileHandle? = nil, error errorHandle: FileHandle? = nil) throws -> String {
        return try run(command, args: arguments, at: path, output: outputHandle, error: errorHandle)
    }
}

extension Bash {
    /**
     *  Run a series of shell commands using Bash
     *
     *  - parameter commands: The commands to run
     *  - parameter path: The path to execute the commands at (defaults to current folder)
     *  - parameter outputHandle: Any `FileHandle` that any output (STDOUT) should be redirected to
     *              (at the moment this is only supported on macOS)
     *  - parameter errorHandle: Any `FileHandle` that any error output (STDERR) should be redirected to
     *              (at the moment this is only supported on macOS)
     *
     *  - returns: The output of running the command
     *  - throws: `BashError` in case the command couldn't be performed, or it returned an error
     *
     *  For example: `Bash.run("mkdir NewFolder", "cd NewFolder", at: "~/CurrentFolder")`
     */
    @discardableResult
    static func run(commands: [String], at path: String = ".", ouput outputHandle: FileHandle? = nil, error errorHandle: FileHandle? = nil) throws -> String {
        let command = commands.joined(separator: " && ")
        return try run(command, args: "", at: path, output: outputHandle, error: errorHandle)
    }
    
    /**
     *  Run a series of shell commands using Bash
     *
     *  - parameter commands: The commands to run
     *  - parameter path: The path to execute the commands at (defaults to current folder)
     *  - parameter outputHandle: Any `FileHandle` that any output (STDOUT) should be redirected to
     *              (at the moment this is only supported on macOS)
     *  - parameter errorHandle: Any `FileHandle` that any error output (STDERR) should be redirected to
     *              (at the moment this is only supported on macOS)
     *
     *  - returns: The output of running the command
     *  - throws: `BashError` in case the command couldn't be performed, or it returned an error
     *
     *  For example: `Bash.run("mkdir NewFolder", "cd NewFolder", at: "~/CurrentFolder")`
     */
    @discardableResult
    static func run(commands: String..., at path: String = ".", ouput outputHandle: FileHandle? = nil, error errorHandle: FileHandle? = nil) throws -> String {
        return try run(commands: commands, at: path, ouput: outputHandle, error: errorHandle)
    }
}

extension Bash {
    /**
     *  Run a pre-defined shell command using Bash
     *
     *  - parameter command: The command to run
     *  - parameter path: The path to execute the commands at (defaults to current folder)
     *  - parameter outputHandle: Any `FileHandle` that any output (STDOUT) should be redirected to
     *  - parameter errorHandle: Any `FileHandle` that any error output (STDERR) should be redirected to
     *
     *  - returns: The output of running the command
     *  - throws: `BashError` in case the command couldn't be performed, or it returned an error
     *
     *  For example: `Bash.run(.gitCommit(message: "Commit"), at: "~/CurrentFolder")`
     *
     *  See `Bash.Command` for more info.
     */
    @discardableResult
    static func run(_ commands: [Bash.Command], at path: String = ".", ouput outputHandle: FileHandle? = nil, error errorHandle: FileHandle? = nil) throws -> String {
        let command = commands.map { $0.string }.joined(separator: " && ")
        return try run(command, at: path, output: outputHandle, error: errorHandle)
    }
    
    /**
     *  Run a pre-defined shell command using Bash
     *
     *  - parameter command: The command to run
     *  - parameter path: The path to execute the commands at (defaults to current folder)
     *  - parameter outputHandle: Any `FileHandle` that any output (STDOUT) should be redirected to
     *  - parameter errorHandle: Any `FileHandle` that any error output (STDERR) should be redirected to
     *
     *  - returns: The output of running the command
     *  - throws: `BashError` in case the command couldn't be performed, or it returned an error
     *
     *  For example: `Bash.run(.gitCommit(message: "Commit"), at: "~/CurrentFolder")`
     *
     *  See `Bash.Command` for more info.
     */
    @discardableResult
    static func run(_ commands: Bash.Command..., at path: String = ".", ouput outputHandle: FileHandle? = nil, error errorHandle: FileHandle? = nil) throws -> String {
        return try run(commands, at: path, ouput: outputHandle, error: errorHandle)
    }
}

extension Bash {
    /// Structure used to pre-define commands for use with Bash
    struct Command {
        /// The string that makes up the command that should be run on the command line
        var string: String
        
        /// Initialize a value using a string that makes up the underlying command
        init(string: String) {
            self.string = string
        }
    }
}

/// Git commands
extension Bash.Command {
    /// Initialize a git repository
    static func gitInit() -> Bash.Command {
        return Bash.Command(string: "git init")
    }
    
    /// Clone a git repository at a given URL
    static func gitClone(url: URL, to path: String? = nil) -> Bash.Command {
        var command = "git clone \(url.absoluteString)"
        path.map { command.append(argument: $0) }
        command.append(" --quiet")
        
        return Bash.Command(string: command)
    }
    
    /// Create a git commit with a given message (also adds all untracked file to the index)
    static func gitCommit(message: String) -> Bash.Command {
        var command = "git add . && git commit -a -m"
        command.append(argument: message)
        command.append(" --quiet")
        
        return Bash.Command(string: command)
    }
    
    /// Perform a git push
    static func gitPush(remote: String? = nil, branch: String? = nil) -> Bash.Command {
        var command = "git push"
        remote.map { command.append(argument: $0) }
        branch.map { command.append(argument: $0) }
        command.append(" --quiet")
        
        return Bash.Command(string: command)
    }
    
    /// Perform a git pull
    static func gitPull(remote: String? = nil, branch: String? = nil) -> Bash.Command {
        var command = "git pull"
        remote.map { command.append(argument: $0) }
        branch.map { command.append(argument: $0) }
        command.append(" --quiet")
        
        return Bash.Command(string: command)
    }
    
    /// Run a git submodule update
    static func gitSubmoduleUpdate(initializeIfNeeded: Bool = true, recursive: Bool = true) -> Bash.Command {
        var command = "git submodule update"
        
        if initializeIfNeeded {
            command.append(" --init")
        }
        
        if recursive {
            command.append(" --recursive")
        }
        
        command.append(" --quiet")
        return Bash.Command(string: command)
    }
    
    /// Checkout a given git branch
    static func gitCheckout(branch: String) -> Bash.Command {
        let command = "git checkout".appending(argument: branch)
            .appending(" --quiet")
        
        return Bash.Command(string: command)
    }
}

/// File system commands
extension Bash.Command {
    /// List items
    static func list(all: Bool = false, detail: Bool = false) -> Bash.Command {
        var command = "ls"
        if all {
            command = command.appending(argument: "-a")
        }
        if detail {
            command = command.appending(argument: "-l")
        }
        return Bash.Command(string: command)
    }
    
    /// Create a folder with a given name
    static func createFolder(named name: String) -> Bash.Command {
        let command = "mkdir".appending(argument: name)
        return Bash.Command(string: command)
    }
    
    /// Create a file with a given name and contents (will overwrite any existing file with the same name)
    static func createFile(named name: String, contents: String) -> Bash.Command {
        var command = "echo"
        command.append(argument: contents)
        command.append(" > ")
        command.append(argument: name)
        
        return Bash.Command(string: command)
    }
    
    /// Move a file from one path to another
    static func moveFile(from originPath: String, to targetPath: String) -> Bash.Command {
        let command = "mv".appending(argument: originPath)
            .appending(argument: targetPath)
        
        return Bash.Command(string: command)
    }
    
    /// Copy a file from one path to another
    static func copyFile(from originPath: String, to targetPath: String) -> Bash.Command {
        let command = "cp".appending(argument: originPath)
            .appending(argument: targetPath)
        
        return Bash.Command(string: command)
    }
    
    /// Remove a file
    static func removeFile(from path: String, arguments: [String] = ["-f"]) -> Bash.Command {
        let command = "rm".appending(arguments: arguments)
            .appending(argument: path)
        
        return Bash.Command(string: command)
    }
    
    /// Open a file using its designated application
    static func openFile(at path: String) -> Bash.Command {
        let command = "open".appending(argument: path)
        return Bash.Command(string: command)
    }
    
    /// Read a file as a string
    static func readFile(at path: String) -> Bash.Command {
        let command = "cat".appending(argument: path)
        return Bash.Command(string: command)
    }
    
    /// Create a symlink at a given path, to a given target
    static func createSymlink(to targetPath: String, at linkPath: String) -> Bash.Command {
        let command = "ln -s".appending(argument: targetPath)
            .appending(argument: linkPath)
        
        return Bash.Command(string: command)
    }
    
    /// Expand a symlink at a given path, returning its target path
    static func expandSymlink(at path: String) -> Bash.Command {
        let command = "readlink".appending(argument: path)
        return Bash.Command(string: command)
    }
}

/// Marathon commands
extension Bash.Command {
    /// Run a Marathon Swift script
    static func runMarathonScript(at path: String, arguments: [String] = []) -> Bash.Command {
        let command = "marathon run".appending(argument: path)
            .appending(arguments: arguments)
        
        return Bash.Command(string: command)
    }
    
    /// Update all Swift packages managed by Marathon
    static func updateMarathonPackages() -> Bash.Command {
        return Bash.Command(string: "marathon update")
    }
}

/// Swift Package Manager commands
extension Bash.Command {
    /// Enum defining available package types when using the Swift Package Manager
    enum SwiftPackageType: String {
        case library
        case executable
    }
    
    /// Enum defining available build configurations when using the Swift Package Manager
    enum SwiftBuildConfiguration: String {
        case debug
        case release
    }
    
    /// Create a Swift package with a given type (see SwiftPackageType for options)
    static func createSwiftPackage(withType type: SwiftPackageType = .library) -> Bash.Command {
        let command = "swift package init --type \(type.rawValue)"
        return Bash.Command(string: command)
    }
    
    /// Update all Swift package dependencies
    static func updateSwiftPackages() -> Bash.Command {
        return Bash.Command(string: "swift package update")
    }
    
    /// Generate an Xcode project for a Swift package
    static func generateSwiftPackageXcodeProject() -> Bash.Command {
        return Bash.Command(string: "swift package generate-xcodeproj")
    }
    
    /// Build a Swift package using a given configuration (see SwiftBuildConfiguration for options)
    static func buildSwiftPackage(withConfiguration configuration: SwiftBuildConfiguration = .debug) -> Bash.Command {
        return Bash.Command(string: "swift build -c \(configuration.rawValue)")
    }
    
    /// Test a Swift package using a given configuration (see SwiftBuildConfiguration for options)
    static func testSwiftPackage(withConfiguration configuration: SwiftBuildConfiguration = .debug) -> Bash.Command {
        return Bash.Command(string: "swift test -c \(configuration.rawValue)")
    }
}

/// Fastlane commands
extension Bash.Command {
    /// Run Fastlane using a given lane
    static func runFastlane(usingLane lane: String) -> Bash.Command {
        let command = "fastlane".appending(argument: lane)
        return Bash.Command(string: command)
    }
}

/// CocoaPods commands
extension Bash.Command {
    /// Update all CocoaPods dependencies
    static func updateCocoaPods() -> Bash.Command {
        return Bash.Command(string: "pod update")
    }
    
    /// Install all CocoaPods dependencies
    static func installCocoaPods() -> Bash.Command {
        return Bash.Command(string: "pod install")
    }
}

/// Error type thrown by the `shellOut()` function, in case the given command failed
struct BashError: Swift.Error {
    /// The termination status of the command that was run
    let terminationStatus: Int32
    /// The error message as a UTF8 string, as returned through `STDERR`
    var message: String { return errorData.shellOutput() }
    /// The raw error buffer data, as returned through `STDERR`
    let errorData: Data
    /// The raw output buffer data, as retuned through `STDOUT`
    let outputData: Data
    /// The output of the command as a UTF8 string, as returned through `STDOUT`
    var output: String { return outputData.shellOutput() }
}

extension BashError: CustomStringConvertible {
    var description: String {
        return """
        Bash encountered an error
        Status code: \(terminationStatus)
        Message: "\(message)"
        Output: "\(output)"
        """
    }
}

extension BashError: LocalizedError {
    var errorDescription: String? {
        return description
    }
}

// MARK: - Private

private extension Process {
    @discardableResult func launchBash(with command: String, output outputHandle: FileHandle? = nil, error errorHandle: FileHandle? = nil) throws -> String {
        launchPath = "/bin/bash"
        arguments = ["-c", command]
        
        // Because FileHandle's readabilityHandler might be called from a
        // different queue from the calling queue, avoid a data race by
        // protecting reads and writes to outputData and errorData on
        // a single dispatch queue.
        let outputQueue = DispatchQueue(label: "bash-output-queue")
        
        var outputData = Data()
        var errorData = Data()
        
        let outputPipe = Pipe()
        standardOutput = outputPipe
        
        let errorPipe = Pipe()
        standardError = errorPipe
        
        #if !os(Linux)
        outputPipe.fileHandleForReading.readabilityHandler = { handler in
            outputQueue.async {
                let data = handler.availableData
                outputData.append(data)
                outputHandle?.write(data)
            }
        }
        
        errorPipe.fileHandleForReading.readabilityHandler = { handler in
            outputQueue.async {
                let data = handler.availableData
                errorData.append(data)
                errorHandle?.write(data)
            }
        }
        #endif
        
        launch()
        
        #if os(Linux)
        outputQueue.sync {
            outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
            errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
        }
        #endif
        
        waitUntilExit()
        
        outputHandle?.closeFile()
        errorHandle?.closeFile()
        
        #if !os(Linux)
        outputPipe.fileHandleForReading.readabilityHandler = nil
        errorPipe.fileHandleForReading.readabilityHandler = nil
        #endif
        
        // Block until all writes have occurred to outputData and errorData,
        // and then read the data back out.
        return try outputQueue.sync {
            if terminationStatus != 0 {
                throw BashError(
                    terminationStatus: terminationStatus,
                    errorData: errorData,
                    outputData: outputData
                )
            }
            
            return outputData.shellOutput()
        }
    }
}

private extension Data {
    func shellOutput() -> String {
        guard let output = String(data: self, encoding: .utf8) else {
            return ""
        }
        
        guard !output.hasSuffix("\n") else {
            let endIndex = output.index(before: output.endIndex)
            return String(output[..<endIndex])
        }
        
        return output
        
    }
}

private extension String {
    var escapingSpaces: String {
        return replacingOccurrences(of: " ", with: "\\ ")
    }
    
    func appending(argument: String) -> String {
        return "\(self) \"\(argument)\""
    }
    
    func appending(arguments: [String]) -> String {
        return appending(argument: arguments.joined(separator: "\" \""))
    }
    
    mutating func append(argument: String) {
        self = appending(argument: argument)
    }
    
    mutating func append(arguments: [String]) {
        self = appending(arguments: arguments)
    }
}
