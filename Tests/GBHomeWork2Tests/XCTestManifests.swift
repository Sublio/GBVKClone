import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(GBHomeWork2Tests.allTests)
    ]
}
#endif
