import XCTest
@testable import Gallery_DE

class CarGalleryViewModelTests: XCTestCase {
    var sut: CarGalleryViewModelImpl!
    var carServiceMock: CarServiceMock!
    var detailsAssemblyMock: DetailsAssemblyMock!

    override func setUpWithError() throws {
        carServiceMock = CarServiceMock()
        detailsAssemblyMock = DetailsAssemblyMock()

        sut = .init(
            carService: carServiceMock,
            detailsAssembly: detailsAssemblyMock
        )
    }

    func testMocks() throws {
        XCTAssertNotNil(carServiceMock)
        XCTAssertEqual(carServiceMock.invocationCount, 0)
    }

    func testHasTitle() throws {
        XCTAssertEqual(sut.screenTitle, "App")
    }

    func testHasOnUpdate() throws {
        let exp = XCTestExpectation(description: "onUpdate")
        sut.onUpdate = {
            exp.fulfill()
        }
        sut.onUpdate?()
        wait(for: [exp], timeout: 1)
    }

    func testImagesCountZero() throws {
        XCTAssertEqual(sut.imagesCount, 0)
    }

    func testImagesCountAfterFetch() throws {
        XCTAssertEqual(sut.imagesCount, 0)

        sut.search(by: 42)

        XCTAssertEqual(sut.imagesCount, 3)
        XCTAssertEqual(sut.imageURI(for: 0), "aaa")
        XCTAssertEqual(sut.imageURI(for: 1), "bbb")
        XCTAssertEqual(sut.imageURI(for: 2), "ccc")
    }
}

class CarGalleryViewModelMock: CarGalleryViewModel {
    var detailsAssembly: DetailsAssembly = DetailsAssemblyMock()

    var screenTitle: String = "screenTitle"

    var imagesCountAsked = false
    var imagesCountValue = 0
    var imagesCount: Int {
        get {
            imagesCountAsked = true
            return imagesCountValue
        }
        set {
            imagesCountValue = newValue
        }
    }

    var imageURIAsked = false
    var imageURIValue: Int?
    var uriArray: [URI]? = nil

    func imageURI(for index: Int) -> URI? {
        imageURIAsked = true
        imageURIValue = index

        guard let uriArray = uriArray,
              uriArray.indices.contains(index)
        else { return nil }

        return uriArray[index]
    }

    var searchInvoded = false
    var searhedString: CarId? = nil
    func search(by carId: CarId) {
        searchInvoded = true
        searhedString = carId
    }

    var onUpdate: (() -> Void)? = nil
}

struct DetailsAssemblyMock: DetailsAssembly {
    func makeVC(with imageUri: URI) -> UIViewController {
        return UIViewController()
    }
}
