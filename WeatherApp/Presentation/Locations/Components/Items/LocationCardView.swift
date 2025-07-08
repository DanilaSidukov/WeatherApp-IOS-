import UIKit
import SwiftUI

final class LocationCardViewCell: UIView {
    
    static let identifier: String = "LocationCardViewCell"
    
    private var radius: CGFloat = 16
    
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
    
    func configure(with location: LocationItemView) {
        let startRange = location.temperatureRange.first ?? nil
        let endRange = location.temperatureRange.last ?? nil
        locationLabel.text = location.location
        temperatureLabel.text = "\(location.temperature)"
        temperatureRangeLabel.text = if (startRange == nil || endRange == nil) {
            String.empty
        } else {
            "\(startRange!) - \(endRange!)"
        }
        weatherIcon.image = location.weatherIcon
        
        changeSelectedUI(isItemSelected: location.isSelected)
    }
    
    func changeSelectedUI(isItemSelected: Bool) {
        if (isItemSelected) {
            checkIcon.isHidden = false
            gpsIcon.isHidden = false
            textPosition.isHidden = false
        } else {
            checkIcon.isHidden = true
            gpsIcon.isHidden = true
            textPosition.isHidden = true
        }
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubview(locationLabel)
        addSubview(temperatureLabel)
        addSubview(temperatureRangeLabel)
        addSubview(weatherIcon)
        addSubview(checkIcon)
        addSubview(selectedStackView)
        addSubview(temperatureStackView)
        addSubview(weatherStackView)
    }
    
    override func layoutSubviews() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor.copy(alpha: 0.1)
        layer.shadowOffset = CGSize(width: 0, height: 3);
        layer.shadowOpacity = 0.3
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = radius
        layer.shadowPath = shadowPath.cgPath
    }
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ic_check")!)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        imageView.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        return imageView
    }()
    
    private let gpsIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ic_gps")!)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()
    
    private let textPosition: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .secondaryText
        label.numberOfLines = 1
        label.text = stringRes("you_selected")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private let selectedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let weatherStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let temperatureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 6
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Staatliches-Regular", size: 28)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureRangeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Staatliches-Regular", size: 13)
        label.textColor = .secondaryText
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func setupConstraints() {
        selectedStackView.addArrangedSubview(gpsIcon)
        selectedStackView.addArrangedSubview(textPosition)
        temperatureStackView.addArrangedSubview(temperatureLabel)
        temperatureStackView.addArrangedSubview(temperatureRangeLabel)
        weatherStackView.addArrangedSubview(temperatureStackView)
        weatherStackView.addArrangedSubview(weatherIcon)
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            locationLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            locationLabel.rightAnchor.constraint(equalTo: checkIcon.leftAnchor, constant: -16),
            
            checkIcon.topAnchor.constraint(equalTo: locationLabel.topAnchor),
            checkIcon.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            checkIcon.bottomAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            
            selectedStackView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            selectedStackView.leftAnchor.constraint(equalTo: locationLabel.leftAnchor),
    
            weatherStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 52),
            weatherStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            weatherStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            weatherStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
    
            weatherIcon.widthAnchor.constraint(equalToConstant: 32),
            weatherIcon.heightAnchor.constraint(equalToConstant: 32),
            
            temperatureStackView.heightAnchor.constraint(equalToConstant: 52),
            temperatureStackView.leftAnchor.constraint(equalTo: weatherStackView.leftAnchor),
            temperatureStackView.topAnchor.constraint(equalTo: weatherStackView.topAnchor),
            temperatureStackView.bottomAnchor.constraint(equalTo: weatherStackView.bottomAnchor),
        ])
    }
    
    internal func clearViewForReuse() {
        locationLabel.text = nil
        temperatureLabel.text = nil
        temperatureRangeLabel.text = nil
        weatherIcon.image = nil
    }
    
}

// Обёртка для UIView для использования в SwiftUI
struct LocationCardViewPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> LocationCardViewCell {
        let view = LocationCardViewCell()
        let sampleItem = LocationItemView(location: "Наньчон", isSelected: true, temperature: "7", temperatureRange: "4 - 7",
                                          weatherIcon: UIImage(named: "ic_sun")!)
        view.configure(with: sampleItem)
        return view
    }
    
    func updateUIView(_ uiView: LocationCardViewCell, context: Context) {
        // Обновления для UIView, если нужно
    }
}

#Preview {
    return ZStack {
        Color.baseBackground // Фон экрана
        LocationCardViewPreview()
            .frame(width: 164, height: 154)
    }
}
