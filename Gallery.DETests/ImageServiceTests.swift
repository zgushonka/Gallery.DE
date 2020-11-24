import XCTest
@testable import Gallery_DE

class ImageServiceTests: XCTestCase {
    var sut: ImageServiceImpl!
    var url: URL!
    var expectation: XCTestExpectation!

    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)

        url = URL(string: "https://aaa_2.jpg")!
        expectation = expectation(description: "make request")
        expectation.assertForOverFulfill = false

        sut = .init(session: urlSession)
    }

    func testSearchRequest() throws {
        let data = imageData
        XCTAssertNotNil(data)
        setRequestHandler(with: data)
        sut.image(for: "aaa", size: .small, completion: { image in
            if image != nil {
                self.expectation.fulfill()
            }
        })

        wait(for: [expectation], timeout: 2)
    }

    func testSearchRequestFail() throws {
        setRequestHandler(with: Data())
        sut.image(for: "bbb", size: .small, completion: { image in
            if image == nil {
                self.expectation.fulfill()
            }
        })

        wait(for: [expectation], timeout: 2)
    }
}

extension ImageServiceTests {
    var imageData: Data? {
        UIImage(named: "placeholder")?.pngData()
    }

    func setRequestHandler(with data: Data?) {
        MockURLProtocol.requestHandler = { request in
            guard let requestUrl = request.url,
                  requestUrl == self.url
            else {
                throw NetworkError.wrongRequest
            }

            let response = HTTPURLResponse(
                url: self.url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!

            return (response, data)
        }
    }
}

final class ImageServiceMock: ImageService {
    var invocationCount: Int = 0
    var imageUri: URI?
    var imageSize: ImageSize?

    func image(for uri: URI, size: ImageSize, completion: @escaping (UIImage?) -> Void) {
        invocationCount += 1
        imageUri = uri
        imageSize = size
        completion(nil)
    }
}
