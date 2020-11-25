import Foundation
import UIKit

struct CarGalleryAssembly {
    static let carId = 310948239

    func makeVC() -> UIViewController {

        let viewModel = CarGalleryViewModelImpl(
            carService: CarServiceImpl(),
            detailsAssembly: CarBigImageAssembly()
        )

        // Let's see some pictures here.
        viewModel.search(by: Self.carId)

        let viewController = CarGalleryViewController.make(
            with: viewModel,
            imageService: ImageServiceImpl()
        )
        return viewController
    }
}
