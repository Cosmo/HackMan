import XCTest

import HackManTests

var tests = [XCTestCaseEntry]()
tests += HackManTests.allTests()
tests += HackManStringTests.allTests()
tests += HackManResourceTests.allTests()
XCTMain(tests)
