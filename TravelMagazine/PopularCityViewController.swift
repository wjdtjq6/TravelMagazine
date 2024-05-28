//
//  PopularCityViewController.swift
//  TravelMagazine
//
//  Created by t2023-m0032 on 5/28/24.
//
//1.height 자동조절!!
import UIKit
import Kingfisher
/*
 1.tableview 아웃렛 선언
 2.tableview 부하직원 선언 : protocol
 3.table와 부하직원 연결 : 타입으로서의 protocol
 4.XIB Cell: 여러 테이블에 재사용
 5.XIB register 해야함
 */
class PopularCityViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var popularCityTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TravelInfo.travel.count
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let normalCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PopularCityTableViewCell
//        let adCell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as! AdTableViewCell
//        
//        if TravelInfo.travel[indexPath.row].ad {
//            return 50
//        }
//        else {
//            return 120
//        }
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    //
    let identifier = String(describing: PopularCityTableViewCell.self)
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let normalCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PopularCityTableViewCell
        let adCell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as! AdTableViewCell
        
        if !TravelInfo.travel[indexPath.row].ad {
            normalCell.titleLabel.text = TravelInfo.travel[indexPath.row].title
            normalCell.titleLabel.font = .boldSystemFont(ofSize: 18)

            normalCell.descriptionLabel.text = TravelInfo.travel[indexPath.row].description
            normalCell.descriptionLabel.font = .systemFont(ofSize: 14)
            normalCell.descriptionLabel.numberOfLines = 0
            
            TravelInfo.travel[indexPath.row].like! ? normalCell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : normalCell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            
            normalCell.likeButton.tintColor = .white
            
            normalCell.saveLabel.text = "(\(TravelInfo.travel[indexPath.row].grade!)) \u{2022} 저장 \(TravelInfo.travel[indexPath.row].save!.formatted())"
            normalCell.saveLabel.font = .systemFont(ofSize: 10)
            normalCell.saveLabel.textColor = .systemGray2
            
            let url = URL(string: TravelInfo.travel[indexPath.row].travel_image!)
            normalCell.uiImageView.kf.setImage(with: url)
            normalCell.uiImageView.contentMode = .scaleAspectFill
            normalCell.uiImageView.layer.cornerRadius = 10
        
            return normalCell
        }
        else {
            adCell.adLabel.text = "AD"
            adCell.adLabel.backgroundColor = .white
            adCell.adLabel.clipsToBounds = true
            adCell.adLabel.layer.cornerRadius = 10
            adCell.adLabel.textAlignment = .center
            
            adCell.titleLabel.text = TravelInfo.travel[indexPath.row].title
            adCell.titleLabel.textAlignment = .center
            adCell.titleLabel.numberOfLines = 0
            adCell.titleLabel.font = .boldSystemFont(ofSize: 17)
            
            adCell.layer.cornerRadius = 30
            adCell.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1.0)
            return adCell
        }
        
        
        //TravelInfo.travel[indexPath.row].like! ? cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if TravelInfo.travel[indexPath.row].ad! {
//            return 50
//        }
//        return 120
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        popularCityTableView.delegate = self
        popularCityTableView.dataSource = self
        let xib1 = UINib(nibName: identifier, bundle: nil)
        popularCityTableView.register(xib1, forCellReuseIdentifier: identifier)
        let xib2 = UINib(nibName: "AdTableViewCell", bundle: nil)
        popularCityTableView.register(xib2, forCellReuseIdentifier: "AdTableViewCell")
        
        popularCityTableView.rowHeight = 120
        //popularCityTableView.rowHeight = UITableView.automaticDimension
        
        titleLabel.text = "도시 상세 정보"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
    }
    


}
