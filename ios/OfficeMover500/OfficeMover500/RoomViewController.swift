//
//  ViewController.swift
//  OfficeMover500
//
//  Created by Katherine Fang on 10/28/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController, UIPopoverControllerDelegate, AddNewItemDelegate, ChangeBackgroundDelegate {
    
    @IBOutlet weak var roomView: UIView!
    @IBOutlet weak var layoutView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var addItemButton: UIBarButtonItem!
    @IBOutlet weak var backgroundButton: UIBarButtonItem!
    
    var popoverController: UIPopoverController?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        layoutView.backgroundColor = UIColor(patternImage: UIImage(named: "office.png")!)
        
        var nav = self.navigationController?.navigationBar
        nav?.barTintColor = TopbarBlue
        nav?.barStyle = UIBarStyle.Default
        nav?.tintColor = UIColor.whiteColor()
        var font: UIFont = UIFont(name: "Proxima Nova", size: 20)!
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName:font]
        
        navigationItem.leftBarButtonItems = [addItemButton, backgroundButton]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        popoverController?.dismissPopoverAnimated(false)
        
        // This is to support closing popovers in iOS 7
        if let popoverSegue = segue as? UIStoryboardPopoverSegue {
            self.popoverController = popoverSegue.popoverController
            self.popoverController?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.8)
        }
        
        if segue.identifier == "addItemPopoverSegue" {
            if let controller = segue.destinationViewController as? AddItemController {
                controller.delegate = self
            }
        } else if segue.identifier == "changeBackgroundPopoverSegue" {
            if let popoverController = segue.destinationViewController as? ChangeBackgroundController {
                popoverController.delegate = self
            }
        }
    }
    
    func dismissPopover() {
        popoverController?.dismissPopoverAnimated(true)
        popoverController = nil
    }
    
    func setBackgroundLocally(type: String) {
        if let image = UIImage(named:"\(type).png") {
            backgroundView.backgroundColor = UIColor(patternImage: image)
        }
    }
}