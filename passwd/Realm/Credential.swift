import Foundation
import RealmSwift

class Credential: Object {
    
    @objc dynamic var credentialID = UUID().uuidString
    @objc dynamic var username = ""
    @objc dynamic var password = ""
    
    override static func primaryKey() -> String? {
        return "credentialID"
    }
    convenience init(username: String, password: String) {
        self.init()
        self.username = username
        self.password = password
    }
    
    func setPassword(_ password: String) {
        self.password = password
    }
}
