//
//  MailboxViewController.swift
//  mailbox
//
//  Created by Sam Huskins on 2/18/16.
//  Copyright © 2016 Sam Huskins. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var rescheduleOverlay: UIImageView!
    @IBOutlet weak var listOverlay: UIImageView!
    @IBOutlet weak var menuView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var composeView: UIView!
    
    var messageOriginalCenter: CGPoint!
    var laterOriginalCenter: CGPoint!
    var archiveOriginalCenter: CGPoint!
    var feedOriginalCenter:CGPoint!
    var mainOriginalCenter:CGPoint!

    //bkg colors
    let backgroundOriginal = UIColor(hue: 0.620876, saturation: 0.0137875, brightness: 0.931014, alpha: 1)
    let archiveColor = UIColor(hue: 0.314688, saturation: 0.546394, brightness: 0.850593, alpha: 1)
    let laterColor = UIColor(hue: 0.133735, saturation: 0.801368, brightness: 0.981115, alpha: 1)
    let deleteColor = UIColor(hue: 0.0303053, saturation: 0.785326, brightness: 0.924227, alpha: 1)
    let listColor = UIColor(hue: 0.0831905, saturation: 0.459229, brightness: 0.847929, alpha: 1)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: 1367)
        
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        mainView.addGestureRecognizer(edgeGesture)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onEdgePan(sender: UIScreenEdgePanGestureRecognizer){
        // Absolute (x,y) coordinates in parent view
        var point = sender.locationInView(view)
        
        // Relative change in (x,y) coordinates from where gesture began.
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        //print(mainView.center.x)


        if sender.state == UIGestureRecognizerState.Began {
            mainOriginalCenter = mainView.center

        } else if sender.state == UIGestureRecognizerState.Changed {
            mainView.center = CGPoint(x: mainOriginalCenter.x + translation.x, y: mainOriginalCenter.y)

        } else if sender.state == UIGestureRecognizerState.Ended {
            if mainView.center.x > 320 {
                UIView.animateWithDuration(0.2, delay: 0, options: [], animations: { () -> Void in
                    self.mainView.center.x = 450
                    }, completion: { (finished) -> Void in
                })

            } else{
                UIView.animateWithDuration(0.2, delay: 0, options: [], animations: { () -> Void in
                    self.mainView.center.x = 160
                    }, completion: { (finished) -> Void in
                })
            }
        }
    }
    
    @IBAction func onNavTap(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
            self.mainView.center.x = 160
            }, completion: { (finished) -> Void in
        })
    }
    @IBAction func messageDidPan(sender: UIPanGestureRecognizer) {
        // Absolute (x,y) coordinates in parent view
        var point = sender.locationInView(view)
        
        // Relative change in (x,y) coordinates from where gesture began.
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            messageOriginalCenter = messageImageView.center
            laterOriginalCenter = laterIcon.center
            archiveOriginalCenter = archiveIcon.center
            
             //print("Gesture began at: \(messageImageView.center.x)")
        } else if sender.state == UIGestureRecognizerState.Changed {
            var laterAlpha = convertValue(messageImageView.center.x, r1Min: 100, r1Max: 160, r2Min: 1, r2Max: 0)
            var archiveAlpha = convertValue(messageImageView.center.x, r1Min: 160, r1Max: 220, r2Min: 0, r2Max: 1)

            messageImageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            //print("Gesture changed at: \(messageImageView.center.x)")

        
            if messageImageView.center.x < 0 {
                messageBackground.backgroundColor = listColor
                laterIcon.center = CGPoint(x: laterOriginalCenter.x + translation.x + 60, y: laterOriginalCenter.y)
                laterIcon.image = UIImage(named: "list_icon")
                laterIcon.alpha = 1
                
            } else if messageImageView.center.x < 100 {
                messageBackground.backgroundColor = laterColor
                laterIcon.center = CGPoint(x: laterOriginalCenter.x + translation.x + 60, y: laterOriginalCenter.y)
                laterIcon.image = UIImage(named: "later_icon")
                laterIcon.alpha = 1

            } else if messageImageView.center.x < 160 {
                messageBackground.backgroundColor = self.backgroundOriginal
                laterIcon.alpha = laterAlpha

            } else if messageImageView.center.x > 320 {
                messageBackground.backgroundColor = deleteColor
                archiveIcon.center = CGPoint(x: archiveOriginalCenter.x + translation.x - 60, y: archiveOriginalCenter.y)
                archiveIcon.image = UIImage(named: "delete_icon")
                archiveIcon.alpha = 1

            } else if messageImageView.center.x > 220 {
                messageBackground.backgroundColor = archiveColor
                archiveIcon.center = CGPoint(x: archiveOriginalCenter.x + translation.x - 60, y: archiveOriginalCenter.y)
                archiveIcon.image = UIImage(named: "archive_icon")
                archiveIcon.alpha = 1

            } else if messageImageView.center.x > 160 {
                messageBackground.backgroundColor = self.backgroundOriginal
                archiveIcon.alpha = archiveAlpha

            }

        } else if sender.state == UIGestureRecognizerState.Ended {
            //print("Gesture ended at pt: \(point.x)")
            
            if messageImageView.center.x < 0 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageImageView.center = CGPoint(x: -160, y: self.messageOriginalCenter.y)
                    self.laterIcon.center = CGPoint(x: 0, y: self.laterOriginalCenter.y)
                    self.laterIcon.alpha = 0
                })
                UIView.animateWithDuration(0.2, delay: 0.5, options: [], animations: { () -> Void in
                    self.listOverlay.alpha = 1
                    }, completion: { (finished) -> Void in
                        
                })

            } else if messageImageView.center.x < 100 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageImageView.center = CGPoint(x: -160, y: self.messageOriginalCenter.y)
                    self.laterIcon.center = CGPoint(x: 0, y: self.laterOriginalCenter.y)
                    self.laterIcon.alpha = 0

                })
                UIView.animateWithDuration(0.2, delay: 0.5, options: [], animations: { () -> Void in
                    self.rescheduleOverlay.alpha = 1
                    }, completion: { (finished) -> Void in
                        
                })

                
            } else if messageImageView.center.x < 160 {
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                    self.messageImageView.center = self.messageOriginalCenter
                    self.messageBackground.backgroundColor = self.backgroundOriginal
                    self.archiveIcon.center = self.archiveOriginalCenter
                    self.laterIcon.center = self.laterOriginalCenter
                    
                    }, completion: { (Bool) -> Void in
                })

                
            } else if messageImageView.center.x > 320 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageImageView.center = CGPoint(x: 480, y: self.messageOriginalCenter.y)
                    self.archiveIcon.center = CGPoint(x: 320, y: self.archiveOriginalCenter.y)
                    self.archiveIcon.alpha = 0
                })
                UIView.animateWithDuration(0.2, delay: 0.5, options: [], animations: { () -> Void in
                    self.feedImageView.center.y -= 86
                    
                    }, completion: { (finished) -> Void in
                        
                })

            } else if messageImageView.center.x > 220 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageImageView.center = CGPoint(x: 480, y: self.messageOriginalCenter.y)
                    self.archiveIcon.center = CGPoint(x: 320, y: self.archiveOriginalCenter.y)
                    self.archiveIcon.alpha = 0
                })
                UIView.animateWithDuration(0.2, delay: 0.5, options: [], animations: { () -> Void in
                    self.feedImageView.center.y -= 86
                    
                    }, completion: { (finished) -> Void in
                        
                })
            } else if messageImageView.center.x > 160 {
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                    self.messageImageView.center = self.messageOriginalCenter
                    self.messageBackground.backgroundColor = self.backgroundOriginal
                    self.archiveIcon.center = self.archiveOriginalCenter
                    self.laterIcon.center = self.laterOriginalCenter
                    
                    }, completion: { (Bool) -> Void in
                })
                
            }
        }

        
    }
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        // print("shake")
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.feedImageView.center.y += 86
            self.messageImageView.center = self.messageOriginalCenter
            self.messageImageView.center = self.messageOriginalCenter
            self.messageBackground.backgroundColor = self.backgroundOriginal
            self.archiveIcon.center = self.archiveOriginalCenter
            self.laterIcon.center = self.laterOriginalCenter
            
        })

    }
    @IBAction func onOverlayTap(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            sender.view?.alpha = 0
            self.feedImageView.center.y -= 86

        })

    }
    
    @IBAction func composeTap(sender: UIButton) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.composeView.alpha = 1
            
        })

    }
    
    @IBAction func composeCancelTap(sender: UIButton) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.composeView.alpha = 0
            
        })

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
