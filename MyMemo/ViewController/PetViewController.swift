//
//  PetViewController.swift
//  MyMemo
//
//  Created by t2023-m0076 on 2023/08/25.
//

import UIKit
import SkeletonView

class PetViewController: UIViewController {
    var imageList: [RandomImage] = []
    
    @IBOutlet weak var randomImageView: UIImageView!
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var catImageView: UIImageView!
    @IBAction func randomButton(_ sender: Any) {
        getRandomCatImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        randomImageView.showAnimatedGradientSkeleton()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.randomImageView.hideSkeleton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRandomCatImage()
        
    }
    
    func getRandomCatImage() {
        let url = URL(string: "https://api.thecatapi.com/v1/images/search")!
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            guard let randomCatImage = try? decoder.decode([RandomImage].self, from: data) else { return }
            if let imageUrl = URL(string: randomCatImage.first?.url ?? "") {
                URLSession.shared.dataTask(with: imageUrl) { imageData, _, _ in
                    if let imageData = imageData, let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            self.randomImageView.image = image
                        }
                    }
                }.resume()
            }
        }.resume()
    }
    
    //    func getRandomCatImage(){
    //        URLManager.shared.getRandomCatImage { (response) in
    //            switch response {
    //            case .success(let decodedData):
    //                print("success")
    //                if let image = UIImage(data: decodedData as! Data) {
    //                    DispatchQueue.main.async {
    //                        self.randomImageView.image = image
    //                    }
    //                }
    //            case .failure(let error):
    //                print("Error: ", error)
    //            }
    //        }
    //    }
    
    
    //    func getRandomCat() {
    //        URLManager.shared.getRandomCatJsonData(completion: { result in
    //            switch result {
    //            case .success(let catImageUrl):
    //                self.randomCatUrls = catImageUrl as! [String]
    //                if let ramdomUrl =  self.randomCatUrls.randomElement() {
    //                    if let image = UIImage(named: ramdomUrl) {
    //                        DispatchQueue.main.async {
    //                            self.randomImageView.image = image
    //                        }
    //                    }
    //                }
    //            case .failure(let error):
    //                print("Error: ", error)
    //            }
    //        })
    //    }
    //
    //    func displayRandomCatImage() {
    //        if let randomImageUrlString = randomCatUrls.randomElement(),
    //           let randomImageUrl = URL(string: randomImageUrlString) {
    //            DispatchQueue.global().async {
    //                if let imageData = try? Data(contentsOf: randomImageUrl),
    //                   let image = UIImage(data: imageData) {
    //                    DispatchQueue.main.async {
    //                        self.randomImageView.image = image
    //                    }
    //                }
    //            }
    //        }
    //    }
    
}
