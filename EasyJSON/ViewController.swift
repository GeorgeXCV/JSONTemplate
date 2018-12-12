//
//  ViewController.swift
//  EasyJSON
//
//  Created by George on 12/12/2018.
//  Copyright © 2018 George. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var tableArray = [String] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        parseJSON()
    }
    
    func parseJSON() {
        
        let url = URL(string: "https://api.myjson.com/bins/vi56v")  // The API url we want to access
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error ) in  // Data request to url above
            
            // Check for error
            guard error == nil else {
                print("returned error")
                return
            }
            
            // Check if data found
            guard let content = data else {
                print("No data")
                return
            }
            
            // Convert our JSON to NSDictionary with JSON Serialization
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            
            // Move companies into our array
            if let array = json["companies"] as? [String] {
                self.tableArray = array
            }
            print(self.tableArray)
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        
        }
        task.resume()
    }


}

extension ViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = self.tableArray[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.tableArray.count
        
    }
}

