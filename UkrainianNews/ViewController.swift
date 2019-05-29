import UIKit
import FirebaseAuth
import Firebase

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var screenCoverButton: UIButton!
    
    @IBOutlet weak var logoutButtonTapped: UIButton!
    
    @IBOutlet weak var alertButton: UIButton!
    @IBOutlet weak var breakButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var hotButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var profileNameLabel: UILabel!
    
    @IBOutlet weak var menuCurveImageView: UIImageView!
    @IBOutlet weak var menuView: UIView!
    
    
    
    @IBAction func screenCoverTapped(_ sender: Any) {
        hideMenu()
    }
    
    var sectionData: [Int: Article] = [:]
    
    var searching = false
    var tableData: ([Article]) = []
    var seacrhData: ([Article]) = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuCurveImageView.image = #imageLiteral(resourceName: "MenuCurve")
        hideMenu()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if Auth.auth().currentUser?.uid == nil {
            handleLogout()
        } else {
            if let uid = Auth.auth().currentUser?.uid {
                Database.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
                    print(snapshot)
                    
                    if let dictionary = snapshot.value as? [String : AnyObject] {
                        self.profileNameLabel.text = "Welcome back \(dictionary["names"] as! String)"
                    }
                }, withCancel: nil)
            }
        }
        
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
    
    @IBAction func logoutTapped(_ sender: Any) {
        showMenu()
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        handleLogout()
    }
    

    private func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    private func showMenu() {
        
        UIView.animate(withDuration: 1) {
            self.logoutButtonTapped.alpha = 0
            self.menuView.alpha = 1
        }
    //        logoutButtonTapped.isHidden = true
        
        menuView.isHidden = false
        
        UIView.animate(withDuration: 0.7, animations: {
            self.screenCoverButton.alpha = 1
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.06, options: .curveEaseOut, animations: {
            self.menuCurveImageView.transform = .identity
        })
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.searchButton.transform = .identity
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.06, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.locationButton.transform = .identity
            self.breakButton.transform = .identity
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.12, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.homeButton.transform = .identity
            self.alertButton.transform = .identity
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.18, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.hotButton.transform = .identity
        })    }
    
    private func hideMenu() {
        UIView.animate(withDuration: 1) {
            self.logoutButtonTapped.alpha = 1
        }
        
        UIView.animate(withDuration: 0.7, animations: {
            self.screenCoverButton.alpha = 0
        })
        
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.hotButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.08, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.homeButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
            self.alertButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.16, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.locationButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
            self.breakButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.08, options: .curveEaseOut, animations: {
            self.menuCurveImageView.transform = CGAffineTransform(translationX: -self.menuCurveImageView.frame.width, y: 0)
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.21, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.searchButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
        }) { success in
            self.menuView.isHidden = true
        }    }
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
