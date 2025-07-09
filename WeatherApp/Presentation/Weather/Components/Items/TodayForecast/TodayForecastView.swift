import UIKit
import SwiftUI

final class TodayForecastView: UIView {
    
    static let identifier = "TodayForecastView"
    private let radius: CGFloat = 8
    private let padding: CGFloat = 16
    
    private var dayTimeCurveView: DayTimeCurveView!
    private var precipitationForecastView: PrecipitationForecastView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        dayTimeCurveView = DayTimeCurveView()
        precipitationForecastView = PrecipitationForecastView()
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        dayTimeCurveView = DayTimeCurveView()
        precipitationForecastView = PrecipitationForecastView()
        setupView()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
        layer.setCorners(radis: radius, shadowPath: shadowPath)
    }
    
    private let forecastLabel: UILabel = {
        let label = UILabel()
        label.textColor = .teritaryText
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = stringRes("today_forecast")
        return label
    }()
    
    
    
    private func setupView() {
        dayTimeCurveView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(forecastLabel)
        addSubview(dayTimeCurveView)
        addSubview(precipitationForecastView)
    }
    
    private func setupConstraints() {
        layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        let layoutMargins = layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            forecastLabel.topAnchor.constraint(equalTo: layoutMargins.topAnchor),
            forecastLabel.leftAnchor.constraint(equalTo: layoutMargins.leftAnchor),
            forecastLabel.rightAnchor.constraint(equalTo: layoutMargins.rightAnchor),
            
            
            dayTimeCurveView.heightAnchor.constraint(equalToConstant: 60),
            dayTimeCurveView.topAnchor.constraint(equalTo: forecastLabel.bottomAnchor, constant: 24),
            dayTimeCurveView.leftAnchor.constraint(equalTo: layoutMargins.leftAnchor),
            dayTimeCurveView.rightAnchor.constraint(equalTo: layoutMargins.rightAnchor),
            
            precipitationForecastView.topAnchor.constraint(equalTo: dayTimeCurveView.bottomAnchor, constant: 24),
            precipitationForecastView.leftAnchor.constraint(equalTo: layoutMargins.leftAnchor),
            precipitationForecastView.rightAnchor.constraint(equalTo: layoutMargins.rightAnchor),
        ])
    }
}

struct TodayForecastViewPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> TodayForecastView {
        let view = TodayForecastView()
        return view
    }
    
    func updateUIView(_ uiView: TodayForecastView, context: Context) {
        
    }
}

#Preview {
    return ZStack {
        Color.container
        TodayForecastViewPreview()
            .frame(width: 410, height: 500, alignment: .top)
    }
    .fixedSize()
}
