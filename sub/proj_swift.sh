# ------------------------------------------------------------------------------
#   For Swift
# ------------------------------------------------------------------------------
function bootstrap_swift_project {
    echo "-- Bootstrapping minimal Swift project"

    swift package init --name ${PROJ_NAME} --type executable
}

function add_example_dependency {
    echo "-- Adding an example dependency"

    cat >Package.swift <<EOF
// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "$PROJ_NAME",
    dependencies: [
      .package(url: "https://github.com/apple/example-package-figlet", branch: "main"),
      .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "$PROJ_NAME",
            dependencies: [
                .product(name: "Figlet", package: "example-package-figlet"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "Sources"),
    ]
)
EOF
}

function create_small_application {
    echo "-- Creating a small application"

    rm Sources/main.swift
    cat >Sources/$PROJ_NAME.swift <<EOF
import Figlet
import ArgumentParser

@main
struct FigletTool: ParsableCommand {
  @Option(help: "Specify the input")
  public var input: String 

  public func run() throws {
    Figlet.say(self.input)
  }
}
EOF
}

function print_swift_usage {
    echo ""
    echo "--------------------------------------------------------------------------------"
    echo " How to build and run the project"
    echo "--------------------------------------------------------------------------------"
    echo ""
    echo "To build the project"
    echo "    swift build"
    echo ""
    echo "To run the project"
    echo "    swift run ${PROJ_NAME} --input 'Hello, world!'"
    echo ""
}

function create_swift_project {
    echo "Creating Swift project"

    mkdir $PROJ_NAME && cd $PROJ_NAME

    create_file_license_mit
    bootstrap_swift_project

    add_example_dependency
    create_small_application

    print_swift_usage
}
