//
//  ViewController.swift
//  MissionBriefingSwift
//
//  Created by Jordan Anderson on 4/1/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet var agentNameTextField : UITextField!
    @IBOutlet var agentPasswordTextField : UITextField!
    @IBOutlet var greetingLabel : UILabel!
    @IBOutlet var missionBriefingTextView : UITextView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        agentNameTextField.text = ""
        greetingLabel.text = ""
        missionBriefingTextView.text = ""
        
        agentNameTextField.delegate = self
        agentPasswordTextField.delegate = self
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func authenticateButton(sender : UIButton)
    {
        authenticateUser()
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        var rc = true
            
            if textField == agentNameTextField
            {
             agentNameTextField.resignFirstResponder()
             agentPasswordTextField.becomeFirstResponder()
            }
            else if textField == agentPasswordTextField
            {
             agentPasswordTextField.resignFirstResponder()
             authenticateUser()
            }
        
        return rc;
    }
    
    func authenticateUser()
    {
        if !agentNameTextField.text.isEmpty && !agentPasswordTextField.text.isEmpty
        {
            var nameParts = agentNameTextField.text.componentsSeparatedByString(" ")
            var agentName = nameParts[0];
            if nameParts.count == 2
            {
                agentName = nameParts[1]
            }
            else if nameParts.count == 3
            {
                agentName = nameParts[2]
            }
            
            let greetingMessage = "Good evening, Agent \(agentName)"
            greetingLabel.text = greetingMessage;
            
            missionBriefingTextView.text = String(format:"This mission will be an arduous one, fraught with peril. You will cover much strange and unfamiliar territory. Should you choose to accept this mission, Agent \(agentName), you will certainly be disavowed, but you will be doing your country a great service. This message will self destruct in 5 seconds.")
            
            let swiftColor = UIColor(red: 0.585, green: 0.78, blue: 0.188, alpha: 1)
           self.view.backgroundColor = swiftColor
        }
        else
        {
            self.view.backgroundColor = UIColor.redColor()
        }
    }

}

