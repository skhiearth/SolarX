//
//  OverviewVC.swift
//  SolarX
//
//  Created by Utkarsh Sharma and Simran Gogia on 02/07/21.
//

import UIKit

var globalCO2Mitigation = 0.0
var globalCostSaving = 0.0
var globalInstallation = 0.0

var supremeArea = 0.0
var percentage = 0.0

class OverviewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func goToSavings(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SavingsVC") as! SavingsVC
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    @IBAction func goToSubsidies(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SubsidiesVC") as! SubsidiesVC
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    @IBAction func addNewSolarPanel(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddPanelVC") as! AddPanelVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func skipToAR(_ sender: Any) {
        
    }
    
    @IBAction func skipToMap(_ sender: Any) {
        
    }
    
    @IBAction func goToPreferences(_ sender: Any) {
        
    }
    
    @IBAction func chatSupport(_ sender: Any) {
        
    }
    
    @IBAction func callSupport(_ sender: Any) {
        
    }
}
