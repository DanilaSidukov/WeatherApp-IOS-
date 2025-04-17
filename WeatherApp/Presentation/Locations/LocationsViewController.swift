import UIKit
import SwiftUI
import Foundation

final class LocationsViewController: UIViewController {
    
    private let buttonAdd = ButtonAdd()
    
    
    let locationsViewModel = LocationsViewModel(
        getCoordByGeoUseCase: GetCoordByGeoUseCase(),
        getLocationByCoordUseCase: GetLocationByCoordUseCase()
    )
        
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .baseBackground
        collectionView.register(LocationCollectionViewCell.self, forCellWithReuseIdentifier: LocationCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        log.info("viewDidLoad")
    }
}

private extension LocationsViewController {
    
    func setupView() {
        view.backgroundColor = .baseBackground
        
        locationsViewModel.showError = { error in
            if (!error.isEmpty) {
                DispatchQueue.main.async {
                    let _ = InfoDialog(message: error, delegate: self)
                }
            }
        }
        
        addSubViews()
        setupActions()
        setupConstraints()
    }
}

private extension LocationsViewController {
    
    func addSubViews() {
        self.collectionView.allowsMultipleSelection = false
        
        setupLongGestureRecognizerOnCollection()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        view.addSubview(collectionView)
        view.addSubview(buttonAdd)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
    }
}

private extension LocationsViewController {
    
    func setupActions() {
        
        self.collectionView.refreshControl = RefreshControl(delegate: self)
        
        self.buttonAdd.onClick = {
            let textFieldWindow = TextFieldAlert(delegate: self)
            self.present(textFieldWindow, animated: true, completion: nil)
        }
    }
}

private extension LocationsViewController {
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            buttonAdd.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonAdd.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100)
        ])
    }
}

