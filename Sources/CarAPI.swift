import Foundation

class CarAPI {
    
    static func carsToDictionary(cars : [Car]) -> [[String : Any]] {
        var carsDict: [[String : Any]] = []
        for row in cars {
            carsDict.append(row.asDictionary())
        }
        return carsDict
    }
    
    static func getAll() throws -> String {
        let cars = try Car.getAll()
        return try carsToDictionary(cars: cars).jsonEncodedString()
    }
    
    static func allAsDictionary() throws -> [[String : Any]] {
        let cars = try Car.getAll()
        return carsToDictionary(cars: cars)
    }
    
    static func getFirst() throws -> String {
        if let car = try Car.getFirst() {
            return try car.asDictionary().jsonEncodedString()
        } else {
            return try ["message": "Somethings went wrong"].jsonEncodedString()
        }
    }
    
    static func getCar(withId id: Int) throws -> String {
        let car = try Car.getCar(withId: id)
        return try car.asDictionary().jsonEncodedString()
    }
    
    static func getCars(withBrand brand: String) throws -> String {
        let cars = try Car.getCars(withBrand: brand)
        return try carsToDictionary(cars: cars).jsonEncodedString()
    }
    
    static func getCars(withModel model: String) throws -> String {
        let cars = try Car.getCars(withModel: model)
        return try carsToDictionary(cars: cars).jsonEncodedString()
    }
    
    static func addCar(brand: String, model: String) throws -> String {
        let car = try Car.addCar(brand: brand, model: model)
        return try car.asDictionary().jsonEncodedString()
    }
    
    static func updateCar(id: Int, brand: String, model: String) throws -> String {
        let car = try Car.updateCar(id: id, brand: brand, model: model)
        return try car.asDictionary().jsonEncodedString()
    }
    
    static func deleteCar(id: Int) throws {
        try Car.deleteCar(id: id)
    }
}
