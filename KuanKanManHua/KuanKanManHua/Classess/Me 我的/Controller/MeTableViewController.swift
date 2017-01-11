//
//  MeTableViewController.swift
//  KuanKanManHua
//
//  Created by Youcai on 16/12/27.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit
private let ID = "cell"
class MeTableViewController: UITableViewController {
    
    private lazy var titleArray = [[String]]()
    private lazy var imageArray = [[String]]()
    init() {
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = self.headerView
        
        tableView.layer.insertSublayer(backlayer, at: 0)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.tapIconView))
        self.headerView.iconView.addGestureRecognizer(tap)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ID)
        titleArray = [["我的消息"],["我的关注","我的收藏"],["快看商城","我的订单"],["浏览历史","智能缓存"],["设置"]];
        imageArray = [["ic_me_item_message"],["ic_me_item_collection_topic","ic_me_item_collection_comic"],["ic_me_item_mall","ic_me_item_order"],["ic_me_item_history","ic_me_item_download_comic"],["ic_me_item_setting"]];
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return titleArray.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titleArray[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID, for: indexPath)
        cell.textLabel?.text = titleArray[indexPath.section][indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage.init(named: imageArray[indexPath.section][indexPath.row] )
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section >= 3 || (indexPath.section == 2 && indexPath.row == 0)  {
            if indexPath.section == 2 && indexPath.row == 0 {
                
                let controller = WebViewController()
                controller.urlString = "http://www.kuaikanmanhua.com/v1/shop/home"
                controller.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(controller, animated: true)
                return
            }
            if indexPath.section == 3 && indexPath.row == 0 {
                
                let controller = HistoryTableViewController()
                
                controller.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(controller, animated: true)
                return
            }
            
        }
        if MMUtils.userHasLogin() {
            
        } else {
            
            self.present(UINavigationController.init(rootViewController: LoginViewController()), animated: true, completion: nil)
            
            
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    // MARK: - 方法
    func tapIconView()  {
        POSTNOTIFICATION(name: "login", data: nil)
    }
    // MARK: - 懒加载
    private lazy var headerView:HeaderView = {
        let view = HeaderView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 200))
        
        return view
    }()
    private lazy var backlayer:CALayer = {
        let layer = CALayer()
        layer.backgroundColor = RGB(r: 255, g: 209, b: 10, a: 1.0).cgColor
        layer.frame = CGRect.init(x: 0, y: -SCREEN_HEIGHT
            , width: SCREEN_WIDTH, height: SCREEN_HEIGHT + 200 )
        
        return layer
    }()
}
// MARK: - HeaderView
fileprivate class HeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //设置界面
    func setUI()  {
        addSubview(backView)
        addSubview(iconView)
        addSubview(loginlbl)
        backView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.snp.edges)
        }
        iconView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self)
            make.width.height.equalTo(83)
        }
        loginlbl.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(10)
            make.centerX.equalTo(iconView.snp.centerX)
        }
    }
    // 懒加载
    private lazy var backView:UIView = {
        let view = UIView.init()
        view.backgroundColor = RGB(r: 255, g: 209, b: 10, a: 1.0)
        return view
    }()
    lazy var iconView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(named: "ic_personal_avatar")
        view.clipsToBounds = true
        view.layer.cornerRadius = 83/2.0
        view.isUserInteractionEnabled = true
        return view
    }()
    private lazy var loginlbl:UILabel = {
        let view = UILabel.init(title: "登录", fontSize: 12, screenInset: 0)
        return view
    }()
    
    
}
