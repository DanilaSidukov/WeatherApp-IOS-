import UIKit
import SwiftUI

final class WeatherDescriptionView: UIView {
    
    static let identifier = "WeatherDescription"
    private let radius: CGFloat = 8
    private let padding: CGFloat = 16
    
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
    
    override func layoutSubviews() {
       let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
        layer.backgroundColor = UIColor(resource: .container).cgColor
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor.copy(alpha: 0.1)
        layer.shadowOffset = CGSize(width: 0, height: 3);
        layer.shadowOpacity = 0.3
        layer.borderColor = UIColor.clear.cgColor
        layer.cornerRadius = radius
        layer.shadowPath = shadowPath.cgPath
    }
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryText
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = .max
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupView() {
        addSubview(statusLabel)
        addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        let layoutMargins = layoutMarginsGuide
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: layoutMargins.topAnchor),
            statusLabel.leftAnchor.constraint(equalTo: layoutMargins.leftAnchor),
            statusLabel.rightAnchor.constraint(equalTo: layoutMargins.rightAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 8),
            descriptionLabel.leftAnchor.constraint(equalTo: statusLabel.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: layoutMargins.rightAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
    
    func configure() {
        let mockData = WeatherDescription(
            status: "Today is clear day!",
            description: "As you can see today is better spend some time somewhere on street"
        )
        statusLabel.text = mockData.status
        descriptionLabel.text = mockData.description
    }
}

struct WeatherDescriptionViewPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> WeatherDescriptionView {
        let view = WeatherDescriptionView()
        view.configure()
        return view
    }
    
    func updateUIView(_ uiView: WeatherDescriptionView, context: Context) {
        
    }
}

#Preview {
    return ZStack {
        Color.baseBackground
        WeatherDescriptionViewPreview()
            .frame(width: 410, height: 200, alignment: .top)
    }
    .fixedSize()
}
