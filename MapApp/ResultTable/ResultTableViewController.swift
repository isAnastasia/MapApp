//
//  ResultTableViewController.swift
//  MapApp
//
//  Created by Anastasia Gorbunova on 08.08.2024.
//

import UIKit

final class ResultTableViewController: UIViewController {
    private let places: [PlaceAnnotation]
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(places: [PlaceAnnotation]) {
        self.places = places
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    //MARK: - Private Functions
    private func setUpUI() {
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.identifier)
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 36),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 2),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])       
    }
}

//MARK: - UITableViewDataSource
extension ResultTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(places.count)
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as? ResultTableViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = places[indexPath.row].name
        cell.detailTextLabel?.text = places[indexPath.row].address
        
        return cell
    }
    
}

extension ResultTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
