// zad. 1

var ciagZnakow = "Przykładowy ciąg znaków."
var liczbaCalkowita = 5;
var liczbaRzeczywista = 5.5;

// zad. 2

let ciagZnakow: String
let liczbaCalkowta: Int
let liczbaRzeczywista: Double

ciagZnakow = "Przykladowy ciag znakow."
liczbaCalkowta = 5
liczbaRzeczywista = 5.5

// zad. 3

let ver1 = ciagZnakow + " " + String(liczbaRzeczywista)
let ver2 = ciagZnakow + " \(liczbaRzeczywista)"

// zad. 4

var kolejneCyfry = [0, 1, 2, 3, 4, 5, 6, 7, 8]
var kolejneLitery = ["litera0": "A", "litera1": "B", "litera2": "C"]

// zad. 5

kolejneCyfry += [9]
kolejneLitery["litera3"] = "D"

// zad. 6

var lotto = [String: [Int]]()
lotto = ["05-10-17": [1, 2, 3, 4, 5, 6], "06-10-17": [9, 8, 6, 5, 4, 3]]

// zad. 7

var tablica2 = [String: Int]()

// zad. 8

var tablica2 = [String: Int]()
var pomocnicza = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]

for i in 0...pomocnicza.count-1 {
	tablica2[pomocnicza[i]] = i+1
}

// zad. 9

lotto.forEach {
	print("Losowanie dnia " + $0.key);
	
	for i in 0...($0.value).count-1 {
		print("- " + String($0.value[i]))
	}
}

// zad. 10

func nwd(liczba1: Int, liczba2: Int) -> Int {
	var a = liczba1
	var b = liczba2
	
	while (a != b) {
		if (a > b) {
			a = a - b
		}
		else {
			b = b - a
		}
	}
	
	return a
}

// zad. 11

func nwd_v2(liczba1: Int, liczba2: Int) -> (dzielnik: Int, iloraz1: Double, iloraz2: Double) {
	var a = liczba1
	var b = liczba2
	
	while (a != b) {
		if (a > b) {
			a = a - b
		}
		else {
			b = b - a
		}
	}
	
	return (a, Double(liczba1)/Double(a), Double(liczba2)/Double(a))
}

// zad. 12

func change_letter(litera1: Character) -> Character {
	if (litera1 == "G"){
		return "A"
	}
	else if (litera1 == "D"){
		return "E"
	}
	else if (litera1 == "R"){
		return "Y"
	}
	else if (litera1 == "P"){
		return "O"
	}
	else if (litera1 == "L"){
		return "U"
	}
	else if (litera1 == "K"){
		return "I"
	}
	else {
		return litera1
	}
}

func cipher(slowo: String, letters_func: (Character) -> (Character)) -> String {
	var returned = ""
	
	for i in 0...slowo.characters.count-1 {
		var str = slowo.uppercased()
		let index = str.characters.index(str.startIndex, offsetBy: i)
        let startChar = str[index]
		
		returned += String(letters_func(startChar))
	}
	
	return slowo
}

// zad. 13

var lotto = [String: [Int]]()
lotto = ["05-10-17": [1, 2, 3, 4, 5, 6], "06-10-17": [9, 8, 6, 5, 4, 3]]

lotto.forEach {
	for i in 0...($0.value).count-1 {
		let numbers2 = $0.value.map({
			(number: Int) -> Int in
		return number % 2
		})
		
		print(numbers2)
	}
}

// zad. 14

class NamedObject {
	var Name = "Przykladowe imie"
	
	func describe() -> String {
		return "Klasa zawiera pole Name. Jej wartosc to: " + Name
	}
}

// zad. 15

class Sphere: NamedObject {
	var radius: Double!
	
	init(Name: String, radius: Double) {
		self.Name = Name
		self.radius = radius
	}
	
	func computeVolume() -> Double {
		return pow((4/3)*3.14*radius, 3)
	}
	
	func getVolume(v: Double) {
		radius = pow(((3*v)/(4*3.14)), (1/3))
	}
	
	override func describe() -> String {
		return "Klasa zawiera pole Name oraz radius. Wartosc tej pierwszej to: " + Name + ", natomiast tej drugiej: " + String(radius)
	}
}