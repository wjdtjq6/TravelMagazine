//
//  TravelMagazineTableViewController.swift
//  TravelMagazine
//
//  Created by t2023-m0032 on 5/27/24.
//

import UIKit

class TravelMagazineTableViewController: UITableViewController {

    var magazine = MagazineInfo().magazine
    
    @IBOutlet var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel?.text = "SeSac Travel"
        titleLabel?.font = .boldSystemFont(ofSize: 20)
        titleLabel?.textAlignment = .center
        
        tableView.rowHeight = 450
    }
    //섹션의 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    //셀의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazine.count
    }
    //섹션 데이터 및 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelMagazine", for: indexPath) as! TravelMagazineTableViewCell
        
        //view
        let url = URL(string: magazine[indexPath.row].photo_image)
        cell.imageUIView.kf.setImage(with: url)
        cell.imageUIView.layer.cornerRadius = 10
        cell.imageUIView.contentMode = .scaleAspectFill
        
        cell.titleLabel.text = magazine[indexPath.row].title
        cell.titleLabel.font = .boldSystemFont(ofSize: 20)

        cell.subTitleLabel.text = magazine[indexPath.row].subtitle
        cell.subTitleLabel.font = .systemFont(ofSize: 15)
        cell.subTitleLabel.textColor = .lightGray
        
        cell.dateLabel.font = .systemFont(ofSize: 14)
        cell.dateLabel.textColor = .lightGray
        //
        
        let format = DateFormatter()
        format.dateFormat = "yyMMdd"
        let converDate = format.date(from: magazine[indexPath.row].date)
        let myDateFormat = DateFormatter()
        myDateFormat.dateFormat = "yy년 MM월 dd일"
        cell.dateLabel.text? = myDateFormat.string(from: converDate!)
        //cell.dateLabel.text = magazine[indexPath.row].date
        
        
        return cell
    }

}
//1.
//2.
//3.
