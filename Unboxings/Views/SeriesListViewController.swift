//
//  SeriesListViewController.swift
//  Unboxings
//
//  Created by Hayden Clark on 2026-07-26.
//

import UIKit

class SeriesListViewController: UIViewController {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let seriesViewModel = SeriesViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        navigationItem.title = "Series"

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension SeriesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = SeriesDetailViewController(series: seriesViewModel.data[indexPath.row])
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        seriesViewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let series = seriesViewModel.data[indexPath.row]
        
        
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "SeriesCell")
        cell.accessoryType = .disclosureIndicator
        var config = cell.defaultContentConfiguration()
        config.text = series.name
        config.secondaryText = "\(series.figures.filter({$0.unboxed}).count)/\(series.figures.count) unboxed"
        
        cell.contentConfiguration = config
        return cell
    }
}
