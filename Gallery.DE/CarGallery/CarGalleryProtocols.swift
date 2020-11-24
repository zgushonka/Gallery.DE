import Foundation
import UIKit

protocol HasCarImageInfo {
    var imagesCount: Int { get }
    func imageURI(for index: Int) -> URI?
}

protocol HasTitle {
    var screenTitle: String { get }
}

protocol HasUpdate {
    var onUpdate: (() -> Void)? { get set }
}

protocol CarSearchable {
    func search(by: CarId)
}

protocol HasDetailsAssembly {
    var detailsAssembly: DetailsAssembly { get }
}
