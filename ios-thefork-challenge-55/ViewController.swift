import UIKit

class ViewController: UIViewController {
    
    let dataSource = TableViewDataSource()
    
    weak var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        
        self.tableView = {
            let this = UITableView(frame: .zero, style: .plain)
            this.translatesAutoresizingMaskIntoConstraints = false
            this.rowHeight = 256
            self.view.addSubview(this)
            
            NSLayoutConstraint.activate([
                self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: this.topAnchor),
                self.view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: this.bottomAnchor),
                self.view.leadingAnchor.constraint(equalTo: this.leadingAnchor),
                self.view.trailingAnchor.constraint(equalTo: this.trailingAnchor),
            ])
            return this
        }()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.dataSource.fetchRestaurants()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        
        self.dataSource.tableView = self.tableView
        self.dataSource.fetchRestaurantsList?.cancel()
    }
}

