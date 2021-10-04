//
//  MeteorDetailViewController.swift
//  Meteors
//
//  Created by Ulaş Sancak on 3.10.2021.
//

import UIKit
import MapKit

class MeteorDetailViewController: UIViewController {

    private let viewModel: MeteorDetailViewModel
    
    private let mapView = MKMapView()
    private var favoriteButton: UIBarButtonItem?
    
    init(viewModel: MeteorDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMeteors()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureViewModel()
    }
    
    private func configureViewModel() {
        viewModel.errorReceived = { [weak self] error in
            print(error.localizedDescription)
            self?.loadData()
        }
        viewModel.updatedFavoriteStatus = { [weak self] in
            self?.loadData()
        }
    }
    
    private func getMeteors() {
        viewModel.getMeteors()
    }
    
    private func loadData() {
        if let favoriteButton = favoriteButton {
            favoriteButton.image = UIImage(named: viewModel.isFavorited ? "favorites-filled" : "favorites")
        } else {
            favoriteButton = UIBarButtonItem(image: UIImage(named: viewModel.isFavorited ? "favorites-filled" : "favorites"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
            navigationItem.rightBarButtonItem = favoriteButton
        }
    }
    
    private func setupUI() {
        navigationItem.title = viewModel.meteor.name
        
        mapView.delegate = self
        mapView.frame = view.bounds
        view.backgroundColor = .systemBackground
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
        
        let meteorAnnotation = MKPointAnnotation()
        meteorAnnotation.title = viewModel.meteor.name
        meteorAnnotation.subtitle = [viewModel.meteor.date, viewModel.meteor.massFormatted].joined(separator: " · ")
        meteorAnnotation.coordinate = CLLocationCoordinate2D(latitude: viewModel.meteor.geoLocation.latitude, longitude: viewModel.meteor.geoLocation.longitude)
        mapView.addAnnotation(meteorAnnotation)
        
        let region = MKCoordinateRegion(center: meteorAnnotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        mapView.setRegion(region, animated: true)
    }

    @objc private func favoriteButtonTapped() {
        if viewModel.isFavorited {
            viewModel.removeFromFavorites()
        } else {
            viewModel.addToFavorites()
        }
    }
}

extension MeteorDetailViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "MeteorAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
}
