import UIKit
import SDWebImage

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    @IBOutlet weak var movieCell: UICollectionViewCell!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (moviesArray?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        cell.titleLabel.text = moviesArray![indexPath.row].title
        let url = URL(string: moviesArray![indexPath.row].image!)
        cell.movieImageView.sd_setImage(with: url, completed: nil)
        return cell
    }
    
    var moviesArray:[Movie]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        moviesArray = [Movie]()
        let url = URL(string: "https://api.androidhive.info/json/movies.json")
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        

        let task = session.dataTask(with: request) { (data, response, error) in
            print(data)
            print("data has arrived successfully")
            
            do {
                var json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Array<Dictionary<String,Any>>
                
                for rawMovie in json {
                    let movieObj = Movie()
                    movieObj.title = rawMovie["title"] as? String
                    movieObj.image = rawMovie["image"] as? String
                    movieObj.rating = rawMovie["rating"] as? Double
                    movieObj.releaseYear = rawMovie["releaseYear"] as? Int
                    
                    self.moviesArray?.append(movieObj)

                    
                }
                
            }catch{
                print(error)
            }
            
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        vc.movie = moviesArray?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }


}

