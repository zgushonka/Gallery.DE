import XCTest
@testable import Gallery_DE

class ApiTests: XCTestCase {
    var searchUrl: URL!

    func testCarUrlString() throws {
        searchUrl = API.Search.car(42).makeURL()
        XCTAssertEqual(
            searchUrl.absoluteString,
            "https://m.mobile.de/svc/a/42"
        )
    }

    func testImageSmallUrlString() throws {
        searchUrl = API.Search.image("uri", .small).makeURL()
        XCTAssertEqual(
            searchUrl.absoluteString,
            "https://uri_2.jpg"
        )
    }

    func testImageSFullUrlString() throws {
        searchUrl = API.Search.image("uri", .full).makeURL()
        XCTAssertEqual(
            searchUrl.absoluteString,
            "https://uri_27.jpg"
        )
    }
}
