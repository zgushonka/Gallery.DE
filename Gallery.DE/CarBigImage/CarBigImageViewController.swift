import UIKit

extension CarBigImageViewController {
    class func make(
        with imageUri: URI,
        imageService: ImageService
    ) -> CarBigImageViewController {

        let viewController = CarBigImageViewController.from(storyboard: .main)
        viewController.imageUri = imageUri
        viewController.imageService = imageService
        return viewController
    }
}

final class CarBigImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    private var imageUri: URI?
    private var imageService: ImageService?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Detail"
        setupImage()
    }

    private func setupImage() {
        guard let imageUri = imageUri else { return }

        imageService?.image(for: imageUri, size: .full, completion: { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        })
    }
}
