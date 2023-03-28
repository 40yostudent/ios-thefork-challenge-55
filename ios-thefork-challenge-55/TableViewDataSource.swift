import UIKit
import Combine

class TableViewDataSource: NSObject, UITableViewDataSource {
    
    weak var tableView: UITableView!
    
    var fetchRestaurantsList: AnyCancellable?
    var fetchImagesList: AnyCancellable?
    
    var restaurants = Restaurants(data: [])
    var restaurantCellList: [RestaurantCellData] = []
    
    var imageCache: [String : UIImage] = [:] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.restaurantCellList.count > 0) ? self.restaurantCellList.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        if restaurantCellList.count > 0 { // if data are loaded
            let restaurantForCell = restaurantCellList[indexPath.row]
            
            cell.coverView.image = fetchImage(from: restaurantForCell.imageUrl)
            cell.titleLabel.text = restaurantForCell.name
            cell.addressLabel.text = restaurantForCell.address
            cell.ratingLabel.text = restaurantForCell.rating.description
            cell.favourite = restaurantForCell.favourite
        }
        return cell
    }
    
    func fetchRestaurants() {
        let url = URL(string: "https://alanflament.github.io/TFTest/test.json")!
        
        self.fetchRestaurantsList = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Restaurants.self, decoder: JSONDecoder())
            .replaceError(with: Restaurants(data: []))
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    for restaurant in self.restaurants.data {
                        self.restaurantCellList.append(
                            RestaurantCellData(name: restaurant.name,
                                               uuid: restaurant.uuid,
                                               rating: restaurant.aggregateRatings.thefork.ratingValue,
                                               address: restaurant.address.street +
                                               ", " + restaurant.address.locality,
                                               imageUrl: restaurant.mainPhoto?.w664h374 ?? "",
                                               favourite: UserDefaults.standard.bool(forKey: restaurant.uuid))
                        )}
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { value in
                self.restaurants = value
            })
    }
    
    func fetchImage(from string: String) -> UIImage {
        if let url = URL(string: string) {
            
            if let image = imageCache[string] {
                return image
            } else {
                self.fetchImagesList = URLSession.shared.dataTaskPublisher(for: url)
                    .map { UIImage(data: $0.data) }
                    .replaceError(with: UIColor.gray.imageWithColor(width: 1, height: 1))
                    .receive(on: RunLoop.main)
                    .retry(1)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }, receiveValue: { value in
                        if let value = value {
                            self.imageCache[string] = value
                        }
                    })
            }
        }
        return imageCache[string] ?? UIColor.gray.imageWithColor(width: 1, height: 1)
    }
}
