//
//  SubsidiesVC.swift
//  SolarX
//
//  Created by Utkarsh Sharma and Simran Gogia on 02/07/21.
//

import UIKit

class SubsidiesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var seegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subsidies.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubsidiesCell", for: indexPath) as? SubsidiesCell
        
        cell?.selectionStyle = .none

        cell?.titleLb.text = subsidies[indexPath.row]!["Name"]
        cell?.statusLbl.text = subsidies[indexPath.row]!["Status"]
        cell?.displayImage.image = UIImage(named:subsidies[indexPath.row]!["Image"]!)
        
        if(subsidies[indexPath.row]!["Status"] == "Already Granted"){
            cell?.arrowImage.image = UIImage(named:"CaretRight")
        } else {
            cell?.arrowImage.image = UIImage(named:"CaretRightGreen")
        }
        
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(subsidies[indexPath.row]!["Status"] == "Already Granted"){
            // Already granted
        } else {
            // Apply for subsidy
            print("You tapped subsidy number \(indexPath.row).")
        }
        
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
