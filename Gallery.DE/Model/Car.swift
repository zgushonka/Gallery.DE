import Foundation

typealias CarId = Int
typealias URI = String

struct Car {
    let imageURIs: [URI]
}

extension Car: Decodable {
    typealias ImageContainer = [String:String]

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let imageArray = try values.decode([ImageContainer].self, forKey: .imageURIs)
        imageURIs = imageArray.compactMap { $0["uri"] }
    }

    enum CodingKeys: String, CodingKey {
        case imageURIs = "images"
    }
}
