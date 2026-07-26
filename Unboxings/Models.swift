//
//  Model.swift
//  Unboxings
//
//  Created by Hayden Clark on 2026-07-25.
//

import Foundation
import UIKit

class Figure: Identifiable, Codable {
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

class Series: Identifiable, Codable {
    var id: String {
        return "\(brand)-\(name)"
    }
    let name: String
    let brand: String
    var figures: [Figure] = []
    
    init(name: String, brand: String, figures: [Figure]) {
        self.name = name
        self.brand = brand
        self.figures = figures
    }
}

class SeriesViewModel: NSObject, UITableViewDataSource {
    var data: [Series] = []
    
    override init() {
        if let url = Bundle.main.url(forResource: "series", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonData = try JSONDecoder().decode([Series].self, from: data)
                self.data = jsonData
            } catch {
                print("error:\(error)")
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.row]
        
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "SeriesCell")
        cell.accessoryType = .disclosureIndicator
        var config = cell.defaultContentConfiguration()
        config.text = item.name
        config.secondaryText = item.id
        
        
        cell.contentConfiguration = config
        return cell
    }
    
    
}
