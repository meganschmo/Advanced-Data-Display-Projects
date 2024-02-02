//
//  StoreItemTableViewDiffableDataSource.swift
//  iTunesSearch
//
//  Created by Megan Schmoyer on 1/18/24.
//

import UIKit

@MainActor
class StoreItemTableViewDiffableDataSource: UITableViewDiffableDataSource<String, StoreItem> {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return snapshot().sectionIdentifiers[section]
    }
}
