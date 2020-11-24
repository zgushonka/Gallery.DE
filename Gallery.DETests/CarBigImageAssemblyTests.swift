import XCTest
@testable import Gallery_DE

class CarBigImageAssemblyTests: XCTestCase {
    var vc: UIViewController!

    override func setUpWithError() throws {
        vc = CarBigImageAssembly().makeVC(with: "uri")
    }

    func testCreatesVc() throws {
        XCTAssertNotNil(vc)
    }
}
