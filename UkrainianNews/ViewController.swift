
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var seacrhBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searching = false
    var tableData: [News] = []
    var seacrhData: [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seacrhBar.delegate = self
        tableView.dataSource = self
        
        myData.getData { (data) in
            self.tableData = data
            self.tableView.reloadData()
        }
    
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return seacrhData.count
        } else {
            return tableData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as! TableViewCell
        if searching {
            cell.setup(models: [seacrhData[indexPath.row]])
            
        } else {
            cell.setup(models: [tableData[indexPath.row]])
        }
        return cell
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        seacrhData = tableData.filter({$0.title!.prefix(searchText.count) == searchText})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
