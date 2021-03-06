//
//  ViewController.swift
//  project7
//
//  Created by Anisha Lamichhane on 6/27/20.
//  Copyright © 2020 Anisha Lamichhane. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString : String
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target:self, action: #selector(showMessage))
        
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
            
        } else  {
             urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
           
        
        if let  url = URL(string: urlString) {
            if let data = try?Data(contentsOf: url){
            parse(json: data)
                return
                
            }
        }
        showError() 
    }
    @objc func showMessage() {
        let showCredits = UIAlertController(title: "This data comes from the We The People API of the Whitehouse.", message: nil, preferredStyle: .alert)
        showCredits.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(showCredits, animated: true)
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed; Please check your connection and try again!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ok", style: .default))
        present(ac, animated: true)
    }
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try?decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell 
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
