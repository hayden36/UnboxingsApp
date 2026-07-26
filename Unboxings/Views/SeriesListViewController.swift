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
        tableView.dataSource = seriesViewModel
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

extension SeriesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = SeriesDetailViewController(series: seriesViewModel.data[indexPath.row])
        navigationController?.pushViewController(detailView, animated: true)
    }
}
