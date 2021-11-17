import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()

    // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
    let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: urlString) else { return }
        guard let data = try? Data(contentsOf: url) else { return }

        parse(json: data)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]

        // cell.textLabel?.text = "Title goes here"
        // cell.detailTextLabel?.text = "Subtitle goes here"

        cell.textLabel = petition.title
        cell.detailTextLabel = petition.body

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    func parse(json data: Data) {
        let decoder = JSONDecoder()

        guard let decodedPetitions = try? decoder.decode(Petitions.self, from: data) else { return }

        petitions = decodedPetitions.results
        tableView.reloadData()
    }
}
