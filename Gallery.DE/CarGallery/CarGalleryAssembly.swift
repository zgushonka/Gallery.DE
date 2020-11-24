import Foundation
import UIKit

struct CarGalleryAssembly {
    func makeVC() -> UIViewController {

        let viewModel = CarGalleryViewModelImpl(
            carService: CarServiceImpl(),
            detailsAssembly: CarBigImageAssembly()
        )

        // Let's see some pictures here.
        viewModel.search(by: 310948239)

        let viewController = CarGalleryViewController.make(
            with: viewModel,
            imageService: ImageServiceImpl()
        )
        return viewController
    }
}
