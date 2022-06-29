//
//  Contact.swift
//  IceBreaker
//
//  Created by shy attoun on 30/05/2019.
//  Copyright © 2019 shy attoun. All rights reserved.
//

import UIKit
import MessageUI

class ContactUsViewController:
UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,MFMailComposeViewControllerDelegate{
    
    @IBOutlet var subjectPicker: [UIPickerView]!
    
    @IBOutlet weak var contactMSG: UITextField!
    
    @IBOutlet weak var userEmailField: UITextField!
    
    @IBOutlet var ContactVC: UIView!
    
    var topics = ["choose your topic:","What Do You Preffer?","Funny Facts","Pickup Lines","Associations","Big Questions","Jokes","General"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return topics.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return topics[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        topics[0] = ""
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func sendContactMSG(_ sender: AnyObject) {
        
        if MFMailComposeViewController.canSendMail() {
                       let toRecipients = ["icebreakerapp@gmail.com"]
            
            let mc: MFMailComposeViewController = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setToRecipients(toRecipients)
            
            mc.setMessageBody("swdfsafafsfs", isHTML: false)
            
           UIApplication.shared.keyWindow?.rootViewController?.present(mc, animated: true, completion: nil)
        }
        
      
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Cancelled")
            
        case MFMailComposeResult.failed.rawValue:
            print("Failed")
            
        case MFMailComposeResult.saved.rawValue:
            print("Saved")
            
        case MFMailComposeResult.sent.rawValue:
            print("Sent")
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
    }
}
