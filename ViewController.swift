//
//  ViewController.swift
//  CatFiveAPIPractice
//
//  Created by Shien on 2022/6/4.
//

import UIKit
class ViewController: UIViewController {
    
    @IBOutlet weak var newImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        enterPassword()
         
        newDownloadImage(urlString: "https://images-na.ssl-images-amazon.com/images/I/61Zi2jjgfIL.jpg") { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.newImageView.image = image
                }
            case .failure(let networkError):
                switch networkError {
                case .invalidUrl:
                    print(networkError)
                case .requestFailed(let error):
                    print(networkError, error)
                case .invalidResponse:
                    print(networkError)
                case .invalidData:
                    print(networkError)
                }
            }
        }
    }
    
}

