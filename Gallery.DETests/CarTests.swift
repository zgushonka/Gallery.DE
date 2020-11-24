import XCTest
@testable import Gallery_DE

class CarTests: XCTestCase {
    var sut: Car!

    func testInitValues() throws {
        sut = .init(imageURIs: ["aaa", "bbb", "ccc"])

        XCTAssertEqual(sut.imageURIs.count, 3)
        XCTAssertEqual(sut.imageURIs[0], "aaa")
        XCTAssertEqual(sut.imageURIs[1], "bbb")
        XCTAssertEqual(sut.imageURIs[2], "ccc")
    }

    func testOtherInitValues() throws {
        sut = .init(imageURIs: [])

        XCTAssertEqual(sut.imageURIs.count, 0)
    }

    func testDecodable() throws {
        sut = try JSONDecoder().decode(Car.self, from: Car.jsonData)

        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.imageURIs.count, 3)
        XCTAssertEqual(sut.imageURIs[0], "json aaa")
        XCTAssertEqual(sut.imageURIs[1], "json bbb")
        XCTAssertEqual(sut.imageURIs[2], "json ccc")
    }
}

extension Car {
    static var mock: Car {
        .init(imageURIs: ["aaa", "bbb", "ccc"])
    }

    static var jsonString: String {
        """
        {
          "images" : [
            {
            "uri" : "json aaa",
            },
            {
            "uri" : "json bbb",
            },
            {
            "uri" : "json ccc",
            }
          ]
        }
        """
    }

    static var jsonData: Data {
        Data(jsonString.utf8)
    }
}

extension Car: Equatable {
    public static func == (lhs: Car, rhs: Car) -> Bool {
        lhs.imageURIs == rhs.imageURIs
    }
}
