struct Visitor: CustomStringConvertible {
    var description: String {
        get {
            return "\(name): \(time)"
        }
    }
    
    let name: String
    let time: String
}
