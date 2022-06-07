//
//  FreeAppsViewController.swift
//  CatFiveAPIPractice
//
//  Created by Shien on 2022/6/6.
//

import UIKit

class FreeAppsViewController: UIViewController {
    @IBOutlet weak var appsTableView: UITableView!
    var freeApps: [AppsResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showApps()
    }
    
    func showApps() {
        fetchApps { result in
            switch result {
            case .success(let apps):
                self.freeApps = apps.feed.results
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
        guard let url = URL(string: "https://rss.applemarketingtools.com/api/v2/tw/apps/top-free/25/apps.json") else {
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
        if let freeApps = freeApps {
            controller!.app = freeApps[appsTableView.indexPathForSelectedRow!.row]
        }
        return controller
    }
}


extension FreeAppsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return freeApps?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "freeCell", for: indexPath) as? FreeAppsTableViewCell else { return FreeAppsTableViewCell() }
        
        if let apps = freeApps {
            do {
                cell.appImageView.image = try UIImage(data: Data(contentsOf: apps[indexPath.row].artworkUrl100))
            } catch { print( "no image") }
            
            cell.appNameLabel.text = "\(apps[indexPath.row].name)"
            cell.appDetailLabel.text = "\(apps[indexPath.row].artistName)"
            cell.numLabel.text = "\(indexPath.row+1)"
        }
        return cell
    }
    
    
}
