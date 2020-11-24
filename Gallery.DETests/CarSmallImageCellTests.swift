import XCTest
@testable import Gallery_DE

class CarSmallImageCellTestsTests: XCTestCase {
    var sut: CarSmallImageCell!

    override func setUpWithError() throws {
        let vc = CarGalleryViewController.make(
            with: CarGalleryViewModelMock(),
            imageService: ImageServiceMock()
        )
        let _ = vc.view

        let cell = vc.collectionView.dequeueReusableCell(
            withReuseIdentifier: CarSmallImageCell.reuseIdentifier,
            for: IndexPath(row: 0, section: 0)
        )
        
        sut = cell as? CarSmallImageCell
    }

    func testOutlets() throws {
        XCTAssertNotNil(sut.imageView)
        XCTAssertNotNil(sut.imageView.image)
    }

    func testUriSetup() {
        XCTAssertNil(sut.imageUri)
        sut.imageUri = "uri"
        XCTAssertEqual(sut.imageUri, "uri")
    }

    func testSetImage() {
        sut.imageView.image = nil
        XCTAssertNil(sut.imageView.image)
        sut.set(UIImage())
        XCTAssertNotNil(sut.imageView.image)
    }
}
