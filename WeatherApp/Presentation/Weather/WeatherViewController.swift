import UIKit
import SwiftUI

class WeatherViewController: UIViewController {

    let testLocation = LocationData(
        location: "Moscow",
        temperature: "12",
        temperatureRange: "8-16",
        weatherIcon: "ic_snow",
        longitude: 43.2312,
        latitude: 12.4532,
    )
    
    let padding: CGFloat = 16
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let mainInfoView = MainInfoView()
    private let weatherDescriptionView = WeatherDescriptionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .baseBackground
        setupView()
        setupScrollView()
        setupConstraints()
    }
    
    private func setupView() {
        view.addSubview(scrollView)
    }
    
    private func setupScrollView() {
        scrollView.addSubview(scrollStackViewContainer)
        mainInfoView.translatesAutoresizingMaskIntoConstraints = false
        weatherDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        scrollStackViewContainer.addArrangedSubview(mainInfoView)
        scrollStackViewContainer.addArrangedSubview(weatherDescriptionView)
        mainInfoView.configure()
        weatherDescriptionView.configure()
    }
    
    private func setupConstraints() {
        view.layoutMargins = UIEdgeInsets(top: 0, left: padding, bottom: padding, right: padding)
        let layoutMargins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: layoutMargins.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: layoutMargins.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: layoutMargins.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: layoutMargins.bottomAnchor),
            
            scrollStackViewContainer.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollStackViewContainer.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
}

struct WeatherViewControllerPreview: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = WeatherViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

struct ViewControllerPreview: PreviewProvider {

    static var previews: some View {
        WeatherViewControllerPreview()
    }
}
