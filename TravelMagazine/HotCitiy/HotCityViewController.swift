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
        
        cell.titleLabel.textColor = .white
        cell.titleLabel.textAlignment = .right
        cell.titleLabel.font = .boldSystemFont(ofSize: 25)
        
        cell.titleBetween.text = " | "
        cell.titleBetween.textColor = .white
        cell.titleBetween.textAlignment = .center
        cell.titleBetween.font = .boldSystemFont(ofSize: 25)
        
        //cell.titleLabel2.text = String(filterdCities[indexPath.row].city_english_name)
        cell.titleLabel2.textColor = .white
        cell.titleLabel2.textAlignment = .right
        cell.titleLabel2.font = .boldSystemFont(ofSize: 25)
        //cell.subLabel.text = filterdCities[indexPath.row].city_explain
        
        cell.subLabel.font = .boldSystemFont(ofSize: 14)
        cell.subLabel.textColor = .white
        cell.subLabel.backgroundColor = .black.withAlphaComponent(0.5)
        
        let whiteSpace = searchBar.text!.trimmingCharacters(in: .whitespaces)
        cell.titleLabel2.setHighlighted(filterdCities[indexPath.row].city_english_name, with: whiteSpace)

        cell.titleLabel.setHighlighted(filterdCities[indexPath.row].city_name , with: whiteSpace)

        cell.subLabel.setHighlighted(filterdCities[indexPath.row].city_explain, with: whiteSpace)

        return cell
    }
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var uiSegmentedControl: UISegmentedControl!
    
    // 1), 2) 메서드 호출 순서 파악하기
    // 2) 메서드에서 textField가 empty일 때 로직 처리하기
    // 3) segemnt control 값이 변경될 때 textField 값 고려하기
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        var searchList: [City] = []
        let whiteSpace = searchBar.text!.trimmingCharacters(in: .whitespaces)
       
        if searchBar.text == "" {
            switch sender.selectedSegmentIndex {
            case 1: var korea: [City] = []
                for i in cities {
                    if i.domestic_travel {
                        korea.append(i)
                    }
                }
                filterdCities = korea
            case 2: var foreign: [City] = []
                for i in cities {
                    if !i.domestic_travel {
                        foreign.append(i)
                    }
                }
                filterdCities = foreign
            default: filterdCities = cities
            }
        }
        else {
            switch sender.selectedSegmentIndex {
            case 1: var korea: [City] = []
                for i in cities {
                    if i.domestic_travel {
                        korea.append(i)
                    }
                    filterdCities = korea
                }
                for i in filterdCities {
                    if i.city_name.contains(whiteSpace) || i.city_explain.contains(whiteSpace) || i.city_english_name.lowercased().contains(whiteSpace.lowercased()) || i.city_english_name.uppercased().contains(whiteSpace.uppercased()){
                            searchList.append(i)
                    }
                }
                filterdCities = searchList
            case 2: var foreign: [City] = []
                for i in cities {
                    if !i.domestic_travel {
                        foreign.append(i)
                    }
                    filterdCities = foreign
                }
                for i in filterdCities {
                    if i.city_name.contains(whiteSpace) || i.city_explain.contains(whiteSpace) || i.city_english_name.lowercased().contains(whiteSpace.lowercased()) || i.city_english_name.uppercased().contains(whiteSpace.uppercased()){
                            searchList.append(i)
                    }
                }
                filterdCities = searchList
            default: for i in cities {
                        if i.city_name.contains(whiteSpace) || i.city_explain.contains(whiteSpace) || i.city_english_name.lowercased().contains(whiteSpace.lowercased()) || i.city_english_name.uppercased().contains(whiteSpace.uppercased()){
                                searchList.append(i)
                        }
                    }
                filterdCities = searchList
            }
        }
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var searchList: [City] = []
        let whiteSpace = searchBar.text!.trimmingCharacters(in: .whitespaces)
        
        for i in filterdCities {
            if  i.city_name.contains(whiteSpace) || i.city_explain.contains(whiteSpace) || i.city_english_name.lowercased().contains(whiteSpace.lowercased()) || i.city_english_name.uppercased().contains(whiteSpace.uppercased()) {
                searchList.append(i)
            }
        }
        filterdCities = searchList
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var searchList: [City] = []

        let whiteSpace = searchBar.text!.trimmingCharacters(in: .whitespaces)
        if uiSegmentedControl.selectedSegmentIndex == 1 {
            var korea: [City] = []
            // cities 도시 정보들고 있는 배열
            for i in cities {
                if i.domestic_travel {
                    korea.append(i)
                }
                filterdCities = korea
            }
            if searchText.isEmpty {
                searchList = filterdCities
            } else {
                for i in filterdCities {
                    if i.city_name.contains(whiteSpace) || i.city_explain.contains(whiteSpace) || i.city_english_name.lowercased().contains(whiteSpace.lowercased()) || i.city_english_name.uppercased().contains(whiteSpace.uppercased()){
                            searchList.append(i)
                    }
                }
            }
            
        }
        else if uiSegmentedControl.selectedSegmentIndex == 2 {
            var foreign: [City] = []
            for i in cities {
                if !i.domestic_travel {
                    foreign.append(i)
                }
            filterdCities = foreign
            }
            if searchText.isEmpty {
                searchList = filterdCities
            } else {
                for i in filterdCities {
                    if i.city_name.contains(whiteSpace) || i.city_explain.contains(whiteSpace) || i.city_english_name.lowercased().contains(whiteSpace.lowercased()) || i.city_english_name.uppercased().contains(whiteSpace.uppercased()){
                            searchList.append(i)
                    }
                }
            }
            
        }
        else {
            if searchText.isEmpty {
                searchList = cities
            }
            else {
                for i in cities {
                    if i.city_name.contains(whiteSpace) || i.city_explain.contains(whiteSpace) || i.city_english_name.lowercased().contains(whiteSpace.lowercased()) || i.city_english_name.uppercased().contains(whiteSpace.uppercased()){
                            searchList.append(i)
                    }
                }
            }
            
        }

        filterdCities = searchList
        tableView.reloadData()

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

extension UILabel {
    func setHighlighted(_ text: String, with search: String) {
        let attributedText = NSMutableAttributedString(string: text) // 1
        let range = NSString(string: text).range(of: search, options: .caseInsensitive) // 2
        let highlightColor = traitCollection.userInterfaceStyle == .light ? UIColor.systemYellow : UIColor.systemOrange // 3
        let highlightedAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.backgroundColor: highlightColor] // 4
    
        attributedText.addAttributes(highlightedAttributes, range: range) // 5
        self.attributedText = attributedText // 6
    }
}
