import Foundation
import UIKit

final class HourlyWeatherListView: UIView {
    
    private let containerView = UIView()
    private let radius: CGFloat = 8
    
    private let hourlyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.text = stringRes("hourly_weather")
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    private let loaderIndicator: UIActivityIndicatorView = {
//        let indicator = UIActivityIndicatorView(style: .medium)
//        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
//        indicator.translatesAutoresizingMaskIntoConstraints = false
//        return indicator
//    }()
    
    init(collectionView: UICollectionView) {
        super.init(frame: .zero)
        containerView.layer.cornerRadius = radius
        containerView.clipsToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
//        loaderIndicator.center = self.center
//        containerView.addSubview(loaderIndicator)
        containerView.addSubview(collectionView)
        containerView.addSubview(hourlyLabel)
        addSubview(containerView)
        setupConstraints(collectionView: collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
        layer.setCorners(radis: radius, shadowPath: shadowPath)
    }
    
    private func setupConstraints(collectionView: UICollectionView) {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            hourlyLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            hourlyLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            hourlyLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            
            collectionView.topAnchor.constraint(equalTo: hourlyLabel.bottomAnchor, constant: -16),
            collectionView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
