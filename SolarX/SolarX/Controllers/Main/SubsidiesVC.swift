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
    
    var selectionType = "Subsidies"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        switch seegmentedControl.selectedSegmentIndex {
            case 0:
                selectionType = "Subsidies"
                tableView.reloadData()
            case 1:
                selectionType = "Products"
                tableView.reloadData()
            case 2:
                selectionType = "Contractors"
            default:
                break;
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectionType {
        case "Subsidies":
            return subsidies.count
        case "Products":
            return products.count
        case "Contractors":
            return contractors.count
        default:
            return subsidies.count
        }
        
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubsidiesCell", for: indexPath) as? SubsidiesCell
        
        cell?.selectionStyle = .none
        if(selectionType == "Subsidies"){
            cell?.titleLb.text = subsidies[indexPath.row]!["Name"]
            cell?.statusLbl.text = subsidies[indexPath.row]!["Status"]
            cell?.displayImage.image = UIImage(named: subsidies[indexPath.row]!["Image"]!)
            
            if(subsidies[indexPath.row]!["Status"] == "Already Granted"){
                cell?.arrowImage.image = UIImage(named:"CaretRight")
            } else {
                cell?.arrowImage.image = UIImage(named:"CaretRightGreen")
            }
        } else if(selectionType == "Products"){
            cell?.titleLb.text = products[indexPath.row]!["Name"]
            cell?.statusLbl.text = products[indexPath.row]!["Status"]
            cell?.displayImage.image = UIImage(named: products[indexPath.row]!["Image"]!)
            
            if(products[indexPath.row]!["Status"] == "Already Granted"){
                cell?.arrowImage.image = UIImage(named:"CaretRight")
            } else {
                cell?.arrowImage.image = UIImage(named:"CaretRightGreen")
            }
        }
        
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(selectionType == "Subsidies"){
            if(subsidies[indexPath.row]!["Status"] == "Already Granted"){
                // Already granted
            } else {
                self.showSimpleActionSheet(controller: self, number: indexPath.row,
                                           name: subsidies[indexPath.row]!["Name"]!, description: subsidies[indexPath.row]!["Description"]!,
                                           url: subsidies[indexPath.row]!["URL"]!)
            }
        } else if (selectionType == "Products"){
            if(products[indexPath.row]!["Status"] == "Already Granted"){
                // Already granted
            } else {
                self.showSimpleActionSheet(controller: self, number: indexPath.row,
                                           name: products[indexPath.row]!["Name"]!, description: products[indexPath.row]!["Description"]!,
                                           url: products[indexPath.row]!["URL"]!)
            }
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
    
    func showSimpleActionSheet(controller: UIViewController, number: Int, name: String, description: String, url: String) {
        let alert = UIAlertController(title: name, message: description, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Apply", style: .default, handler: { (_) in
            subsidyNumber = number
            if let url = URL(string: url),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }))

        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
}
