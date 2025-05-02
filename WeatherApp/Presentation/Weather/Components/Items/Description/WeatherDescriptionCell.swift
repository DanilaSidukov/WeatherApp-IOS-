import UIKit

final class WeatherDescriptionCell: UICollectionViewCell {
    
    static let identifier = "WeatherDescriptionCell"
    
    private let weatherDecriptionView = WeatherDescriptionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupContraints()
    }
    
    private func setupView() {
        weatherDecriptionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weatherDecriptionView)
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            weatherDecriptionView.topAnchor.constraint(equalTo: topAnchor),
            weatherDecriptionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            weatherDecriptionView.leftAnchor.constraint(equalTo: leftAnchor),
            weatherDecriptionView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    func configure() {
        let mockData = WeatherDescription(
            status: "Today is clear day!",
            description: "As you can see today is better spend some time somewhere on street"
        )
        weatherDecriptionView.configure(with: mockData)
    }
}
