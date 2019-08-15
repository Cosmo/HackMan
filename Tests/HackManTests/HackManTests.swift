import XCTest
@testable import HackManLib

final class HackManTests: XCTestCase {
    func testExample() throws {
        // XCTAssertEqual(Property(), "Hello, World!")
    }
    
    func testProperties() throws {
        let propertiesString = "name uuid artist:artist created_at:date updated_at:date".split(separator: " ").map { String($0) }
        let properties = Property.createList(inputStrings: propertiesString)
        
        XCTAssertEqual(properties.count, 5)
    }
    
    func testProperties2() throws {
        let propertiesString = "name uuid artist:artist created_at:date updated_at:date".split(separator: " ").map { String($0) }
        let properties = Property.createList(inputStrings: propertiesString)
        
        let verification = [
            Property(name: "name", valueType: "String", isArray: false),
            Property(name: "uuid", valueType: "String", isArray: false),
            Property(name: "artist", valueType: "Artist", isArray: false),
            Property(name: "createdAt", valueType: "Date", isArray: false),
            Property(name: "updatedAt", valueType: "Date", isArray: false)
        ]
        
        XCTAssertEqual(properties, verification)
    }

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }

    static var allTests = [
        ("testExample", testExample),
        ("testProperties", testProperties),
        ("testProperties2", testProperties2)
    ]
}
