import UIKit

protocol DetailsAssembly {
    func makeVC(with imageUri: URI) -> UIViewController
}

struct CarBigImageAssembly: DetailsAssembly {
    func makeVC(with uri: URI) -> UIViewController {
        let viewController = CarBigImageViewController.make(
            with: uri,
            imageService: ImageServiceImpl()
        )
        return viewController
    }
}
