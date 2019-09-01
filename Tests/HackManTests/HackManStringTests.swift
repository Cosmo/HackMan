import XCTest
@testable import HackManLib

final class HackManStringTests: XCTestCase {
    func testSnakeCase() throws {
        XCTAssertTrue("snake".isSnakeCase)
        XCTAssertTrue("snake_case".isSnakeCase)
        XCTAssertTrue("snake_case_example".isSnakeCase)
        XCTAssertFalse("not_a_SNAKECASE_String".isSnakeCase)
        XCTAssertFalse("notSnakeCase".isSnakeCase)
        XCTAssertFalse("AlsoNotSnakeCase".isSnakeCase)
    }
    
    func testLowerCamelCase() throws {
        XCTAssertTrue("lower".isLowerCamelCase)
        XCTAssertTrue("lowerCamelCase".isLowerCamelCase)
        XCTAssertFalse("lowerCamelCase_with_underscore".isLowerCamelCase)
        XCTAssertFalse("UpperCamelCase".isLowerCamelCase)
        XCTAssertFalse("snake_case".isLowerCamelCase)
    }
    
    func testUpperCamelCase() throws {
        XCTAssertTrue("Upper".isUpperCamelCase)
        XCTAssertTrue("UpperCamelCase".isUpperCamelCase)
        XCTAssertTrue("UpperCamelCaseExample".isUpperCamelCase)
        XCTAssertFalse("UpperCamelCase_with_underscore".isUpperCamelCase)
        XCTAssertFalse("snake_case".isUpperCamelCase)
        XCTAssertFalse("lowerCamelCase".isUpperCamelCase)
    }

    static var allTests = [
        ("testSnakeCase", testSnakeCase),
        ("testLowerCamelCase", testLowerCamelCase),
        ("testUpperCamelCase", testUpperCamelCase),
    ]
}
