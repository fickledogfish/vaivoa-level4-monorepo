import UIKit

class ViewController: UITableViewController {
    let animated = true

    var loadedPetitions = [Petition]()
    var displayedPetitions = [Petition]()
    var currentFilter: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString: String

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Credits",
            style: .plain,
            target: self,
            action: #selector(showCredits)
        )

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Filter",
            style: .plain,
            target: self,
            action: #selector(filterPetitions)
        )

        if navigationController?.tabBarItem.tag == 0 {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let url = URL(string: urlString) else {
                self?.showError()
                return
            }
            guard let data = try? Data(contentsOf: url) else {
                self?.showError()
                return
            }

            self?.parse(json: data)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayedPetitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = displayedPetitions[indexPath.row]

        //cell.textLabel?.text = petition.title
        //cell.detailTextLabel?.text = petition.body

        cell.textLabel = petition.title
        cell.detailTextLabel = petition.body

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.detailItem = displayedPetitions[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: animated)
    }

    @objc func showCredits() {
        let alertController = UIAlertController(
            title: "Credits",
            message: "This data comes from the We The People API",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "k", style: .default))
        present(alertController, animated: animated)
    }

    @objc func filterPetitions() {
        let alertController = UIAlertController(
            title: "Filter",
            message: "Enter the string to filter",
            preferredStyle: .alert
        )

        alertController.addTextField { textField in
            textField.placeholder = "keywords"
        }
        alertController.addAction(UIAlertAction(
            title: "Filter",
            style: .default,
            handler: { [weak self, weak alertController] _ in
                let filterKeys = (alertController?.textFields?.first?.text ?? "")
                    .split(separator: " ")

                self?.displayedPetitions = self?.loadedPetitions.filter { petition in
                    let title = petition.title.lowercased()
                    let body = petition.body.lowercased()

                    return title.contains(any: filterKeys) || body.contains(any: filterKeys)
                } ?? []

                self?.tableView.reloadData()
            }
        ))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(
            title: "Remove filters",
            style: .destructive,
            handler: { [weak self] _ in
                self?.displayedPetitions = self?.loadedPetitions ?? []
                self?.tableView.reloadData()
            }
        ))

        present(alertController, animated: animated)
    }

    func showError() {
        DispatchQueue.main.async { [weak self] in
            let alertController = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            self?.present(alertController, animated: self?.animated ?? true)
        }
    }

    func parse(json data: Data) {
        let decoder = JSONDecoder()

        guard let decodedPetitions = try? decoder.decode(Petitions.self, from: data) else { return }

        loadedPetitions = decodedPetitions.results
        displayedPetitions = loadedPetitions

        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
