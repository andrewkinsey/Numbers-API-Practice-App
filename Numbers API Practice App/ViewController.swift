//
//  ViewController.swift
//  Numbers API Practice App
//
//  Created by Andrew James Kinsey on 9/13/17.
//  Copyright © 2017 The Cabinents. All rights reserved.
//

import UIKit

class ViewController: UITableViewController
{
    var facts = [String]()
    let query = "http://numbersapi.com/1..100"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Numbers"
        DispatchQueue.global(qos: .userInitiated).async
            {
                [unowned self] in
                if let url = URL(string: self.query)
        {
            if let data = try?Data(contentsOf: url)
            {
                let json = try! JSON(data: data)
                self.parse(json: json)
                return
            }
        }
        }
    }

    func parse(json: JSON)
    {
        print(json["1"].stringValue)
        for index in 1...100
        {
            facts.append(json["\(index)"].stringValue)
            //print(facts) uncomment for api data pull test
        }
        DispatchQueue.main.async
        {
                [unowned self] in
                self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return facts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1)"
        cell.detailTextLabel?.text = ""
        return cell
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any)
    {
        facts.removeAll()
        DispatchQueue.global(qos: .userInitiated).async
            {
                [unowned self] in
                if let url = URL(string: self.query)
                {
                    if let data = try?Data(contentsOf: url)
                    {
                        let json = try! JSON(data: data)
                        self.parse(json: json)
                        return
                    }
                }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! DetailFactViewController
        let index = tableView.indexPathForSelectedRow?.row
        dvc.fact = facts[index!]
        let number = index! + 1
        dvc.number = "\(number)"
    }
}

