import UIKit

class HourlyWeatherViewCell: UICollectionViewCell {
    
    static let identifier = "HourlyWeatherViewCell"
    
    private let radius: CGFloat = 8
    private let padding: CGFloat = 16
    
    private let hourlyView = HourlyWeatherView()
    
    override func layoutSubviews() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
        layer.setCorners(radis: radius, shadowPath: shadowPath)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .container
        self.addSubview(hourlyView)
        
        NSLayoutConstraint.activate([
            hourlyView.topAnchor.constraint(equalTo: self.topAnchor),
            hourlyView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            hourlyView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            hourlyView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configure(with hourlyUI: HourlyWeather) {
        hourlyView.configure(with: hourlyUI)
    }
}
