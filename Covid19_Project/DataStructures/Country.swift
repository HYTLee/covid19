

struct Country: Codable {
    var country: String
    var Latest: Latest
}



struct Latest: Codable {
    var confirmed: Int
    var death: Int
}
