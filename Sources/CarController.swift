import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

final class CarController {
    
    var routes: [Route] {
        return [
            Route(method: .get, uri: "/getCars", handler: getCars),
            Route(method: .get, uri: "/getFirstCar", handler: getFirstCar),
            Route(method: .post, uri: "/getCarWithId", handler: getCarWithId),
            Route(method: .post, uri: "/getCarsWithBrand", handler: getCarsWithBrand),
            Route(method: .post, uri: "/getCarsWithModel", handler: getCarsWithModel),
            Route(method: .post, uri: "/addCar", handler: addCar),
            Route(method: .post, uri: "/updateCar", handler: updateCar),
            Route(method: .post, uri: "/deleteCar", handler: deleteCar)
        ]
    }
    
    func getCars(request: HTTPRequest, response: HTTPResponse) {
        
        do {
            let json = try CarAPI.getAll()
            response.setBody(string: json)
                .setHeader(.contentType, value: "application/json")
                .completed()
        } catch {
            response.setBody(string: "Error when list cars: \(error.localizedDescription)")
                .completed()
        }
    }
    
    func getFirstCar(request: HTTPRequest, response: HTTPResponse) {
        
        do {
            let json = try CarAPI.getFirst()
            response.setBody(string: json)
                .setHeader(.contentType, value: "application/json")
                .completed()
        } catch {
            response.setBody(string: "Error when get first car: \(error.localizedDescription)")
                .completed()
        }
    }
    
    func getCarWithId(request: HTTPRequest, response: HTTPResponse) {
        
        do {
            guard let postJSON = request.postBodyString,
                let dict = try postJSON.jsonDecode() as? [String : Any],
                let id = dict["id"] as? Int else {
                    try response.setBody(json: ["message": "Error when json convert"])
                    .completed()
                    return
            }
 
            let json = try CarAPI.getCar(withId: id)
            response.setBody(string: json)
                .setHeader(.contentType, value: "application/json")
                .completed()
        } catch {
            response.setBody(string: "Error when get car with id: \(error.localizedDescription)")
                .completed()
        }
    }
    
    func getCarsWithBrand(request: HTTPRequest, response: HTTPResponse) {
        
        do {
            guard let postJSON = request.postBodyString,
                let dict = try postJSON.jsonDecode() as? [String : Any],
                let brand = dict["brand"] as? String else {
                    try response.setBody(json: ["message": "Error when json convert"])
                        .completed()
                    return
            }
            
            let json = try CarAPI.getCars(withBrand: brand)
            response.setBody(string: json)
                .setHeader(.contentType, value: "application/json")
                .completed()
        } catch {
            response.setBody(string: "Error when get car with brand: \(error.localizedDescription)")
                .completed()
        }
    }
    
    func getCarsWithModel(request: HTTPRequest, response: HTTPResponse) {
        
        do {
            guard let postJSON = request.postBodyString,
                let dict = try postJSON.jsonDecode() as? [String : Any],
                let model = dict["model"] as? String else {
                    try response.setBody(json: ["message": "Error when json convert"])
                        .completed()
                    return
            }
            
            let json = try CarAPI.getCars(withModel: model)
            response.setBody(string: json)
                .setHeader(.contentType, value: "application/json")
                .completed()
        } catch {
            response.setBody(string: "Error when get car with model: \(error.localizedDescription)")
                .completed()
        }
    }
    
    func addCar(request: HTTPRequest, response: HTTPResponse) {
        
        do {
            guard let postJSON = request.postBodyString,
                let dict = try postJSON.jsonDecode() as? [String : Any],
                let brand = dict["brand"] as? String,
                let model = dict["model"] as? String else {
                    try response.setBody(json: ["message": "Error when json convert"])
                        .completed()
                    return
            }
            
            let json = try CarAPI.addCar(brand: brand, model: model)
            response.setBody(string: json)
                .setHeader(.contentType, value: "application/json")
                .completed()
        } catch {
            response.setBody(string: "Error when add car: \(error.localizedDescription)")
                .completed()
        }
    }
    
    func updateCar(request: HTTPRequest, response: HTTPResponse) {
        
        do {
            guard let postJSON = request.postBodyString,
                let dict = try postJSON.jsonDecode() as? [String : Any],
                let id = dict["id"] as? Int,
                let brand = dict["brand"] as? String,
                let model = dict["model"] as? String else {
                    try response.setBody(json: ["message": "Error when json convert"])
                        .completed()
                    return
            }
            
            let json = try CarAPI.updateCar(id: id, brand: brand, model: model)
            response.setBody(string: json)
                .setHeader(.contentType, value: "application/json")
                .completed()
        } catch {
            response.setBody(string: "Error when update car: \(error.localizedDescription)")
                .completed()
        }
    }
    
    func deleteCar(request: HTTPRequest, response: HTTPResponse) {
        
        do {
            guard let postJSON = request.postBodyString,
                let dict = try postJSON.jsonDecode() as? [String : Any],
                let id = dict["id"] as? Int else {
                    try response.setBody(json: ["message": "Error when json convert"])
                        .completed()
                    return
            }
            
            try CarAPI.deleteCar(id: id)
            try response.setBody(json: ["message": "Successful"])
                .setHeader(.contentType, value: "application/json")
                .completed()
        } catch {
            response.setBody(string: "Error when delete car: \(error.localizedDescription)")
                .completed()
        }
    }

}
