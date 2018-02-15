import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

import StORM
import MySQLStORM

MySQLConnector.host = "127.0.0.1"
MySQLConnector.username = "root"
MySQLConnector.password = "123"
MySQLConnector.database = "perfect-mysql"
MySQLConnector.port = 3306

let setupObj = Car()
try? setupObj.setup()

let server = HTTPServer()
server.serverPort = 8080
server.documentRoot = "webroot"

let carController = CarController()
server.addRoutes(Routes(carController.routes))

let mustacheController = MustacheController()
server.addRoutes(Routes(mustacheController.routes))

do {
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
