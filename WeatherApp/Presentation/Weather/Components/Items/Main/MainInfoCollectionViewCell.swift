
import UIKit

class MainInfoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "WeatherCollectionView"
    
    private let mainInfo = MainInfoView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        addSubview(mainInfo)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainInfo.topAnchor.constraint(equalTo: topAnchor),
            mainInfo.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainInfo.leftAnchor.constraint(equalTo: leftAnchor),
            mainInfo.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    func configure(locationData: LocationData) {
        let mockData = LocationItemView(
            location: "Moscow",
            isSelected: true,
            temperature: "12",
            temperatureRange: "8-16",
            weatherIcon: UIImage(named: "ic_sky_snow_light")!
        )
        mainInfo.configure(with: mockData)
    }
}
