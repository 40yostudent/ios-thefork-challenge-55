import Foundation

public struct Restaurants: Codable {
    let data: [Restaurant]
}

public struct Restaurant: Codable {
    let name, uuid, servesCuisine, currenciesAccepted: String
    let priceRange: Int
    let address: Address
    let aggregateRatings: AggregateRatings
    let mainPhoto: MainPhoto?
    let bestOffer: BestOffer
}

 public struct Address: Codable {
    let street, postalCode, locality, country: String
}

public struct AggregateRatings: Codable {
    let thefork, tripadvisor: Rating
}
 
public struct Rating: Codable {
    let ratingValue: Double
    let reviewCount: Int
}

public struct MainPhoto: Codable {
    let source,
        w612h344, w480h270, w240h135,
        w664h374, w1350h759, w160h120,
        w80h60, w92h92, w184h184: String

    enum CodingKeys: String, CodingKey {
        case source
        case w612h344 = "612x344"
        case w480h270 = "480x270"
        case w240h135 = "240x135"
        case w664h374 = "664x374"
        case w1350h759 = "1350x759"
        case w160h120 = "160x120"
        case w80h60 = "80x60"
        case w92h92 = "92x92"
        case w184h184 = "184x184"
    }
}

public struct BestOffer: Codable {
    let name, label: String
}
