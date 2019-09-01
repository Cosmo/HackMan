import XCTest
@testable import HackManLib

final class HackManTests: XCTestCase {
    func testExample() throws {
        // XCTAssertEqual(Property(), "Hello, World!")
    }
    
    func testSnakeCasedInput() throws {
        let propertiesString = "name:string uuid weight:double is_enabled:bool artist:artist created_at:date updated_at:date".split(separator: " ").map { String($0) }
        let properties = Property.createList(inputStrings: propertiesString)
        
        XCTAssertEqual(properties.count, 7)
        
        let verification = [
            Property(name: "name", valueType: "String"),
            Property(name: "uuid", valueType: "String"),
            Property(name: "weight", valueType: "Double"),
            Property(name: "isEnabled", valueType: "Bool"),
            Property(name: "artist", valueType: "Artist"),
            Property(name: "createdAt", valueType: "Date"),
            Property(name: "updatedAt", valueType: "Date")
        ]
        
        XCTAssertEqual(properties, verification)
    }
    
    func testCamelCasedInput() throws {
        let propertiesString = "name:String uuid weight:Double isEnabled:Bool artist:Artist createdAt:Date updatedAt:Date".split(separator: " ").map { String($0) }
        let properties = Property.createList(inputStrings: propertiesString)
        
        XCTAssertEqual(properties.count, 7)
        
        let verification = [
            Property(name: "name", valueType: "String"),
            Property(name: "uuid", valueType: "String"),
            Property(name: "weight", valueType: "Double"),
            Property(name: "isEnabled", valueType: "Bool"),
            Property(name: "artist", valueType: "Artist"),
            Property(name: "createdAt", valueType: "Date"),
            Property(name: "updatedAt", valueType: "Date")
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
        ("testSnakeCasedInput", testSnakeCasedInput),
        ("testCamelCasedInput", testCamelCasedInput),
    ]
}
