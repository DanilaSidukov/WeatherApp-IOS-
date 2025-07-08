import UIKit
import SwiftUI

final class HourlyWeatherView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .container
        setupView()
        setupConstraints()
    }
    
    private let verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.backgroundColor = .container
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        return view
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .additionText
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Staatliches-Regular", size: 18)
        label.textAlignment = .center
        label.textColor = .primaryText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .baseBackground
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(timeLabel)
        verticalStackView.addArrangedSubview(weatherIcon)
        verticalStackView.addArrangedSubview(temperatureLabel)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.heightAnchor.constraint(equalToConstant: 72),
            verticalStackView.topAnchor.constraint(equalTo: topAnchor),
            verticalStackView.leftAnchor.constraint(equalTo: leftAnchor),
            verticalStackView.rightAnchor.constraint(equalTo: rightAnchor),
            
            weatherIcon.widthAnchor.constraint(equalToConstant: 24),
            weatherIcon.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(with hourlyUI : HourlyWeather) {
        timeLabel.text = hourlyUI.time
        weatherIcon.image = UIImage(named: hourlyUI.icon)!
        temperatureLabel.text = "\(hourlyUI.temperature)"
    }
}

struct HourlyWeatherViewPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> HourlyWeatherView {
        let view = HourlyWeatherView()
        let mock = HourlyWeather(
            time: "01",
            icon: "ic_sky_rainy_dark",
            temperature: 23
        )
        view.configure(with: mock)
        return view
    }
    
    func updateUIView(_ uiView: HourlyWeatherView, context: Context) {
        
    }
}

#Preview {
    return ZStack {
        Color.clear
        HourlyWeatherViewPreview()
    }
    .frame(width: 100, height: 72)
}
