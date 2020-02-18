//
//  AirportViewController.swift
//  Airports
//
//  Created by Lucas Macedo de Lemos on 17/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import UIKit

class AirportViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
        
    let dataSourceAndDelegate = AirportDataSourceAndDelegate()
    
    lazy var viewModel: AirportViewModel = {
        let viewModel = AirportViewModel(dataSourceAndDelegate: dataSourceAndDelegate)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Airports"
        
        self.tableView.dataSource = self.dataSourceAndDelegate
        self.tableView.delegate = self.dataSourceAndDelegate
        self.dataSourceAndDelegate.data.addAndNotify(observer: self) { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        self.dataSourceAndDelegate.router.addObserver(self) { [weak self] airport in
            //TODO
        }
        
        self.viewModel.onErrorHandling = { [weak self] _ in
            let alert = UIAlertController(title: "Oops", message: "Something went wrong!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
        
        self.viewModel.fetchAirports()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
