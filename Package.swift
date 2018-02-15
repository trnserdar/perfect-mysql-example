// Generated automatically by Perfect Assistant Application
// Date: 2018-02-09 08:22:59 +0000
import PackageDescription
let package = Package(
	name: "mysql-test",
	targets: [],
	dependencies: [
        .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2),
		.Package(url: "https://github.com/PerfectlySoft/Perfect-MySQL.git", majorVersion: 2),
        .Package(url: "https://github.com/SwiftORM/MySQL-StORM.git", majorVersion: 1),
        .Package(url: "https://github.com/PerfectlySoft/Perfect-Mustache.git", majorVersion: 2)
	]
)
