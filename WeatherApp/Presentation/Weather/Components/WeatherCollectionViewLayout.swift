import UIKit

func createWeatherLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            // Main item - let the content determine the height
            let mainItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(200) // Just an initial estimate
                )
            )
            
            // Weather description item
            let weatherDescriptionItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(50) // Just an initial estimate
                )
            )
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(250) // Estimate for both items
                ),
                subitems: [mainItem, weatherDescriptionItem]
            )
            
            let section = NSCollectionLayoutSection(group: verticalGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            return section
        }
}

private func createViewSize(width: CGFloat, height: CGFloat) -> NSCollectionLayoutItem {
    return NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(width),
            heightDimension: .estimated(height)
        )
    )
}
