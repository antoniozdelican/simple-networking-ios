//
//  DetailViewController.swift
//  SimpleNetworking_Example
//
//  Created by Antonio Zdelican on 20.08.21.
//  Copyright © 2021 antoniozdelican. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    private lazy var viewModel: DetailViewModel = DetailViewModel()
    private weak var activityIndicatorView: UIActivityIndicatorView?
    
    var request: APIRequest? {
        didSet {
            title = request?.title
            refreshControl?.endRefreshing()
            headers.removeAll()
            body = nil
            elapsedTime = nil
        }
    }

    private var headers: [String: String] = [:]
    private var body: String?
    private var elapsedTime: TimeInterval?

    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    // MARK: View Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        refreshControl?.addTarget(self, action: #selector(callApi), for: .valueChanged)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicatorView?.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        callApi()
    }
    
    private func configureUI() {
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.isTranslucent = false
        
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        tableView.backgroundView = activityIndicatorView
        self.activityIndicatorView = activityIndicatorView
    }
    
    @objc
    private func callApi() {
        guard let request = request else {
            return
        }
        refreshControl?.beginRefreshing()
        let start = CACurrentMediaTime()
        
        viewModel.callApi(request, completion: { [weak self] (result, response) in
            guard let self = self else { return }
            let end = CACurrentMediaTime()
            self.elapsedTime = end - start

            if let response = response {
                for (field, value) in response.allHeaderFields {
                    self.headers["\(field)"] = "\(value)"
                }
            }
            
            switch result {
            case .success(let value):
                self.body = value
            case .failure(let error):
                self.body = error.localizedDescription
            }
            
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
            self.activityIndicatorView?.stopAnimating()
        })
    }

}

// MARK: - UITableViewDataSource

extension DetailViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .headers:
            return headers.count
        case .body:
            return body == nil ? 0 : 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.sections[indexPath.section] {
        case .headers:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellHeader", for: indexPath)
            let field = headers.keys.sorted(by: <)[indexPath.row]
            let value = headers[field]
            cell.textLabel?.text = field
            cell.detailTextLabel?.text = value
            return cell
        case .body:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellBody", for: indexPath)
            cell.textLabel?.text = body
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard self.tableView(tableView, numberOfRowsInSection: section) != 0 else {
            return ""
        }
        return viewModel.sections[section].rawValue
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard viewModel.sections[section] == .body, let elapsedTime = elapsedTime else {
            return ""
        }
        let elapsedTimeText = DetailViewController.numberFormatter.string(from: elapsedTime as NSNumber) ?? "???"
        return "Elapsed Time: \(elapsedTimeText) sec"
    }
    
}

// MARK: - UITableViewDelegate

extension DetailViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.sections[indexPath.section] {
        case .headers:
            return tableView.rowHeight
        case .body:
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
