import Foundation
import RealmSwift

final class RealmAPI {
    static let shared = RealmAPI()
    let realm: Realm;
    
    private init() {
        let fileManager = FileManager.default
        let directory = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.uday.password")!
        let realmPath = directory.appendingPathComponent("db.realm")
        Realm.Configuration.defaultConfiguration = Realm.Configuration(fileURL: realmPath)
        realm = try! Realm()
    }
    
    func write(data: Object) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func delete(data: Object) {
        try! realm.write {
            realm.delete(data)
        }
    }
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func update(data: Object) {
        try! realm.write {
            realm.add(data, update: .modified)
        }
    }
    
    
    func updateCredentialPassword(for data: Credential, with password: String) {
        try! realm.write {
            data.setPassword(password)
        }
    }

    
    func read(filterBy credentialID: String) -> Credential {
        return realm.objects(Credential.self).filter("credentialID = '\(credentialID)'").first!
    }
    
    func readCredentialById(queryWith credentialID: String) -> Credential {
        return realm.object(ofType: Credential.self, forPrimaryKey: credentialID)!
    }
    
    func readAll() -> Results<Credential> {
        return realm.objects(Credential.self)
    }
}
