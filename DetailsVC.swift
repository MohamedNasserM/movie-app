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
        ratingLabel.text = "\(movie?.rating)"
        releaseYearLabel.text = "\(movie?.releaseYear)"
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
