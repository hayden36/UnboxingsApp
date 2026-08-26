//
//  SeriesDetailViewController.swift
//  Unboxings
//
//  Created by Hayden Clark on 2026-07-26.
//

import UIKit
import CoreData

class SeriesDetailViewController: UIViewController {
    let series: Series
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let fr: NSFetchRequest<FigureUnboxing> = NSFetchRequest(entityName: "FigureUnboxing")
    var results: [FigureUnboxing] = []
    
    init(series: Series) {
        self.series = series
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchUnboxings() {
        do {
            results =  try CoreDataStack.shared.persistentContainer.viewContext.fetch(fr)
        } catch let error as NSError {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = series.name
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        fetchUnboxings()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension SeriesDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return series.figures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = series.figures[indexPath.row]
        let cell = UITableViewCell()
        var config = cell.defaultContentConfiguration()
        config.text = item.name
        config.secondaryText = results.contains(where: {$0.figureId == item.id}) ? "Unboxed" : "Not Unboxed"
        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FigureDetailViewController(figure: series.figures[indexPath.row])
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension SeriesDetailViewController: FigureDelegate {
    func didAddUnboxing() {
        print("unbxoing added. fetching requests and refreshing tableview")
        fetchUnboxings()
        tableView.reloadData()
    }
    
    
}
