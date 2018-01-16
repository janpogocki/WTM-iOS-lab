//
//  ViewController.swift
//  cdbrowser
//
//  Created by Użytkownik Gość on 12.10.2017.
//  Copyright © 2017 Użytkownik Gość. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var arrayOfCD: [Plyta] = []
    var currentCD: Int = 0
    var newRecord: Bool = false
    
    @IBOutlet weak var wykonawca: UITextField!
    @IBOutlet weak var tytul: UITextField!
    @IBOutlet weak var gatunek: UITextField!
    @IBOutlet weak var liczbaSciezek: UITextField!
    @IBOutlet weak var rok: UITextField!
    @IBOutlet weak var previous: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var recordXofY: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func wykonawcaChanged(_ sender: Any) {
        self.saveButton.isEnabled = true
    }
    @IBAction func tytulChanged(_ sender: Any) {
        self.saveButton.isEnabled = true
    }
    
    @IBAction func gatunekChanged(_ sender: Any) {
        self.saveButton.isEnabled = true
    }
    
    @IBAction func rokChanged(_ sender: Any) {
        self.saveButton.isEnabled = true
    }
    
    @IBAction func liczbaSciezekChanged(_ sender: Any) {
        self.saveButton.isEnabled = true
    }
    
    @IBAction func newRecord(_ sender: Any) {
        self.wykonawca.text = ""
        self.tytul.text = ""
        self.gatunek.text = ""
        self.liczbaSciezek.text = ""
        self.rok.text = ""
        
        self.recordXofY.text = "Nowy rekord"
        self.saveButton.isEnabled = true
        self.deleteButton.isEnabled = false
        self.newRecord = true
    }
    
    @IBAction func deleteCurrent(_ sender: Any) {
        if (self.arrayOfCD.count > 1) {
            self.arrayOfCD.remove(at: self.currentCD)
            
            if (self.currentCD == 0){
                self.currentCD = 0
            }
            else {
                self.currentCD = self.currentCD - 1
            }
            
            setCurrentScreen()
        }
    }
    
    @IBAction func saveCurrent(_ sender: Any) {
        let tempPlyta = Plyta(wykonawca: self.wykonawca.text!, tytul: self.tytul.text!, gatunek: self.gatunek.text!, rok: Int(self.rok.text!)!, liczbaSciezek: Int(self.liczbaSciezek.text!)!)
        
        if (self.newRecord){
            self.currentCD = self.arrayOfCD.count
            self.arrayOfCD.append(tempPlyta)
            
            self.newRecord = false
        }
        else {
            self.arrayOfCD[self.currentCD] = tempPlyta
        }
        
        setCurrentScreen()
    }
    
    
    @IBAction func previousAction(_ sender: Any) {
        self.newRecord = false
        self.currentCD = self.currentCD - 1
        setCurrentScreen()
    }
    
    
    @IBAction func nextAction(_ sender: Any) {
        self.newRecord = false
        
        if (self.currentCD == self.arrayOfCD.count-1){
            self.currentCD = self.currentCD + 1
            self.newRecord(sender)
            self.nextButton.isEnabled = false
        }
        else {
            self.currentCD = self.currentCD + 1
            setCurrentScreen()
        }
    }
    
    func setCurrentScreen(){
        self.wykonawca.text = self.arrayOfCD[self.currentCD].wykonawca
        self.tytul.text = self.arrayOfCD[self.currentCD].tytul
        self.gatunek.text = self.arrayOfCD[self.currentCD].gatunek
        self.rok.text = String(self.arrayOfCD[self.currentCD].rok)
        self.liczbaSciezek.text = String(self.arrayOfCD[self.currentCD].liczbaSciezek)
        
        // previous & next buttons
        if (self.newRecord){
            self.nextButton.isEnabled = false
        }
        
        if (self.arrayOfCD.count == 1){
            self.previous.isEnabled = false
            self.nextButton.isEnabled = true
        }
        else if (self.currentCD == 0) {
            self.previous.isEnabled = false
            self.nextButton.isEnabled = true
        }
        else if (self.currentCD == self.arrayOfCD.count-1) {
            self.previous.isEnabled = true
            self.nextButton.isEnabled = true
        }
        else {
            self.previous.isEnabled = true
            self.nextButton.isEnabled = true
        }
        
        // delete button
        if (self.arrayOfCD.count > 1) {
            self.deleteButton.isEnabled = true
        }
        else {
            self.deleteButton.isEnabled = false
        }
        
        self.saveButton.isEnabled = false
        
        self.recordXofY.text = "Rekord " + String(currentCD+1) + " z " + String(arrayOfCD.count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
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
            
            self.currentCD = 0
    
            // update view in main thread
            DispatchQueue.main.async {
                self.setCurrentScreen()
            }
        }
        
        zadanie.resume()
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

