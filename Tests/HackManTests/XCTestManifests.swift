import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(HackManTests.allTests),
        testCase(HackManResourceTests.allTests),
    ]
}
#endif
