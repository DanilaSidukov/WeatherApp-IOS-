import Foundation

extension LocationsViewController: RefreshDelegate {
    
    func onRefreshAction() {
        Task {
            try await self.locationsViewModel.updateLocations()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.refreshControl?.endRefreshing()
            }
        }
    }
}
