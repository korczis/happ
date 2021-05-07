
//
// private func main() -> Void {
//     Greeter.sayHelloWorld();
// }
//
// main()

import ArgumentParser

import HappCore

struct HelloWorld: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Simple program which prints \"Hello, World!\""
        )

//     @Flag(help: "Include a counter with each repetition.")
//     var includeCounter = false

    @Option(name: .shortAndLong, help: "The number of times to repeat 'phrase'.")
    var count: Int?
//
//     @Argument(help: "The phrase to repeat.")
//     var phrase: String

    mutating func run() throws {
        let repeatCount = count ?? 1

        for _ in 1...repeatCount {
            Greeter.sayHelloWorld();
        }
    }
}

HelloWorld.main()