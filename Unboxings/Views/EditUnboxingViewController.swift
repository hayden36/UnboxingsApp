//
//  EditUnboxingViewController.swift
//  Unboxings
//
//  Created by Hayden Clark on 2026-08-26.
//

import UIKit

class EditUnboxingViewController: UIViewController {
    let figure: Figure?
    let series: Series?
    let formView = UIStackView()

    
    init(figure: Figure?, series: Series?) {
        self.figure = figure
        self.series = series
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(formView)
        formView.axis = .vertical
        formView.distribution = .equalSpacing
        formView.alignment = .top
        formView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            formView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            formView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            formView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            formView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
//        formView.addArrangedSubview(seriesSelection)
    }

}
