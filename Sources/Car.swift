import StORM
import MySQLStORM

class Car: MySQLStORM {
    
    var id: Int = 0
    var brand: String = ""
    var model: String = ""
    
    override open func table() -> String { return "Cars" }
    
    override func to(_ this: StORMRow) {
        
        if let id = this.data["id"] as? Int32 {
           self.id = Int(id)
        }
    
        brand = this.data["brand"] as? String ?? ""
        model = this.data["model"] as? String ?? ""
    }
    
    func rows() -> [Car] {
        var rows = [Car]()
        
        for i in 0..<self.results.rows.count {
            let row = Car()
            row.to(self.results.rows[i])
            rows.append(row)
        }
        
        return rows
    }
    
    func asDictionary() -> [String : Any] {
        return [
            "id" : self.id,
            "brand" : self.brand,
            "model" : self.model
        ]
    }
    
    static func getAll() throws -> [Car] {
        let getObj = Car()
        try getObj.findAll()
        return getObj.rows()
    }
    
    static func getFirst() throws -> Car? {
        let getObj = Car()
        let cursor = StORMCursor(limit: 1, offset: 0)
        try getObj.select(whereclause: "true", params: [], orderby: [], cursor: cursor)
        return getObj.rows().first
    }
    
    static func getCar(withId id:Int) throws -> Car {
        let getObj = Car()
        var findObj = [String:Any]()
        findObj["id"] = "\(id)"
        try getObj.find(findObj)
        return getObj
    }
    
    static func getCars(withBrand brand:String) throws -> [Car] {
        let getObj = Car()
        try getObj.select(whereclause: "brand = ?", params: ["\(brand)"], orderby: ["id"])
        return getObj.rows()
    }

    static func getCars(withModel model:String) throws -> [Car] {
        let getObj = Car()
        try getObj.select(whereclause: "model = ?", params: ["\(model)"], orderby: ["id"])
        return getObj.rows()
    }
    
    static func addCar(brand: String, model: String) throws -> Car {
        let car = Car()
        car.brand = brand
        car.model = model
        try car.save(set: { (id) in
            car.id = id as! Int
        })
        return car
    }

    static func updateCar(id: Int, brand: String, model: String) throws -> Car {
        let car = try Car.getCar(withId: id)
        car.brand = brand
        car.model = model
        try car.save()
        return car
    }
    
    static func deleteCar(id: Int) throws {
        let car = try Car.getCar(withId: id)
        try car.delete()
    }
}

