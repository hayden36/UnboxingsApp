//
//  FigureDetailViewController.swift
//  Unboxings
//
//  Created by Hayden Clark on 2026-07-26.
//

import UIKit
import CoreData

class FigureDetailViewController: UIViewController {
    let figure: Figure
    let figureNameLabel = UILabel()
    let button = UIButton(configuration: .borderedProminent())
    weak var delegate: FigureDelegate?
    
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
        view.addSubview(button)
        figureNameLabel.text = figure.name
        
        button.setTitle("Add unboxing", for: .normal)
        
        figureNameLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonTap)))

        NSLayoutConstraint.activate([
            figureNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            figureNameLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            figureNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            figureNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
//            button.topAnchor.constraint(equalTo: figureNameLabel.bottomAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    @objc func buttonTap(sender: UITapGestureRecognizer) {
        let item = FigureUnboxing(context: CoreDataStack.shared.persistentContainer.viewContext)
        item.figureId = figure.id
        item.timestamp = Date.now
        CoreDataStack.shared.saveContext()
        delegate?.didAddUnboxing()
    }
}
