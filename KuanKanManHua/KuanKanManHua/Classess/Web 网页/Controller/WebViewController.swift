//
//  WebViewController.swift
//  KuanKanManHua
//
//  Created by Youcai on 17/1/6.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: BaseViewController,WKNavigationDelegate {
    var webView:WKWebView?
    var urlString:String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = true
        webView = WKWebView.init(frame: view.bounds)
        webView?.backgroundColor = WHITE_COLOR
        webView?.navigationDelegate = self
        view.addSubview(webView!)
        // title = webView?.title
        let url = URL(string: urlString!)
        // 根据URL创建请求
        let requst = URLRequest(url: url!)
        // WKWebView加载请求
        webView!.load(requst)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - weview delegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.title = webView.title
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
}
