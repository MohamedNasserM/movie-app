//
//  DetailsVC.swift
//  MovieApp
//
//  Created by Esraa Hassan on 10/2/20.
//  Copyright © 2020 jets. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    var movie:Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movie?.title
        if let rating = movie?.rating {
            ratingLabel.text = "\(rating)"

        }
        
        if let releaseYear = movie?.releaseYear{
            releaseYearLabel.text = "\(releaseYear)"

        }
        let url = URL(string: (movie?.image)!)
        movieImageView.sd_setImage(with: url!, completed: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
