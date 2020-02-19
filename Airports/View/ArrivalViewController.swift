//
//  ArrivalViewController.swift
//  Airports
//
//  Created by Lucas Macedo de Lemos on 18/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import UIKit

class ArrivalViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var airport: Airport!
    
    let dataSourceAndDelegate = ArrivalDataSourceAndDelegate()

    lazy var viewModel: ArrivalViewModel = {
        let viewModel = ArrivalViewModel(dataSourceAndDelegate: dataSourceAndDelegate)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Arrivals of \(airport.codeIataAirport)"

        setupTableView()
        setupObservers()
        
        self.viewModel.fetchArrivals(iataCode: airport.codeIataAirport)
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self.dataSourceAndDelegate
        self.tableView.delegate = self.dataSourceAndDelegate
    }
    
    private func setupObservers() {
        self.dataSourceAndDelegate.data.addObserver(self) { [weak self] _ in
            self?.tableView.isHidden = false
            self?.tableView.reloadData()
        }
        
        self.viewModel.onErrorHandling = { [weak self] _ in
            let alert = UIAlertController(title: "Oops", message: "Something went wrong!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }))
            self?.present(alert, animated: true, completion: nil)
        }
    }

}
