import Foundation
import UIKit

final class HourlyWeatherListView: UIView {
    
    private let containerView = UIView()
    private let radius: CGFloat = 8
    
    private var collectionView: UICollectionView!
    
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
    
    private let loaderIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    init(collectionView: UICollectionView) {
        super.init(frame: .zero)
        self.collectionView = collectionView
        self.containerView.layer.cornerRadius = radius
        self.containerView.clipsToBounds = true
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.isHidden = true
        
        containerView.addSubview(loaderIndicator)
        containerView.addSubview(self.collectionView)
        containerView.addSubview(hourlyLabel)
        containerView.addSubview(errorLabel)
        addSubview(containerView)
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius)
        layer.setCorners(radis: radius, shadowPath: shadowPath)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            hourlyLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            hourlyLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            hourlyLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            
            self.collectionView.topAnchor.constraint(equalTo: hourlyLabel.bottomAnchor, constant: -16),
            self.collectionView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            loaderIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            loaderIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            errorLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            errorLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    func isListVisible(hourlyState: HourlyState) {
        switch hourlyState {
            case .data:
                self.collectionView.isHidden = false
                self.loaderIndicator.isHidden = true
                self.errorLabel.isHidden = true
                self.loaderIndicator.stopAnimating()
            case .loading:
                self.loaderIndicator.isHidden = false
                self.collectionView.isHidden = true
                self.errorLabel.isHidden = true
            case .error(let message):
                self.errorLabel.isHidden = false
                self.loaderIndicator.isHidden = true
                self.collectionView.isHidden = true
                errorLabel.text = message
                self.loaderIndicator.stopAnimating()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
