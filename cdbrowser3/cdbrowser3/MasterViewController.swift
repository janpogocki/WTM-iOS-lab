//
//  MasterViewController.swift
//  cdbrowser2
//
//  Created by Użytkownik Gość on 19.10.2017.
//  Copyright © 2017 Użytkownik Gość. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var arrayOfCD: [Plyta] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        // check if local cache exists
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        
        if (FileManager.default.fileExists(atPath: documentsPath! + "/albums.txt")){
            // file exists - read it
            let arrayOfCD2 = NSKeyedUnarchiver.unarchiveObject(withFile: documentsPath! + "/albums.txt") as! [[String]]
            
            for i in 0...arrayOfCD2.count-1 {
                arrayOfCD.append(Plyta(array: arrayOfCD2[i]))
            }
        }
        else {
            // download file from internet
            var json: [Dictionary<String, Any>] = []
            let url = URL(string: "https://isebi.net/albums.php")
            let zadanie = URLSession.shared.dataTask(with: url!) {
                (data, response, error) in
                
                json = (try! JSONSerialization.jsonObject(with: data!, options: []) as? [Dictionary<String, Any>])!
                
                // to do with json
                var i = 0
                while (i < json.count){
                    let tempPlyta = Plyta(wykonawca: json[i]["artist"]! as! String, tytul: json[i]["album"]! as! String, gatunek: json[i]["genre"]! as! String, rok: json[i]["year"]! as! Int, liczbaSciezek: json[i]["tracks"]! as! Int)
                    
                    self.arrayOfCD.append(tempPlyta)
                    
                    i=i+1
                }
                
                // update view in main thread
                DispatchQueue.main.async {
                    self.updateTableView()
                }
            }
            
            zadanie.resume()
        }
    }
    
    func updateTableView(){
        self.tableView.reloadData()
        
        // save cache to file
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        var arrayOfCD2: [[String]] = []
        
        for i in 0...arrayOfCD.count-1 {
            arrayOfCD2.append(arrayOfCD[i].getArray())
        }
        
        NSKeyedArchiver.archiveRootObject(arrayOfCD2, toFile: documentsPath! + "/albums.txt")
    }
    
    func updateRecord(updatedRecord: Plyta, id: Int){
        self.arrayOfCD[id] = updatedRecord
        updateTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(_ sender: Any) {
        let newPlyta = Plyta(wykonawca: "Nowy wykonawca", tytul: "Nowy tytul", gatunek: "Nowy gatunek", rok: 2017, liczbaSciezek: 0)
        
        self.arrayOfCD.insert(newPlyta, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = self.arrayOfCD[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.currentID = indexPath.row
                controller.mvController = self
                controller.navigationItem.title = "Edycja rekordu " + String(indexPath.row+1) + " z " + String(self.arrayOfCD.count)
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfCD.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cdCell", for: indexPath)

        (cell.viewWithTag(101) as! UILabel).text = self.arrayOfCD[indexPath.row].tytul
        (cell.viewWithTag(102) as! UILabel).text = self.arrayOfCD[indexPath.row].wykonawca
        (cell.viewWithTag(103) as! UILabel).text = String(self.arrayOfCD[indexPath.row].rok)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.arrayOfCD.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

