import RealmSwift

class Item: Object {
    
    @objc dynamic var ID: String = UUID().uuidString
    @objc dynamic var textString = ""
    @objc dynamic var timestamp: Date = Date()
    @objc dynamic var isDone: Bool = false
    
    override static func primaryKey() -> String? {
        return "ID"
    }
    
}
