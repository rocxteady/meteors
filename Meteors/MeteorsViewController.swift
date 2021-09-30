//
//  MeteorsViewController.swift
//  Meteors
//
//  Created by Ulaş Sancak on 29.09.2021.
//

import UIKit

class MeteorsViewController: UIViewController {
    
    let viewModel = MeteorsViewModel()
    
    private let segmentedControl = UISegmentedControl()
    private let tableView = UITableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Meteors"
        setupUI()
        tableView.rowHeight = 92.0
        tableView.register(MeteorCell.self, forCellReuseIdentifier: "MeteorCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setupUI() {
        navigationController?.tabBarItem.image = UIImage(named: "meteors")
        view.backgroundColor = .systemBackground
        
        segmentedControl.backgroundColor = .systemBackground
        segmentedControl.selectedSegmentTintColor = .systemFill
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
        segmentedControl.insertSegment(withTitle: "By Date", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "By Size", at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18.0),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18.0),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: segmentedControl.trailingAnchor, constant: 18.0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 18.0),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
    }

}

extension MeteorsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeteorCell", for: indexPath)
        return cell
    }
    
}
