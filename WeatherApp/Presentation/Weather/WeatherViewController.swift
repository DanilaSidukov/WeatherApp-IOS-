import UIKit
import SwiftUI

class WeatherViewController: UIViewController {

    let testLocation = LocationData(
        location: "Moscow",
        temperature: "12",
        temperatureRange: "8-16",
        weatherIcon: "ic_snow",
        longitude: 43.2312,
        latitude: 12.4532,
    )
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .baseBackground
        setupView()
    }
    
    private func setupView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createWeatherLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleHeight, .flexibleHeight]
        collectionView.backgroundColor = .baseBackground
        collectionView.register(MainInfoCollectionViewCell.self, forCellWithReuseIdentifier: MainInfoCollectionViewCell.identifier)
        collectionView.register(WeatherDescriptionCell.self, forCellWithReuseIdentifier: WeatherDescriptionCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch (indexPath.item) {
            case 0:
                let mainInfoCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MainInfoCollectionViewCell.identifier,
                    for: indexPath
                ) as! MainInfoCollectionViewCell
                mainInfoCell.configure(locationData: testLocation)
                return mainInfoCell
            case 1:
                let weatherDesciptionCell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherDescriptionCell.identifier, for: indexPath) as! WeatherDescriptionCell
                weatherDesciptionCell.configure()
                return weatherDesciptionCell
            default:
                return UICollectionViewCell()
            }
    }
}

struct WeatherViewControllerPreview: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = WeatherViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

struct ViewControllerPreview: PreviewProvider {

    static var previews: some View {
        WeatherViewControllerPreview()
    }
}
