import Foundation
import UIKit

final class CarSmallImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    var imageUri: URI?

    func set(_ image: UIImage) {
        imageView.image = image
    }

    override func prepareForReuse() {
        imageView.image = UIImage(named: "placeholder")
        imageUri = nil
    }
}

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
