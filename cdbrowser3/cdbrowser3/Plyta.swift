//
//  browseWeb.swift
//  cdbrowser
//
//  Created by Użytkownik Gość on 12.10.2017.
//  Copyright © 2017 Użytkownik Gość. All rights reserved.
//

import Foundation

class Plyta {
    
    var wykonawca: String
    var tytul: String
    var gatunek: String
    var rok: Int
    var liczbaSciezek: Int
    
    init(wykonawca: String, tytul: String, gatunek: String, rok: Int, liczbaSciezek: Int) {
        self.wykonawca = wykonawca
        self.tytul = tytul
        self.gatunek = gatunek
        self.rok = rok
        self.liczbaSciezek = liczbaSciezek
    }
    
    func getArray() -> [String] {
        return [wykonawca, tytul, gatunek, String(rok), String(liczbaSciezek)]
    }
    
    init(array: [String]){
        self.wykonawca = array[0]
        self.tytul = array[1]
        self.gatunek = array[2]
        self.rok = Int(array[3])!
        self.liczbaSciezek = Int(array[4])!
    }
}

