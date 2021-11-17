import UIKit

class ViewController: UITableViewController {
    var petitions = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // cell.textLabel?.text = "Title goes here"
        // cell.detailTextLabel?.text = "Subtitle goes here"

        cell.textLabel = "Title goes here"
        cell.detailTextLabel = "Subtitle goes here"

        return cell
    }
}
