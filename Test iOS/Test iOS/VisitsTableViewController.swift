//
//  VisitsTableViewController.swift
//  Test iOS
//
//  Created by Grisha Okin on 08/11/2018.
//  Copyright © 2018 Grisha Okin. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireSwiftyJSON

class VisitsTableViewController: UITableViewController, VisitsTableViewControllerSortable {
    // Функция которая сортирует массив из всех поситтителей по времени от меньшего к большему
    func sortVisits(_ isEnabled: Bool) {
        if !isEnabled {
            sortedVisits = visitors
        } else {
            sortedVisits = visitors.sorted(by: { (v1, v2) -> Bool in
                v1.time < v2.time
            })
        }
        
        tableView.reloadSections([1], with: .fade)
    }
    
    
    var visitors = [Visitor]() // массив поситителей
    var sortedVisits = [Visitor]() // отсортированый массив поситителей

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
		
		
		let jsonUrl = "https://raw.githubusercontent.com/KoKoSiC007/DataBase/master/Data_Base.json" // Database URL
		guard let url = URL(string: jsonUrl) else {
			print("Error creating URL")
			return
		}
		
		//запрос на сервер и выгружение .Json файла в массив visitors
		Alamofire.request(url, method: .get, encoding: URLEncoding.default).responseSwiftyJSON { (response) in
			guard let data = response.value else {
				print("Error downloading data")
				return
			}
			
			let visitors = data.arrayValue
			for visitor in visitors {
				let name = visitor["name"].stringValue
				let time = visitor["time"].stringValue
				let v = Visitor(name: name, time: time)
				self.visitors.append(v)
			}
			
			var debug = [String]()
			for visitor in self.visitors {
				let debugVisitor = "\(visitor)"
				debug.append(debugVisitor)
			}
			let finalDebug = debug.joined(separator: ", ")
			print(finalDebug)
			print("\(visitors.count)")
			
		}
		
		
		
//        visits.append(Visit(name: "Kikis", time: "18-00"))
//        visits.append(Visit(name: "Abc", time: "19-00"))
//        visits.append(Visit(name: "Xyic", time: "19-30"))
//
        sortVisits(false) // проверка нужно ли показывать отсортированый массив
    }

    // MARK: - Table view data source
    //
	// количество секций в окне
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

	// количество ячеек которое зависит от количества поситителей
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return sortedVisits.count
        }
    }

	// отрисовка
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Switch", for: indexPath)
            
            let visitCell = cell as! VisitTableViewCell
            
            // Configure the cell...
            visitCell.delegate = self
            visitCell.mainTextLabel?.text = "Sort by time"
            
            return cell
        }
        
        let identifier: String
        switch indexPath.section {
        case 0:
            identifier = "Subtitle"
        case 1:
            identifier = "Right Detail"
        default:
            identifier = ""
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = sortedVisits[indexPath.row].name
        cell.detailTextLabel?.text = sortedVisits[indexPath.row].time

        return cell
    }

    /*
     Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
