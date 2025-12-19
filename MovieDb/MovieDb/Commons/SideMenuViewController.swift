import UIKit

final class SideMenuViewController: UIViewController {
    var onItemSelected: ((SideMenuItem) -> Void)?
    private let tableView = UITableView()
    private let items: [SideMenuItem] = [.movies, .search, .favorites]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupTableView()
    }
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:
                            "cell")
        view.addSubview(tableView)
        
    }
}
extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:
                   Int) -> Int {
        items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:
                   IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath:
                   IndexPath) {
        onItemSelected?(items[indexPath.row])
    }
}
