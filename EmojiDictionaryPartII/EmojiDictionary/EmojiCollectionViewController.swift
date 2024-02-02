// EmojiDictionary

import UIKit

private let reuseIdentifier = "Item"
private let headerIdentifier = "Header"
private let headerKind = "header"
private let columnReuseIdentifier = "ColumnItem"

class EmojiCollectionViewController: UICollectionViewController {
    @IBOutlet var layoutButton: UIBarButtonItem!
    
    var newSectionTitles: [String] = []
    var emojis: [Emoji] = [
        Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
        Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
        Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
        Emoji(symbol: "🧑‍💻", name: "Developer", description: "A person working on a MacBook (probably using Xcode to write iOS apps in Swift).", usage: "apps, software, programming"),
        Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "something slow"),
        Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage: "good memory"),
        Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti.", usage: "spaghetti"),
        Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
        Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
        Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacked on each other.", usage: "homework, studying"),
        Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"),
        Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
        Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion")
    ]
    
    var layout: [Layout: UICollectionViewLayout] = [:]
    
    var sections: [Section] = []
    
    var activeLayout: Layout = .grid {
        didSet {
            if let layout = layout[activeLayout] {
                self.collectionView.reloadItems(at:
                   self.collectionView.indexPathsForVisibleItems)
    
                collectionView.setCollectionViewLayout(layout,
                   animated: true) { (_) in
                    switch self.activeLayout {
                    case .grid:
                        self.layoutButton.image = UIImage(systemName:
                           "rectangle.grid.1x2")
                    case .column:
                        self.layoutButton.image = UIImage(systemName:
                           "square.grid.2x2")
                    }
                }
            }
        }
    }
  
    
    enum Layout {
        case grid
        case column
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout[.grid]   = generateGridLayout()
        layout[.column] = generateColumnLayout()
        
        if let layout = layout[activeLayout] {
            collectionView.collectionViewLayout = layout
        }
        
        collectionView.register(EmojiCollectionViewHeader.self, forSupplementaryViewOfKind: headerKind, withReuseIdentifier: headerIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSections()
        collectionView.reloadData()
    }
    func generateColumnLayout() -> UICollectionViewLayout {
        let padding: CGFloat = 10
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitem: item, count: 1)
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = padding
        section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: 0, bottom: padding, trailing: 0)
        
        section.boundarySupplementaryItems = [generateHeader()]
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func generateGridLayout() -> UICollectionViewLayout {
        let padding: CGFloat = 20
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/4)), subitem: item, count: 2)
        
        group.interItemSpacing = .fixed(padding)
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: padding, bottom: 0, trailing: padding)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = padding
        section.contentInsets = NSDirectionalEdgeInsets(
            top: padding,
            leading: 0,
            bottom: padding,
            trailing: 0
            )
        section.boundarySupplementaryItems = [generateHeader()]
        return UICollectionViewCompositionalLayout(section: section)
        
    }
    func generateHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)
    ),
    elementKind: headerKind,
    alignment: .top
    )
        header.pinToVisibleBounds = true
        return header
    }
    func updateSections() {
        sections.removeAll()
        
        let grouped = Dictionary(grouping: emojis, by: { $0.sectionTitle })
        
        // Sort the grouped dictionary by section titles
        let sortedGrouped = grouped.sorted(by: { $0.0 < $1.0 })
        
        for (title, emojis) in sortedGrouped {
            sections.append(Section(title: title, emojis: emojis.sorted(by: { $0.name < $1.name })))
        }
        
        // Check if there are any new sections to add
        for title in newSectionTitles {
            if !grouped.keys.contains(title) {
                // Create a new section for the title
                sections.append(Section(title: title, emojis: [])) // Add empty section
                
                // Add corresponding emojis from the emojis array to the new section
                let newEmojis = emojis.filter { $0.sectionTitle == title }
                sections[sections.count - 1].emojis = newEmojis
            }
        }
    }
    
    @IBAction func switchLayouts(sender: UIBarButtonItem) {
        switch activeLayout {
        case .grid:
            activeLayout = .column
        case .column:
            activeLayout = .grid
        }
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].emojis.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = activeLayout == .grid ? reuseIdentifier :
           columnReuseIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
           identifier, for: indexPath) as! EmojiCollectionViewCell
       
        //Step 2: Fetch model object to display
        let emoji = sections[indexPath.section].emojis[indexPath.item]

        //Step 3: Configure cell
        cell.update(with: emoji)

        //Step 4: Return cell
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView,
       viewForSupplementaryElementOfKind kind: String, at indexPath:
       IndexPath) -> UICollectionReusableView {
        let header =
           collectionView.dequeueReusableSupplementaryView(ofKind:
           kind, withReuseIdentifier: headerIdentifier, for:
           indexPath) as! EmojiCollectionViewHeader
    
        header.titleLabel.text = sections[indexPath.section].title
    
        return header
    }
   
    @IBSegueAction func addEditEmoji(_ coder: NSCoder, sender: Any?) -> AddEditEmojiTableViewController? {
        if let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell) {
            // Editing Emoji
            let emojiToEdit = sections[indexPath.section].emojis[indexPath.item]
            return AddEditEmojiTableViewController(coder: coder, emoji: emojiToEdit)
        } else {
            // Adding Emoji
            return AddEditEmojiTableViewController(coder: coder, emoji: nil)
        }
    }
   
    func indexPath(for emoji: Emoji) -> IndexPath? {
        if let sectionIndex = sections.firstIndex(where:  { $0.title == emoji.sectionTitle }),
           let index = sections[sectionIndex].emojis.firstIndex(where: { $0 == emoji })
        {
            return IndexPath(item: index, section: sectionIndex)
        }
        return nil
    }
    
    
    
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind",
                 let sourceViewController = segue.source as? AddEditEmojiTableViewController,
                 let emoji = sourceViewController.emoji else { return }
             
        // Check if the emoji's section title is new
        if !emoji.sectionTitle.isEmpty,
           !sections.contains(where: { $0.title == emoji.sectionTitle }),
           !newSectionTitles.contains(emoji.sectionTitle) {
            newSectionTitles.append(emoji.sectionTitle) // Add new section title
        }
                 
        // Update emojis and sections
        if let indexPath = collectionView.indexPathsForSelectedItems?.first,
           let index = emojis.firstIndex(where: { $0 == emoji }) {
            emojis[index] = emoji
            updateSections()
            collectionView.reloadItems(at: [indexPath])
        } else {
            emojis.append(emoji)
            updateSections()
            if let newIndexPath = indexPath(for: emoji) {
                collectionView.insertItems(at: [newIndexPath])
            }
        }
    }

    // MARK: - UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (elements) -> UIMenu? in
            let delete = UIAction(title: "Delete") { (action) in
                self.deleteEmoji(at: indexPath)
            }
            
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [delete])
        }
        
        return config
    }

    func deleteEmoji(at indexPath: IndexPath) {
        let emoji = sections[indexPath.section].emojis[indexPath.item]
        guard let index = emojis.firstIndex(where: { $0 == emoji }) else { return }
        
        emojis.remove(at: index)
        sections[indexPath.section].emojis.remove(at: indexPath.item)
        
        collectionView.deleteItems(at: [indexPath])
    }
}
