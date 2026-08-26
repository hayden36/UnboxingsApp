//
//  Model.swift
//  Unboxings
//
//  Created by Hayden Clark on 2026-07-25.
//

import Foundation
import CoreData


class Figure: Identifiable, Codable {
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
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
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.brand = try container.decode(String.self, forKey: .brand)
        self.figures = try container.decode([Figure].self, forKey: .figures)
    }
}

class SeriesViewModel: NSObject {
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
    
}

protocol FigureDelegate: AnyObject {
    func didAddUnboxing()
}
