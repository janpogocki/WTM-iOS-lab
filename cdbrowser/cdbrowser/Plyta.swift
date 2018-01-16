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
}
