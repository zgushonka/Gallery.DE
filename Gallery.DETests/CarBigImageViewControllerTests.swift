import XCTest
@testable import Gallery_DE

class CarBigImageViewControllerTests: XCTestCase {
    var sut: CarBigImageViewController!
    var imageServiceMock: ImageServiceMock!

    override func setUpWithError() throws {
        imageServiceMock = ImageServiceMock()

        sut = .make(
            with: "uri",
            imageService: imageServiceMock
        )

        let _ = sut.view
    }

    func testOutlets() throws {
        XCTAssertNotNil(sut.imageView)
    }

    func testImageServiceAsked() {
        XCTAssertEqual(imageServiceMock.invocationCount, 1)
        XCTAssertEqual(imageServiceMock.imageUri, "uri")
        XCTAssertEqual(imageServiceMock.imageSize, .full)
    }
}
