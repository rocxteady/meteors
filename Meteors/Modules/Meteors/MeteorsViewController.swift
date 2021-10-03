//
//  MeteorsViewController.swift
//  Meteors
//
//  Created by Ulaş Sancak on 29.09.2021.
//

import UIKit

enum SegmentedControlType: Int {
    case date = 0
    case size = 1
    
    var title: String {
        switch self {
        case .date:
            return "By Date"
        case .size:
            return "By Size"
        }
    }
    
    static let allValues: [SegmentedControlType] = [.date, .size]
}

class MeteorsViewController: UIViewController {
    
    private let viewModel: MeteorsViewModel
    private let tabTitle: String
    
    private let segmentedControl = UISegmentedControl()
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    init(title: String, viewModel: MeteorsViewModel) {
        self.tabTitle = title
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        getMeteors()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        configureViewModel()
        
    }
    
    private func configureViewModel() {
        viewModel.errorReceived = { [weak self] error in
            self?.tableView.refreshControl?.endRefreshing()
            print(error.localizedDescription)
        }
        
        viewModel.meteorsReady = { [weak self] in
            self?.tableView.refreshControl?.endRefreshing()
            self?.tableView.reloadData()
        }
    }
    
    @objc private func refresh() {
        getMeteors(shouldRefresh: true)
    }
    
    @objc private func getMeteors(shouldRefresh: Bool = true) {
        let order = SegmentedControlType(rawValue: segmentedControl.selectedSegmentIndex) ?? .date
        viewModel.getMeteors(order: order, shouldRefresh: shouldRefresh)
    }

    private func setupUI() {
        title = tabTitle

        view.backgroundColor = .systemBackground

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 92.0
        tableView.register(MeteorCell.self, forCellReuseIdentifier: "MeteorCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        view.addSubview(tableView)

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.backgroundColor = .systemBackground
        segmentedControl.selectedSegmentTintColor = .systemFill
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
        for type in SegmentedControlType.allValues {
            segmentedControl.insertSegment(withTitle: type.title, at: type.rawValue, animated: false)
        }
        segmentedControl.selectedSegmentIndex = SegmentedControlType.date.rawValue
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        view.addSubview(segmentedControl)

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
        viewModel.numberOfMeteros
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MeteorCell", for: indexPath) as? MeteorCell else { return UITableViewCell() }
        cell.configure(meteor: viewModel.meteor(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return viewModel.isEditable
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeMeteor(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meteorDetailViewController = MeteorDetailViewController(viewModel: MeteorDetailViewModel(repository: viewModel.favoritesRepository, meteor: viewModel.meteor(at: indexPath.row)))
        navigationController?.pushViewController(meteorDetailViewController, animated: true)
    }
    
}

extension MeteorsViewController {
    
    @objc private func segmentedControlValueChanged() {
        getMeteors(shouldRefresh: false)
    }
    
}
