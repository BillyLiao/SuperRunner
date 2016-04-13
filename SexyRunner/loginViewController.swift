//
//  loginViewController.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/3/13.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit

class loginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var occupationText: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    var keyboardHeight: CGFloat!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)

        submitButton.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 95/255, alpha: 1)
        // Do any additional setup after loading the view.
        userImageView.layer.cornerRadius = (userImageView?.frame.size.width)! / 2
        userImageView.clipsToBounds = true
        
        // The way to dismiss keyboard on scrollView
        var tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
    }

    
    func dismissKeyboard() {
        self.view.endEditing(true)
        scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    

    /* also can scroll text field, but hard to dynamic access keyboard height.
    func textFieldDidBeginEditing(textField: UITextField) {
    ScrollView.setContentOffset(CGFloatMake(0, 160), animated: true)
    }
    */
    
    // seems the best way to move the text field up when keyboard shows.
    func keyboardWillShow(notification:NSNotification) {
        let userInfo:NSDictionary = notification.userInfo!
        let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.CGRectValue()
        scrollView.setContentOffset(CGPointMake(0, keyboardRectangle.height - 30), animated: true)
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
    }
    
    // when press return on keyboard, then dismiss it!
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    // dismiss the keyboard when touches other place
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
