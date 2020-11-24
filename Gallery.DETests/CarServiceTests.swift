import XCTest
@testable import Gallery_DE

class CarServiceTests: XCTestCase {
    var sut: CarServiceImpl!
    var url: URL!
    var expectation: XCTestExpectation!

    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)

        url = URL(string: "https://m.mobile.de/svc/a/777")!
        expectation = expectation(description: "make request")
        expectation.assertForOverFulfill = false

        sut = .init(session: urlSession)
    }

    func testSearchRequest() throws {
        setRequestHandler(with: jsonData)
        sut.getCarInfo(for: 777, completion: { result in
            switch result {
            case .success(_):
                self.expectation.fulfill()
            case .failure(_):
                XCTFail("Error: should not fail")
            }
        })

        wait(for: [expectation], timeout: 1)
    }

    func testSearchRequestFail() throws {
        setRequestHandler(with: Data())
        sut.getCarInfo(for: 666, completion: { result in
            switch result {
            case .success(_):
                XCTFail("Error: should not succeed")
            case .failure(_):
                self.expectation.fulfill()
            }
        })

        wait(for: [expectation], timeout: 1)
    }
}

extension CarServiceTests {
    var jsonData: Data? {
        Car.jsonData
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

class CarServiceMock: CarService {
    var invocationCount: Int = 0

    func getCarInfo(
        for carId: CarId,
        completion: @escaping (Result<Car, Error>) -> Void
    ) {
        invocationCount += 1
        switch carId {
        case 42:
            completion(.success(.mock))
        case 1:
            invocationCount = 11
            completion(.failure(NetworkError.noData))
        default:
            invocationCount = 22
            completion(.failure(NetworkError.wrongRequest))
        }
    }
}
