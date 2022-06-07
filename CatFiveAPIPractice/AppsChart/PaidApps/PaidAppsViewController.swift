//
//  PaidAppsViewController.swift
//  CatFiveAPIPractice
//
//  Created by Shien on 2022/6/6.
//

import UIKit
import StoreKit

class PaidAppsViewController: UIViewController {
    var paidApps: [AppsResult]?
    @IBOutlet weak var appsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showApps()
    }
    
    func showApps() {
        fetchApps { result in
            switch result {
            case .success(let apps):
                self.paidApps = apps.feed.results
                DispatchQueue.main.async {
                    self.appsTableView.reloadData()
                }
            case .failure(let networkError):
                switch networkError {
                case .requestFailed(let error):
                    print(networkError, error)
                case .invalidResponse:
                    print(networkError)
                case .invalidUrl:
                    print(networkError)
                case .invalidData:
                    print(networkError)
                }
            }
        }
    }
    
    
    func fetchApps(completion: @escaping (Result<Apps,NetworkError>)->Void) {
        guard let url = URL(string: "https://rss.applemarketingtools.com/api/v2/tw/apps/top-paid/10/apps.json") else {
            return completion(.failure(.invalidUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return completion(.failure(.invalidResponse))
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Apps.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(.requestFailed(error)))
                }
            }
        }.resume()
    }
    
   
    @IBSegueAction func showDetails(_ coder: NSCoder) -> AppDetailsTableViewController? {
        let controller = AppDetailsTableViewController(coder: coder)
        controller!.app = paidApps![appsTableView.indexPathForSelectedRow!.row]
        return controller
    }
}


extension PaidAppsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        paidApps?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "paidCell", for: indexPath) as? PaidAppsTableViewCell else { return PaidAppsTableViewCell() }
        
        if let apps = paidApps {
            cell.appImageView.image = try? UIImage(data: Data(contentsOf: apps[indexPath.row].artworkUrl100))
            cell.appNameLabel.text = "\(apps[indexPath.row].name)"
            cell.appDetailLabel.text = "\(apps[indexPath.row].artistName)"
            cell.priceButton.setTitle("NT$ \(Int.random(in: 100...1000)).00", for: .normal)
            cell.numLabel.text = "\(indexPath.row+1)"
        }
        return cell
    }
}
