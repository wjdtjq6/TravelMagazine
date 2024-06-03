//
//  HotCityViewController.swift
//  TravelMagazine
//
//  Created by t2023-m0032 on 6/1/24.
//

import UIKit
/*
 1.tableview 아웃렛 선언
 2.tableview 부하직원 선언 : protocol
 3.table와 부하직원 연결 : 타입으로서의 protocol
 4.XIB Cell: 여러 테이블에 재사용
 5.XIB register 해야함
 
 1.searchBar 부하직원 선언: protocol
 2.searchBar와 부하직원 연결: 타입으로서의 protocol
 */
class HotCityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate {
    
    let cities = CityInfo().city
    var filterdCities = CityInfo().city
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterdCities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotCityTableViewCell", for: indexPath) as! HotCityTableViewCell
        cell.uiView.layer.masksToBounds = true
        cell.uiView.layer.cornerRadius = 30
        cell.uiView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
        
        cell.backgroundColor = .clear
        let url = URL(string: filterdCities[indexPath.row].city_image)
        cell.cityImageView.kf.setImage(with: url)
        cell.cityImageView.contentMode = .scaleAspectFill
        
        cell.titleLabel.text = "\(filterdCities[indexPath.row].city_name) | \(filterdCities[indexPath.row].city_english_name)"
        cell.titleLabel.textColor = .white
        cell.titleLabel.textAlignment = .right
        cell.titleLabel.font = .boldSystemFont(ofSize: 25)
        
        cell.subLabel.text = filterdCities[indexPath.row].city_explain
        cell.subLabel.font = .boldSystemFont(ofSize: 14)
        cell.subLabel.textColor = .white
        cell.subLabel.backgroundColor = .black.withAlphaComponent(0.5)
        
        return cell
    }
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var uiSegmentedControl: UISegmentedControl!
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1: var korea: [City] = []
            for i in cities {
                if i.domestic_travel {
                    korea.append(i)
                }
                filterdCities = korea
            }
        case 2: var foreign: [City] = []
            for i in cities {
                if !i.domestic_travel {
                    foreign.append(i)
                }
                filterdCities = foreign
            }
        default: filterdCities = cities
        }
        tableView.reloadData()
    }
    //서치파 엔터시 검색
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var searchList: [City] = []
        for i in filterdCities {
            if  i.city_name.contains(searchBar.text!) || i.city_explain.contains(searchBar.text!) || i.city_english_name.contains(searchBar.text!) {
                searchList.append(i)
            }
        }
        filterdCities = searchList
        tableView.reloadData()
    }
    //서치파 실시간 검색
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var searchList: [City] = []
        if searchBar.text!.count > 1 {
            for i in filterdCities {
                if i.city_name.contains(searchBar.text!) || i.city_explain.contains(searchBar.text!) || i.city_english_name.contains(searchBar.text!) {
                        searchList.append(i)
                }
            }
            filterdCities = searchList
            tableView.reloadData()
        }
        
        if searchBar.text == "" {
            filterdCities = cities
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let xib = UINib(nibName: "HotCityTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "HotCityTableViewCell")
        navigationItem.title = "인기 도시"
        tableView.rowHeight = 200
        
        uiSegmentedControl.setTitle("모두", forSegmentAt: 0)
        uiSegmentedControl.setTitle("국내", forSegmentAt: 1)
        uiSegmentedControl.setTitle("해외", forSegmentAt: 2)

        searchBar.delegate = self
    }
}
//1.서치바 실시간 검색되는데 지우면 없어짐 => 
