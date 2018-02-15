//
//  MustacheController.swift
//  PerfectLib
//
//  Created by serdar on 14.02.2018.
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectMustache

final class MustacheController {
    
    let documentRoot = "./webroot"
    
    var routes: [Route] {
        return [
            Route(method: .get, uri: "/cars", handler: indexView),
            Route(method: .post, uri: "/cars", handler: addCar),
            Route(method: .post, uri: "/cars/{id}/delete", handler: deleteCar)
        ]
    }
    
    func indexView(request: HTTPRequest, response: HTTPResponse) {
        
        do {
            var values = MustacheEvaluationContext.MapType()
            values["cars"] = try CarAPI.allAsDictionary()
            mustacheRequest(request: request, response: response, handler: MustacheHelper(values: values), templatePath: request.documentRoot + "/index.mustache")
        } catch {
            response.setBody(string: "Error handling request: \(error)")
                .completed(status: .internalServerError)
        }
    }
    
    func addCar(request: HTTPRequest, response: HTTPResponse) {
        
        do {
            
            guard let brand = request.param(name: "brand"),
                let model = request.param(name: "model") else {
                    response.completed(status: .badRequest)
                    return
            }
        
            _ = try CarAPI.addCar(brand: brand, model: model)
            
            response.setHeader(.location, value: "/cars")
                .completed(status: .movedPermanently)
            
        } catch {
            response.setBody(string: "Error handling request: \(error)")
                .completed(status: .internalServerError)
        }
    }
    
    func deleteCar(request: HTTPRequest, response: HTTPResponse) {
        
        do {
            guard let idString = request.urlVariables["id"],
                let id = Int(idString) else {
                    response.completed(status: .badRequest)
                    return
            }
            
            try CarAPI.deleteCar(id: id)
        
            response.setHeader(.location, value: "/cars")
                .completed(status: .movedPermanently)
            
        } catch {
            response.setBody(string: "Error handling request: \(error)")
                .completed(status: .internalServerError)
        }
    }
    
}

