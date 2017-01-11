//
//  MainNavViewController.swift
//  起点阅读
//
//  Created by Youcai on 16/9/22.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

class MainNavViewController: UINavigationController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //interactivePopGestureRecognizer?.delegate = self
        let target = interactivePopGestureRecognizer?.delegate
        let pan = UIPanGestureRecognizer.init(target: target, action:  Selector(("handleNavigationTransition:")))
       
         pan.delegate = self
        view.addGestureRecognizer(pan)
        interactivePopGestureRecognizer?.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            
//            let leftBtn = UIButton.init(type: .custom)
//            leftBtn.frame = CGRect.init(x: 0, y: 0, width: 60, height: 60)
//            leftBtn.setImage( UIImage.init(named: "ic_nav_back_normal_11x19_"), for: .normal)
//            leftBtn.addTarget(self, action: #selector(MainNavViewController.pop), for: .touchUpInside)
//            let leftBarBtn = UIBarButtonItem.init(customView: leftBtn)
//            let spaceItem = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
//            spaceItem.width = -25
//            viewController.navigationItem.leftBarButtonItems = [spaceItem,leftBarBtn]
             viewController.navigationItem.leftBarButtonItem =  UIBarButtonItem.init(image: UIImage.init(named: "ic_nav_back_normal_11x19_"), style: .plain, target: self, action: #selector(MainNavViewController.pop))
        }
        super.pushViewController(viewController, animated: animated)
    }
//    override func popViewController(animated: Bool) -> UIViewController? {
//        
//        super.popViewController(animated: animated)
//        return self
//    }
    func pop()  {
      popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if childViewControllers.count == 1 {
            return false
        }
        return true
    }
}
