//
//  FigureDetailViewController.swift
//  Unboxings
//
//  Created by Hayden Clark on 2026-07-26.
//

import UIKit

class FigureDetailViewController: UIViewController {
    let figure: Figure
    let figureNameLabel = UILabel()
    
    init(figure: Figure) {
        self.figure = figure
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = figure.name
        view.addSubview(figureNameLabel)
        figureNameLabel.text = "test label"
        figureNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            figureNameLabel.topAnchor.constraint(equalTo: view.topAnchor),
            figureNameLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            figureNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            figureNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
    }
}
