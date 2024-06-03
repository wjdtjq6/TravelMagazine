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

//storyboard?.으로 써야하는 이유 강의자료에서 찾기 -> UIStoryboard()는 새로운 스토리보드 인스턴스를 생성, storyboard?는 현재 뷰 컨트롤러가 있는 스토리보드를 참조

class PopularCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var popularCityTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TravelInfo.travel.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    //
    let identifier = String(describing: PopularCityTableViewCell.self)
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !TravelInfo.travel[indexPath.row].ad {
            let normalCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PopularCityTableViewCell
            
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
            let adCell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as! AdTableViewCell

            adCell.adLabel.text = "AD"
            adCell.adLabel.backgroundColor = .white
            adCell.adLabel.clipsToBounds = true
            adCell.adLabel.layer.cornerRadius = 10
            adCell.adLabel.textAlignment = .center
            
            adCell.titleLabel.text = TravelInfo.travel[indexPath.row].title
            adCell.titleLabel.textAlignment = .center
            adCell.titleLabel.numberOfLines = 0
            adCell.titleLabel.font = .boldSystemFont(ofSize: 17)
            
            adCell.layer.cornerRadius = 20
            adCell.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1.0)
            return adCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  TravelInfo.travel[indexPath.row].ad {
            return 50
        }
        else {
            return 120
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if TravelInfo.travel[indexPath.row].ad {
            //광고화면
           
            //2.스토리보드 내 전환하고자 하는 화면 가져오기
            let vc = /*self.*/storyboard?.instantiateViewController(identifier: "AdDetailViewController") as! AdDetailViewController
            //2.1. 네비게이션 컨트롤러가 있는 형태(제목바)로 Present하고 싶은 경우
            //nav를 사용한다면, present와 화면 전환 방식도 nav로 수정해주어야함
            let nav = UINavigationController(rootViewController: vc)
            
            //3.화면 띄우기
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
        else {
            //관광지 화면 터치하면 반응은 있음 navi부분이 문제인듯! => 인터페이스 빌더에 네비게이션 컨트롤러가 임베드되어 있어야만 Push가 동작
            
            //2.스토리보드 내 전환하고자 하는 화면 가져오기
            let vc = storyboard?.instantiateViewController(identifier: "TourDetailViewController") as! TourDetailViewController
            //let nav = UINavigationController(rootViewController: vc)
            
            //3.화면 띄우기
            //nav.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
            //present(nav, animated: true)
        }
    }//push는 옆에서 나오는거:
    override func viewDidLoad() {
        super.viewDidLoad()
        popularCityTableView.delegate = self
        popularCityTableView.dataSource = self
        let xib1 = UINib(nibName: identifier, bundle: nil)
        popularCityTableView.register(xib1, forCellReuseIdentifier: identifier)
        let xib2 = UINib(nibName: "AdTableViewCell", bundle: nil)
        popularCityTableView.register(xib2, forCellReuseIdentifier: "AdTableViewCell")
        
        titleLabel.text = "도시 상세 정보"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
    }
}
