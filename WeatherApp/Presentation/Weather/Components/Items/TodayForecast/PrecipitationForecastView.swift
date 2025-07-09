import UIKit
import SwiftUI

final class PrecipitationForecastView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
        setupConstraints()
    }
    
    private let dayCloudyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryText
        label.textAlignment = .left
        label.text = stringRes("on_day")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dayCloudyValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .darkText
        label.textAlignment = .left
        label.text = "Cloudy"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dayCloudyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let nightCloudyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryText
        label.textAlignment = .left
        label.text = stringRes("on_night")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nightCloudyValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .darkText
        label.textAlignment = .left
        label.text = "Clear"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nightCloudyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let cloudyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 32
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: Humidity
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryText
        label.textAlignment = .left
        label.text = stringRes("humidity")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let humidityValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .darkText
        label.textAlignment = .left
        label.text = "43%"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let humidityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: AQI
    private let aqiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryText
        label.textAlignment = .left
        label.text = stringRes("aqi")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let aqiValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .darkText
        label.textAlignment = .left
        label.text = "Good"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let aqiStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: Precipitation
    private let precipitationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryText
        label.textAlignment = .left
        label.text = stringRes("precipitation")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let precipitationValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .darkText
        label.textAlignment = .left
        label.text = "Moderate"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let precipitationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let forecastStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 32
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func setupView() {
        dayCloudyStackView.addArrangedSubview(dayCloudyLabel)
        dayCloudyStackView.addArrangedSubview(dayCloudyValue)
        
        nightCloudyStackView.addArrangedSubview(nightCloudyLabel)
        nightCloudyStackView.addArrangedSubview(nightCloudyValue)
        
        cloudyStackView.addArrangedSubview(dayCloudyStackView)
        cloudyStackView.addArrangedSubview(nightCloudyStackView)
        
        addSubview(cloudyStackView)
        
        humidityStackView.addArrangedSubview(humidityLabel)
        humidityStackView.addArrangedSubview(humidityValue)
        
        aqiStackView.addArrangedSubview(aqiLabel)
        aqiStackView.addArrangedSubview(aqiValue)
        
        precipitationStackView.addArrangedSubview(precipitationLabel)
        precipitationStackView.addArrangedSubview(precipitationValue)
        
        forecastStackView.addArrangedSubview(humidityStackView)
        forecastStackView.addArrangedSubview(aqiStackView)
        forecastStackView.addArrangedSubview(precipitationStackView)
        
        addSubview(forecastStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cloudyStackView.topAnchor.constraint(equalTo: topAnchor),
            cloudyStackView.leftAnchor.constraint(equalTo: leftAnchor),
            
            forecastStackView.topAnchor.constraint(equalTo: cloudyStackView.bottomAnchor, constant: 24),
            forecastStackView.leftAnchor.constraint(equalTo: leftAnchor),
        ])
    }
}

struct PrecipitationForecastViewPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> PrecipitationForecastView {
        let view = PrecipitationForecastView()
        return view
    }
    
    func updateUIView(_ uiView: PrecipitationForecastView, context: Context) {

    }
}

#Preview {
    return ZStack {
        Color.container
        PrecipitationForecastViewPreview()
            .padding(20)
            .frame(width: 410, height: 370, alignment: .center)
    }
    .fixedSize()
}

