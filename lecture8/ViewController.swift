//
//  ViewController.swift
//  lecture8
//
//  Created by admin on 08.02.2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var feelsLikeTemp: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    let url = Constants.host
    var myData: Model?
    
    
    private var decoder: JSONDecoder = JSONDecoder()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
        return UITableViewCell()
    }
    
    
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


