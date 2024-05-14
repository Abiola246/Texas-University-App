import UIKit

class MasterViewController: UITableViewController, UISearchBarDelegate {
    
    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    var UniName: [String] = ["University of Texas at Austin", "Texas A&M University","Texas Tech University", "University of North Texas","University of Houston","South Methodist University","Texas State University","University of Texas at San Antonio","St.Mary's University","Texas Women's University"]
    var UniAddress: [String] = ["2515 Speedway, Austin, TX 78712", "400 Bizzell St, College Station, TX 77840", "2500 Broadway W, Lubbock, TX 79409", "1155 Union Cir, Denton, TX 76205", "4300 Martin Luther King Blvd, Houston, TX 77204" , "6425 Boaz Lane, Dallas TX 75205" , "601 University Dr, San Marcos, TX 78666" , "1 UTSA Circle, San Antonio, TX 78249" , "1 Camino Santa Maria, San Antonio, TX 78228" , "304 Administration Dr, Denton, TX 76204"]
    
    var filteredUniNames: [String] = []
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the search bar
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search Universities"
        navigationItem.titleView = searchBar
        
        filteredUniNames = UniName
        
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.setNewAddress(Member: filteredUniNames[indexPath.row], formap: UniAddress[indexPath.row])
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUniNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = filteredUniNames[indexPath.row]
        return cell
    }
    
    // MARK: - Search Bar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredUniNames = searchText.isEmpty ? UniName : UniName.filter { $0.localizedCaseInsensitiveContains(searchText) }
        tableView.reloadData()
    }
}
