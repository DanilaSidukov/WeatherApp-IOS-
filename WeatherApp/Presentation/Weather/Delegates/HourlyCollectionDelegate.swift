import UIKit

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherViewCell.identifier, for: indexPath) as? HourlyWeatherViewCell else { fatalError("Error HourlyWeatherViewCell") }
        if case let .data(list) = weatherViewModel.weatherState.hourlyState {
            let item = list[indexPath.item]
            cell.configure(with: item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return if case let .data(list) = weatherViewModel.weatherState.hourlyState {
            list.count
        } else {
            Int.zero
        }
    }
}
