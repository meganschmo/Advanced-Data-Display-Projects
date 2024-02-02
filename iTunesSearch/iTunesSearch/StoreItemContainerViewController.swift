
import UIKit

class StoreItemContainerViewController: UIViewController, UISearchResultsUpdating {
    
    @IBOutlet var tableContainerView: UIView!
    @IBOutlet var collectionContainerView: UIView!
    
    let searchController = UISearchController()
    let storeItemController = StoreItemController()
    
    var items = [StoreItem]()

    let queryOptions = ["movie", "music", "software", "ebook"]
    
    var collectionViewDataSource: UICollectionViewDiffableDataSource<String, StoreItem>!
    // keep track of async tasks so they can be cancelled if appropriate.
    var searchTask: Task<Void, Never>? = nil
    var tableViewImageLoadTasks: [IndexPath: Task<Void, Never>] = [:]
    var collectionViewImageLoadTasks: [IndexPath: Task<Void, Never>] = [:]
    
    var tableViewDataSource: UITableViewDiffableDataSource<String, StoreItem>!
    
    var itemsSnapshot: NSDiffableDataSourceSnapshot<String, StoreItem> {
        var snapshot = NSDiffableDataSourceSnapshot<String, StoreItem>()
        
        snapshot.appendSections(["Results"])
        snapshot.appendItems(items)
        
        return snapshot
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.automaticallyShowsSearchResultsController = true
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.scopeButtonTitles = ["Movies", "Music", "Apps", "Books"]
        
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(fetchMatchingItems), object: nil)
        perform(#selector(fetchMatchingItems), with: nil, afterDelay: 0.3)
        
        
    }
    
    func configureTableViewDataSource(_ tableView: UITableView) {
            tableViewDataSource = UITableViewDiffableDataSource<String, StoreItem>(tableView: tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath) as! ItemTableViewCell

                self.tableViewImageLoadTasks[indexPath]?.cancel()
                self.tableViewImageLoadTasks[indexPath] = Task {
                    do {
                        try await cell.configure(for: item, storeItemController: self.storeItemController)
                    } catch {
                        // Handle errors here if needed
                        print("Error configuring cell: \(error)")
                    }
                }
                return cell
            })
        }

        func configureCollectionViewDataSource(_ collectionView: UICollectionView) {
            collectionViewDataSource = UICollectionViewDiffableDataSource<String, StoreItem>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as! ItemCollectionViewCell

                self.collectionViewImageLoadTasks[indexPath]?.cancel()
                self.collectionViewImageLoadTasks[indexPath] = Task {
                    do {
                        try await cell.configure(for: item, storeItemController: self.storeItemController)
                    } catch {
                        // Handle errors here if needed
                        print("Error configuring cell: \(error)")
                    }
                }
                return cell
            })
        }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tableViewController = segue.destination as? StoreItemListTableViewController {
                configureTableViewDataSource(tableViewController.tableView)
            } else if let collectionViewController = segue.destination as? StoreItemCollectionViewController {
                configureCollectionViewDataSource(collectionViewController.collectionView)
            }
        }
                
    @IBAction func switchContainerView(_ sender: UISegmentedControl) {
        tableContainerView.isHidden.toggle()
        collectionContainerView.isHidden.toggle()
    }
    
    @objc func fetchMatchingItems() {
        
        // Cancel any images that are still being fetched and reset the imageTask dictionaries
        collectionViewImageLoadTasks.values.forEach { task in task.cancel() }
        collectionViewImageLoadTasks = [:]
        tableViewImageLoadTasks.values.forEach { task in task.cancel() }
        tableViewImageLoadTasks = [:]

        self.items = []

        let searchTerm = searchController.searchBar.text ?? ""
        let mediaType = queryOptions[searchController.searchBar.selectedScopeButtonIndex]

        // cancel existing task since we will not use the result
        searchTask?.cancel()
        searchTask = Task {
            if !searchTerm.isEmpty {

                // set up query dictionary
                let query = [
                    "term": searchTerm,
                    "media": mediaType,
                    "lang": "en_us",
                    "limit": "20"
                ]

                // use the item controller to fetch items
                do {
                    // use the item controller to fetch items
                    let items = try await storeItemController.fetchItems(matching: query)
                    if searchTerm == self.searchController.searchBar.text &&
                        mediaType == queryOptions[searchController.searchBar.selectedScopeButtonIndex] {
                        self.items = items
                    }
                } catch let error as NSError where error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled {
                    // ignore cancellation errors
                } catch {
                    // otherwise, print an error to the console
                    print(error)
                }
                await tableViewDataSource.apply(itemsSnapshot, animatingDifferences: true)
                await collectionViewDataSource.apply(itemsSnapshot, animatingDifferences: true)
            } else {
                await tableViewDataSource.apply(itemsSnapshot, animatingDifferences: true)
                await collectionViewDataSource.apply(itemsSnapshot, animatingDifferences: true)
            }
            searchTask = nil
        }
    }
    
}
