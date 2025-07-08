import UIKit
import SwiftUI

class WeatherViewController: UIViewController {
    
    var weatherViewModel = WeatherViewModel(
        getHourlyWeatherUseCase: GetHourlyWeatherUseCase(),
        locationData: LocationData()
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
    private var hourlyWeatherListView: HourlyWeatherListView?
    private let hourlyWeatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .container
        collectionView.register(HourlyWeatherViewCell.self, forCellWithReuseIdentifier: HourlyWeatherViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .baseBackground
        setupView()
        setupScrollView()
        setupConstraints()
        
        weatherViewModel.onStateChange = { [weak self] newState in
            DispatchQueue.main.async {
                self?.hourlyWeatherCollectionView.reloadData()
            }
        }
    }
}

private extension WeatherViewController {
    private func setupView() {
        hourlyWeatherListView = HourlyWeatherListView(collectionView: hourlyWeatherCollectionView)
        hourlyWeatherCollectionView.dataSource = self
        hourlyWeatherCollectionView.delegate = self
        hourlyWeatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
    }
    
    private func setupScrollView() {
        scrollView.addSubview(scrollStackViewContainer)
        mainInfoView.translatesAutoresizingMaskIntoConstraints = false
        weatherDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        scrollStackViewContainer.addArrangedSubview(mainInfoView)
        scrollStackViewContainer.addArrangedSubview(weatherDescriptionView)
        if let listView = hourlyWeatherListView {
            scrollStackViewContainer.addArrangedSubview(listView)
        }
        mainInfoView.configure(locationData: weatherViewModel.weatherState.locationData.convertToLocationItemView())
        weatherDescriptionView.configure()
    }
}

private extension WeatherViewController {
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
            scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        if let listView = hourlyWeatherListView {
            listView.heightAnchor.constraint(equalToConstant: 126).isActive = true
        }
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
