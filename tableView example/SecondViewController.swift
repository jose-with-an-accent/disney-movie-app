//
//  SecondViewController.swift
//  tableView example
//
//  Created by jose sanchez on 8/4/20.
//  Copyright © 2020 jose sanchez. All rights reserved.
//

import UIKit;
///obtained from: https://www.hackingwithswift.com/example-code/media/how-to-read-the-average-color-of-a-uiimage-using-ciareaaverage
extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}

class SecondViewController: UIViewController {
    @IBOutlet var displayDataLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var loadingLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var moreActionsButton: UIButton!
    
    var recievingString = ""
    var movieInfo: MovieResponse?
    var isImageLoaded: Bool = false
    @IBAction func onInfoButtonPressed(_ sender: Any) {
        let actionAlert = UIAlertController(title: "More Actions", message: "", preferredStyle: .actionSheet)
        actionAlert.addAction(UIAlertAction(title: "Watch Trailer", style: .default, handler: {
            _ in
            print("AAAA")
            
        }))
        actionAlert.addAction(UIAlertAction(title: "Watch Trailer", style: .default, handler: {
            _ in
            print("AAAA")
        }))
        actionAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            _ in
            print("AAAA")
        }))
        self.present(actionAlert, animated: true, completion: nil)
    }
    /// Requests the movie from the TMDB API
    func updateViewWithDetails(details: MovieResponse) -> Void {
        /// - TODO: Use CoreData to favorite
        DispatchQueue.main.async { //fires of an async task, which can update the UI
            print("Details Updated!")
            self.displayDataLabel.text = details.title
            self.descriptionLabel.text = details.overview
            self.loadingLabel.isHidden = true
            self.ratingLabel.text = "Rated \(details.vote_average) out of 10, with \(details.vote_count) votes."
        }
    }
    func updateBackgroundColorAndForeground() -> Void {
        /// - TODO: Update the background color (and if needed, foreground color)
        /// this function will try to at least maintain a certain contrast with the text color and background color
    }
    func makeImageLoadingAnimation() -> Void {
//        !self.isImageLoaded ? mainImage.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0); : return;
    }
    func updateBackdrop(imageURL: URL) -> Void {
        /// - TODO: Standardize guard let and do catch statements
        guard let imageData = try? Data(contentsOf: imageURL) else { return; }
        
        let img = UIImage(data: imageData)
        DispatchQueue.main.async {
            self.mainImage.image = img
        }
    }
    ////TODO: Add error handling for most of these functions, especially the things that deal with networking
    func requestData() -> Void {
        let baseImgURL = "https://image.tmdb.org/t/p/original"
        let baseURL =  "https://api.themoviedb.org/3/search/movie?api_key=a14dfef12046c0910a5fc5367d18b5ab&language=en-US&query=\(recievingString)&page=1&include_adult=false"
        print("Data Requested...")
        let convertedURL = URL(string: baseURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        URLSession.shared.dataTask(with: convertedURL!) { (data, response, err) in //fetches API search
            do {
//            self.movieInfo = String(data: data!, encoding: .utf8)!
                let decoder = JSONDecoder()
                let decodedInfo = try decoder.decode(SearchResponse.self, from: data!)
                if (decodedInfo.results.count != 0) {
                    self.updateViewWithDetails(details: decodedInfo.results[0])
                    if (decodedInfo.results[0].backdrop_path != nil) {
                        let backdropURL = URL(string: baseImgURL + decodedInfo.results[0].backdrop_path!)
                        self.updateBackdrop(imageURL: backdropURL!) }
                } else {
                    let alert = UIAlertController(title: "404 Not Found", message: "Movie could not be found on the TMDB database", preferredStyle: .alert)
//                    alert.addAction(action: UIAlertAction(title: "Cancel", style: .cancel,
                    self.present(alert, animated: true, completion: nil)
                }
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
        let placeloaderAnimateTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(), repeats: true, block: {_ in self.makeImageLoadingAnimation()})
//        helloWorldTimer.fire() // there's probably a more optimal way, but this is just for the meantime
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
