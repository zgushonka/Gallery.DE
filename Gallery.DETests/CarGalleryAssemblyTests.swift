import XCTest
@testable import Gallery_DE

class CarGalleryAssemblyTests: XCTestCase {
    var vc: UIViewController!

    override func setUpWithError() throws {
        vc = CarGalleryAssembly().makeVC()
    }

    func testCreatesVc() throws {
        XCTAssertNotNil(vc)
        XCTAssertTrue(vc is CarGalleryViewController)
    }
}
