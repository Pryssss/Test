import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var sectionData: [Int: Article] = [:]
    
    var searching = false
    var tableData: ([Article]) = []
    var seacrhData: ([Article]) = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
//        seacrhBar.delegate = self
        tableView.dataSource = self
        DispatchQueue.global(qos: .background).async {
            NetworkApi().getNews { result in
                switch result {
                case .success(let articles):
                    for item in articles {
                        var i = 0
                        self.tableData.append(item)
                        self.sectionData[i] = item
                        i = i + 1
                    }
//                    for item in articles {
//                        self.seacrhData.append(item)
//                    }
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
        setupCell()
        
        let backgroundGradientLayer = CAGradientLayer()
        backgroundGradientLayer.colors = [UIColor.red, UIColor.orange]
        view.layer.insertSublayer(backgroundGradientLayer, at: 0)
        }
}

extension ViewController {
    func setupCell() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
    }
}


//extension ViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        seacrhData = tableData.filter({$0.title!.prefix(searchText.count) == searchText})
//        searching = true
//        tableView.reloadData()
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searching = false
//        searchBar.text = ""
//        searchBar.endEditing(true)
//        tableView.reloadData()
//    }
//}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DataTableViewCell.self)) as! DataTableViewCell
        cell.setup(data: tableData[indexPath.row])
        return cell
    }
    
    /// Since the table view footer "floats", we don't want to use it.
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 24
    }
}
