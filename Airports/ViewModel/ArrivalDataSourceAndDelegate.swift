//
//  ArrivalDataSourceAndDelegate.swift
//  Airports
//
//  Created by Lucas Macedo de Lemos on 18/02/20.
//  Copyright © 2020 Lucas Macedo de Lemos. All rights reserved.
//

import Foundation
import UIKit

class ArrivalDataSourceAndDelegate: GenericDataSourceAndDelegate<AirportTimetable>, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArrivalTableViewCell", for: indexPath) as! ArrivalTableViewCell
        cell.arrival = data.value[indexPath.row]
        return cell
    }
}
