import UIKit

struct RestaurantCellData {
    let name: String
    let uuid: String
    let rating: Double
    let address: String
    let imageUrl: String
    
    var favourite: Bool {
        willSet {
            UserDefaults.standard.set(newValue, forKey: self.uuid)
        }
    }
}
