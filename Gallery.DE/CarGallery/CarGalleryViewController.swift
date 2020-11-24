import UIKit

extension CarGalleryViewController {
    class func make(
        with viewModel: CarGalleryViewModel,
        imageService: ImageService
    ) -> CarGalleryViewController {

        let viewController = CarGalleryViewController.from(storyboard: .main)
        viewController.viewModel = viewModel
        viewController.imageService = imageService
        return viewController
    }
}

final class CarGalleryViewController: UICollectionViewController {
    private var viewModel: CarGalleryViewModel?
    private var imageService: ImageService?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel?.screenTitle
        collectionView.collectionViewLayout = createBasicListLayout()

        viewModel?.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.imagesCount ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CarSmallImageCell.reuseIdentifier,
            for: indexPath)

        if let cell = cell as? CarSmallImageCell {
            setupCarImageCell(cell, index: indexPath.row)
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let imageUri = viewModel?.imageURI(for: indexPath.row),
              let assembly = viewModel?.detailsAssembly
        else { return }
        
        let detailsVC = assembly.makeVC(with: imageUri)
        navigationController?.pushViewController(detailsVC, animated: true)
    }

    private func setupCarImageCell(_ cell: CarSmallImageCell, index: Int) {
        guard let imageUri = viewModel?.imageURI(for: index)  else { return }

        cell.imageUri = imageUri

        imageService?.image(for: imageUri, size: .small, completion: { [weak cell] image in
            guard cell?.imageUri == imageUri,
                  let image = image
            else { return }

            DispatchQueue.main.async {
                cell?.set(image)
            }
        })
    }

    private func createBasicListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(160))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
