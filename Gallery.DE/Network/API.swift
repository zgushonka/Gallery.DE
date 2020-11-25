import Foundation

enum API {
    static let baseURL = "https://m.mobile.de/"
}

extension API {
    enum Search {
        case car(Int)
        case image(URI, ImageSize)

        func makeURL() -> URL? {
            switch self {
            case .car(let query):
                return URL(string: API.baseURL + "svc/a/\(query)")
            case .image(let uri, let size):
                return URL(string: "https://" + uri + size.uriSuffix + ".jpg")
            }
        }
    }
}

enum NetworkError: Error {
    case wrongRequest
    case noData
}

private extension ImageSize {
    var uriSuffix: String {
        switch self {
        case .small: return "_2"
        case .full: return "_27"
        }
    }
}
