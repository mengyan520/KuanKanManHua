//
//  JGPHUD.swift
//  KuanKanManHua
//
//  Created by Youcai on 17/3/1.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit
import JGProgressHUD
class JGPHUD: NSObject {
    class func showErrorWithStatus(status:String,view:UIView)  {
        
        let hud = JGProgressHUD.init(style: .extraLight)
       
        hud?.textLabel.text = status
        hud?.indicatorView = JGProgressHUDErrorIndicatorView()
        hud?.interactionType = .blockNoTouches
        
        hud?.show(in: view)
        hud?.dismiss(afterDelay: 1)
    }
    class func showSuccessWithStatus(status:String,view:UIView)  {
        let hud = JGProgressHUD.init(style: .extraLight)
        
        hud?.textLabel.text = status
        hud?.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud?.interactionType = .blockNoTouches
        
        hud?.show(in: view)
        hud?.dismiss(afterDelay: 1)
    }
    class func showProgressWithStatus(status:String?,view:UIView)  {
        let hud = JGProgressHUD.init(style: .extraLight)
         hud?.textLabel.text = status
        
        hud?.show(in: view)
        //hud?.dismiss()
    }
    class func dismiss(view:UIView)  {

        let huds = JGProgressHUD.allProgressHUDs(in: view)
        for hud in huds! {
           (hud as! JGProgressHUD).dismiss()
        }
    }
    class func showCustomImage(imageName:String,view:UIView)  {
        let hud = JGProgressHUD.init(style: .extraLight)
        hud?.indicatorView = JGProgressHUDSuccessIndicatorView.init(image: UIImage.init(named: imageName))
        hud?.interactionType = .blockNoTouches
        hud?.show(in: view)
        hud?.dismiss(afterDelay: 1)
    }
}
