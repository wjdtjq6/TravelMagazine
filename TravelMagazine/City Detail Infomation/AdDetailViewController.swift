//
//  AdDetailViewController.swift
//  TravelMagazine
//
//  Created by t2023-m0032 on 5/31/24.
//

import UIKit

class AdDetailViewController: UIViewController {

    @IBOutlet var adTitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "광고 화면"
        
        adTitleLabel.text = "광고 화면"
        adTitleLabel.font = .boldSystemFont(ofSize: 40)
        adTitleLabel.textAlignment = .center
        
        let dismissButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissButtonClicked))
        navigationItem.leftBarButtonItem = dismissButton
        dismissButton.tintColor = .black
    }
    @objc func dismissButtonClicked() {
        dismiss(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
