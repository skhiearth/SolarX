//
//  SubsidiesVC.swift
//  SolarX
//
//  Created by Utkarsh Sharma and Simran Gogia on 02/07/21.
//

import UIKit

class SubsidiesVC: UIViewController {
    
    @IBOutlet weak var seegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        
    }
    
    @IBAction func goToMain(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OverviewVC") as! OverviewVC
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    @IBAction func goToSavings(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SavingsVC") as! SavingsVC
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:false, completion:nil)
    }
}
