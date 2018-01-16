//
//  DetailViewController.swift
//  cdbrowser2
//
//  Created by Użytkownik Gość on 19.10.2017.
//  Copyright © 2017 Użytkownik Gość. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var currentID: Int = 0
    var mvController: MasterViewController?
    
    @IBOutlet weak var wykonawca: UITextField!
    @IBOutlet weak var tytul: UITextField!
    @IBOutlet weak var gatunek: UITextField!
    @IBOutlet weak var rokWydania: UITextField!
    @IBOutlet weak var liczbaSciezek: UITextField!
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let tempPlyta = Plyta(wykonawca: self.wykonawca.text!, tytul: self.tytul.text!, gatunek: self.gatunek.text!, rok: Int(self.rokWydania.text!)!, liczbaSciezek: Int(self.liczbaSciezek.text!)!)
        
        mvController?.updateRecord(updatedRecord: tempPlyta, id: currentID)
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if (self.wykonawca) != nil {
                //label.text = detail.description
                wykonawca.text = detail.wykonawca
                tytul.text = detail.tytul
                gatunek.text = detail.gatunek
                rokWydania.text = String(detail.rok)
                liczbaSciezek.text = String(detail.liczbaSciezek)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Plyta? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    

    
}

