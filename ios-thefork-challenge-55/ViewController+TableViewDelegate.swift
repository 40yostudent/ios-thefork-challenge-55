import UIKit

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.dataSource.restaurantCellList[indexPath.row].favourite.toggle()
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
