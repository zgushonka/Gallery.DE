import XCTest
@testable import Gallery_DE

class CarGalleryViewControllerTests: XCTestCase {
    var sut: CarGalleryViewController!
    var viewModelMock: CarGalleryViewModelMock!
    var imageServiceMock: ImageServiceMock!

    override func setUpWithError() throws {
        viewModelMock = CarGalleryViewModelMock()
        viewModelMock.uriArray = Car.mock.imageURIs
        imageServiceMock = ImageServiceMock()

        sut = .make(
            with: viewModelMock,
            imageService: imageServiceMock
        )

        let _ = sut.view
    }

    func testOutlets() throws {
        XCTAssertNotNil(sut.collectionView)
        XCTAssertNotNil(sut.collectionView)
    }

    func testViewModelSetup() {
        XCTAssertNotNil(viewModelMock.onUpdate)
    }

    func testImagesCount() throws {
        XCTAssertFalse(viewModelMock.imagesCountAsked)
        XCTAssertEqual(sut.collectionView(sut.collectionView, numberOfItemsInSection: 0), 0)
        XCTAssertTrue(viewModelMock.imagesCountAsked)
        viewModelMock.imagesCount = 42
        XCTAssertEqual(sut.collectionView(sut.collectionView, numberOfItemsInSection: 0), 42)
    }

    func testImageURIAsked() throws {
        XCTAssertFalse(viewModelMock.imageURIAsked)
        XCTAssertNotNil(sut.collectionView(sut.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)))
        XCTAssertTrue(viewModelMock.imageURIAsked)
        XCTAssertEqual(viewModelMock.imageURIValue, 0)
        XCTAssertNotNil(sut.collectionView(sut.collectionView, cellForItemAt: IndexPath(row: 15, section: 0)))
        XCTAssertEqual(viewModelMock.imageURIValue, 15)
    }

    func testImageServiceAsked() {
        XCTAssertNotNil(sut.collectionView(sut.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)))

        XCTAssertEqual(imageServiceMock.invocationCount, 1)
        XCTAssertEqual(imageServiceMock.imageUri, "aaa")
        XCTAssertEqual(imageServiceMock.imageSize, .small)
    }
}
