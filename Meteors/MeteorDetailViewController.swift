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
        viewModel.errorReceived = { error in
            print(error.localizedDescription)
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
        mapView.frame = view.bounds
        view.backgroundColor = .systemBackground
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
    }

    @objc private func favoriteButtonTapped() {
        if viewModel.isFavorited {
            viewModel.removeFromFavorites()
        } else {
            viewModel.addToFavorites()
        }
    }
}
