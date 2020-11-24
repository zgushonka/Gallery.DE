import Foundation

protocol CarGalleryViewModel: HasTitle, HasUpdate, HasCarImageInfo, CarSearchable, HasDetailsAssembly {}

final class CarGalleryViewModelImpl: CarGalleryViewModel {
    let screenTitle = "App"
    var onUpdate: (() -> Void)? = nil
    let detailsAssembly: DetailsAssembly

    private let carService: CarService
    private var car: Car? {
        didSet { onUpdate?() }
    }

    init(
        carService: CarService,
        detailsAssembly: DetailsAssembly
    ) {
        self.carService = carService
        self.detailsAssembly = detailsAssembly
    }
}

extension CarGalleryViewModelImpl: HasCarImageInfo {
    var imagesCount: Int {
        car?.imageURIs.count ?? 0
    }

    func imageURI(for index: Int) -> URI? {
        guard let imageURIs = car?.imageURIs,
              imageURIs.indices.contains(index)
        else { return nil }

        return imageURIs[index]
    }
}

extension CarGalleryViewModelImpl: CarSearchable {
    func search(by id: CarId) {
        carService.getCarInfo(for: id) { [weak self] result in
            guard case .success(let car) = result else {
                // error handling
                return
            }

            debugPrint("Info: fetched data: \(car)")
            self?.car = car
        }
    }
}
