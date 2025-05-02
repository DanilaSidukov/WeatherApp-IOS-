import UIKit
import SwiftUI

final class MainInfoView: UIView {
    
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
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .primaryText
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherImage: UIImageView = {
        let image = UIImageView()
        image.sizeToFit()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Staatliches-Regular", size: 160)
        label.textColor = .primaryText
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureRangeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Staatliches-Regular", size: 14)
        label.textColor = .teritaryText
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupView() {
        self.backgroundColor = .baseBackground
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(locationLabel)
        addSubview(weatherImage)
        addSubview(temperatureLabel)
        addSubview(temperatureRangeLabel)
    }
    
    func setupConstraints() {
            NSLayoutConstraint.activate([
                locationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                
                weatherImage.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
                weatherImage.centerXAnchor.constraint(equalTo: centerXAnchor),
                weatherImage.widthAnchor.constraint(equalToConstant: 200),
                weatherImage.heightAnchor.constraint(equalToConstant: 200),
                
                temperatureLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 8),
                temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                
                temperatureRangeLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 4),
                temperatureRangeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                temperatureRangeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            ])
        }
    
    func configure(with location: LocationItemView) {
        locationLabel.text = location.location
        weatherImage.image = location.weatherIcon
        temperatureLabel.text = location.temperature
        temperatureRangeLabel.text = location.temperatureRange
    }
}

struct MainInfoViewPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> MainInfoView {
        let sampleItem = MainInfoView()
        let mockData = LocationItemView(
            location: "Moscow",
            isSelected: true,
            temperature: "12",
            temperatureRange: "8-16",
            weatherIcon: UIImage(named: "ic_sky_snow_light")!
        )
        sampleItem.configure(with: mockData)
        return sampleItem
    }
    
    func updateUIView(_ uiView: MainInfoView, context: Context) {
        
    }
}

#Preview {
    return ZStack {
        Color.baseBackground
        MainInfoViewPreview()
            .frame(width: 410, height: 500, alignment: .top)
    }
    .fixedSize()
}
