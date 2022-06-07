//
//  AppDetailsTableViewController.swift
//  CatFiveAPIPractice
//
//  Created by Shien on 2022/6/7.
//

import UIKit

class AppDetailsTableViewController: UITableViewController {
    var app: AppsResult?
    
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var appNameLabel: UILabel!
    
    @IBOutlet weak var totalRatingCountLabel: UILabel!
    @IBOutlet weak var avgRatingsCountLabel: UILabel!
    @IBOutlet weak var starCountsLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genreNameLabel: UILabel!
    @IBOutlet weak var chartRankLabel: UILabel!
    @IBOutlet weak var sellerNameLabel2: UILabel!
    
    @IBOutlet weak var totalLanguagesLabel: UILabel!
    @IBOutlet weak var firstLanguageLabel: UILabel!
    
    @IBOutlet weak var currentVersionLabel: UILabel!
    @IBOutlet weak var releaseNotesTextView: UITextView!
    @IBOutlet weak var releaseTimeLabel: UILabel!
    
    @IBOutlet weak var previewImageview: UIImageView!
    @IBOutlet weak var previewStackView: UIStackView!
    
    @IBOutlet weak var fileSizeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDetails()
    }
    
    
    func fetchDetails() {
        if let url = URL(string: "https://itunes.apple.com/lookup?id=\(String(describing: app!.id))&country=tw") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let appDetail = try decoder.decode(AppDetail.self, from: data)
                        DispatchQueue.main.async {
                            self.updateUI(with: appDetail.results[0])
                            print("has result")
                        }
                    }
                    catch {
                        print(error)
                    }
                }
            }.resume()
        } else {
            print("invalid url")
        }
    }
    
    func showStars(starCounts: Int) {
        starCountsLabel.text = ""
        for _ in 1...starCounts {
            starCountsLabel.text! += "★"
        }
        if 5-starCounts != 0{
            for _ in 1...(5-starCounts) {
                starCountsLabel.text! += "☆"
            }
        }
    }
    
    func showPreviews(details: DetailResult) {
        for (i,url) in details.screenshotUrls.enumerated() {
            let imageView = UIImageView(frame: previewImageview.frame)
            imageView.layer.cornerRadius = 30
            imageView.image = try? UIImage(data: Data(contentsOf: url))
            if i == 0 {
                previewImageview.image = imageView.image
            } else {
                previewStackView.addArrangedSubview(imageView)
            }
            
        }
    }
    
    func updateUI(with details: DetailResult) {
        appImageView.image = try? UIImage(data: Data(contentsOf: details.artworkUrl100))
        appNameLabel.text = details.trackName
        sellerNameLabel.text = details.sellerName
        sellerNameLabel2.text = details.sellerName
        
        totalRatingCountLabel.text = "\(details.userRatingCountForCurrentVersion) RATINGS"
        avgRatingsCountLabel.text = details.contentAdvisoryRating
        showStars(starCounts: Int((details.averageUserRating).rounded()))
        
        ageLabel.text = "\(Int.random(in: 5...12))"
        genreNameLabel.text = details.primaryGenreName
        chartRankLabel.text = "No.\(Int.random(in: 1...10))"
        
        if !details.languageCodesISO2A.isEmpty {
            firstLanguageLabel.text = details.languageCodesISO2A[0]
        }
        totalLanguagesLabel.text = "+ \(details.languageCodesISO2A.count) More"
        
        currentVersionLabel.text = details.version
        releaseNotesTextView.text = details.releaseNotes
        releaseTimeLabel.text = "\(Int.random(in: 1...3))w ago"
        
        fileSizeLabel.text = details.fileSizeBytes
        
        showPreviews(details: details)
    }
    

    // MARK: - Table view data source

   
}
