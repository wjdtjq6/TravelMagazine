//
//  TourDetailViewController.swift
//  TravelMagazine
//
//  Created by t2023-m0032 on 5/31/24.
//

import UIKit

class TourDetailViewController: UIViewController {

    @IBOutlet var tourTitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "관광지 화면"
        
        tourTitleLabel.text = "관광지 화면"
        tourTitleLabel.font = .boldSystemFont(ofSize: 40)
        tourTitleLabel.textAlignment = .center
        
        //pop
        let popButton = UIBarButtonItem(image: UIImage(systemName: "lessthan"), style: .plain, target: self, action: #selector(popButtonClicked))
        //navigation에 임베드되어있어야함
        navigationItem.leftBarButtonItem = popButton
        popButton.tintColor = .black
    }
    @objc func popButtonClicked() {
        navigationController?.popViewController(animated: true)
    }

}
