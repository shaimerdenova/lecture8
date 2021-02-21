import UIKit
import Alamofire

class SecondViewController: UIViewController {
    
    
    let url = Constants.host
    var myData: Model?
    
    
    @IBOutlet var cityName: UILabel!
    private var decoder: JSONDecoder = JSONDecoder()

    override func viewDidLoad() {
        super.viewDidLoad()
      tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.nib, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        fetchData()
    }
    
    
    func updateUI(){
        cityName.text = myData?.timezone
        temp.text = "\(myData?.current?.temp ?? 0.0)"
        feelsLikeTemp.text = "\(myData?.current?.feels_like ?? 0.0)"
        desc.text = myData?.current?.weather?.first?.description
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    func fetchData(){
        AF.request(url).responseJSON { (response) in
            switch response.result{
            case .success(_):
                guard let data = response.data else { return }
                guard let answer = try? self.decoder.decode(Model.self, from: data) else{ return }
                self.myData = answer
                self.updateUI()
            case .failure(let err):
                print(err.errorDescription ?? "")
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData?.daily?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell2 = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        let item2 = myData?.daily?[indexPath.item]
      //  cell2.day.text = getDayForDate(Date(timeIntervalSince1970: Double(myData?.current)))
        cell2.temp.text = "\(item2?.temp?.temp ?? 0.0)"
        cell2.feelsLike.text = "\(item2?.temp?.feels_like ?? 0.0)"
        cell2.image1.image = UIImage(named: "clear")
        return cell2
    }

    
}
func getDayForDate( date: Date?) -> String{
    guard let inputDate = date else {
return ""
    }
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE"
    return formatter.string(from: inputDate)
}
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myData?.hourly?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        let item = myData?.hourly?[indexPath.item]
        cell.temp.text = "\(item?.temp ?? 0.0)"
        cell.feelsLike.text = "\(item?.feels_like ?? 0.0)"
        cell.desc.text = item?.weather?.first?.description
        return cell

    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

