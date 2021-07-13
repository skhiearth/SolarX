//
//  AddPanelVC.swift
//  SolarX
//
//  Created by Utkarsh Sharma on 13/07/21.
//

import UIKit

class AddPanelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func augmentedRealityBtnPressed(_ sender: Any) {
    }
    
    @IBAction func mapBtnPressed(_ sender: Any) {
    }
    
    @IBAction func manualEntryPressed(_ sender: Any) {
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OverviewVC") as! OverviewVC
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:false, completion:nil)
    }
    
}
