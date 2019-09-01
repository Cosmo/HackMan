import XCTest
@testable import HackManLib

final class HackManResourceTests: XCTestCase {
    func testResource() throws {
        let resource = Resource(name: "tooth", properties: nil)
        
        XCTAssertEqual(resource.name, "Tooth")
        XCTAssertEqual(resource.nameForFunction, "tooth")
        XCTAssertEqual(resource.pluralizedName, "Teeth")
        XCTAssertEqual(resource.pluralizedNameForFunction, "teeth")
        
        let resource2 = Resource(name: "money", properties: nil)
        
        XCTAssertEqual(resource2.name, "Money")
        XCTAssertEqual(resource2.nameForFunction, "money")
        XCTAssertEqual(resource2.pluralizedName, "MoneyItems")
        XCTAssertEqual(resource2.pluralizedNameForFunction, "moneyItems")
    }

    static var allTests = [
        ("testResource", testResource),
    ]
}
