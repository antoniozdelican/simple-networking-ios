//
//  MainViewController.swift
//  SimpleNetworking_Example
//
//  Created by Antonio Zdelican on 20.08.21.
//  Copyright © 2021 antoniozdelican. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    private lazy var viewModel: MainViewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        title = "Simple Checkout"
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.isTranslucent = false
    }
    
    // MARK: - UIStoryboardSegue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailViewController,
              let indexPath = sender as? IndexPath else {
            return
        }
        detailViewController.request = viewModel.data[indexPath.row]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMain", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = viewModel.data[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "segueToDetail", sender: indexPath)
    }

}
