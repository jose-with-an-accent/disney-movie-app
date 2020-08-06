//
//  SecondViewController.swift
//  tableView example
//
//  Created by jose sanchez on 8/4/20.
//  Copyright © 2020 jose sanchez. All rights reserved.
//

import UIKit;

class SecondViewController: UIViewController {
    @IBOutlet var displayDataLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var loadingLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    
    var recievingString = ""
    var movieInfo: MovieResponse?
    /// To Do: Connect the UI to the fetcher
    /// Requests the movie from the TMDB API
    /// - Retu  rns: URLSession JSON info
    func updateViewWithDetails(details: MovieResponse) -> Void {
        DispatchQueue.main.async {
            print("Queue Dispatched!")
            self.displayDataLabel.text = details.title
            self.descriptionLabel.text = details.overview
            self.loadingLabel.isHidden = true
            self.ratingLabel.text = "Rated \(details.vote_average) out of 10, with \(details.vote_count) votes."
//            mainImage.image =
        }
    }
    func requestData() -> Void {
        let baseURL =  "https://api.themoviedb.org/3/search/movie?api_key=a14dfef12046c0910a5fc5367d18b5ab&language=en-US&query=\(recievingString)&page=1&include_adult=false"
        print("Data Requested...")
        let convertedURL = URL(string: baseURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        URLSession.shared.dataTask(with: convertedURL!) { (data, response, err) in
            do {
//            self.movieInfo = String(data: data!, encoding: .utf8)!
                let decoder = JSONDecoder()
                let decodedInfo = try decoder.decode(SearchResponse.self, from: data!)
                
                self.updateViewWithDetails(details: decodedInfo.results[0])
            } catch let error as NSError {
                print(error)
            }   
//            print(self.movieInfo)
        }.resume()
        return
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()


    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
