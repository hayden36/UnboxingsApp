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
    let seriesId: Series.ID
    let figureNameLabel = UILabel()
    let unboxingsStackView = UIStackView()
    weak var delegate: FigureDelegate?
    let fr = NSFetchRequest<FigureUnboxing>(entityName: "FigureUnboxing")
    var unboxings: [FigureUnboxing] = []
    
    init(seriesId: Series.ID, figure: Figure) {
        self.figure = figure
        self.seriesId = seriesId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let addUnboxingButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(buttonTap))
        navigationItem.rightBarButtonItems = [addUnboxingButton]
        
        fr.predicate = NSPredicate(format: "figureId == %@",figure.id)
        view.backgroundColor = .systemBackground
        navigationItem.title = figure.name
        
        view.addSubview(figureNameLabel)
        figureNameLabel.text = figure.name
        figureNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            figureNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            figureNameLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            figureNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            figureNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        view.addSubview(unboxingsStackView)
        unboxingsStackView.axis = .vertical
        unboxingsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            unboxingsStackView.topAnchor.constraint(equalTo: figureNameLabel.bottomAnchor),
            unboxingsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            unboxingsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            unboxingsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            unboxings =  try CoreDataStack.shared.persistentContainer.viewContext.fetch(fr)
            print(unboxings)
            for unboxing in unboxings {
                let text = UILabel()
                text.text = unboxing.id.debugDescription
                unboxingsStackView.addArrangedSubview(text)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    @objc func buttonTap(sender: UITapGestureRecognizer) {
        let item = FigureUnboxing(context: CoreDataStack.shared.persistentContainer.viewContext)
        item.figureId = figure.id
        item.timestamp = Date.now
        CoreDataStack.shared.saveContext()
        delegate?.didAddUnboxing()
    }
}
