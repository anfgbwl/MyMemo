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
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search") else { return }
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            guard let randomCatImage = try? decoder.decode([RandomImage].self, from: data) else { return }
            if let imageUrl = URL(string: randomCatImage.first?.url ?? "") {
                let imageTask = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    if let error = error {
                        print("Error: \(error)")
                    }
                    if let httpResponse = response as? HTTPURLResponse {
                        print("Status Code: \(httpResponse.statusCode)")
                    }
                    if let imageData = data, let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            self.randomImageView.image = image
                            session.finishTasksAndInvalidate()
                            print("세션 종료")
                        }
                    }
                }
                imageTask.resume()
            }
        }
        task.resume()
    }
    
}
