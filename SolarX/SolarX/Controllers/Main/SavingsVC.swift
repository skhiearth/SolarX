//
//  SavingsVC.swift
//  SolarX
//
//  Created by Utkarsh Sharma and Simran Gogia on 02/07/21.
//

import UIKit

class SavingsVC: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                print("Week")
            case 1:
                print("Month")
            case 2:
                print("All Time")
            default:
                break;
        }
    }
    
    @IBAction func goToMain(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OverviewVC") as! OverviewVC
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    @IBAction func goToSubsidies(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SubsidiesVC") as! SubsidiesVC
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:false, completion:nil)
    }
    
}
