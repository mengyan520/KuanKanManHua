//
//  CategoryViewController.swift
//  KuanKanManHua
//
//  Created by 马鸣 on 2016/12/16.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit
import MJRefresh
private let Btnwidth = Int(SCREEN_WIDTH / 6)
class CategoryViewController: BaseViewController {
    
    var since = 0
    var titles:[Tags]? {
        didSet{
            
            for i in 0..<titles!.count {
                
                let btn = UIButton.init(title: titles![i].title!, color: BLACK_COLOR, fontSize: 14, target: self, actionName: #selector(self.topBtnClick(sender:)))
                
                btn.frame = CGRect.init(x: i * Btnwidth, y: 0, width:Btnwidth, height: 40)
                btn.setTitleColor(mainColor, for: .selected)
                Titlescrollview.addSubview(btn)
                
                btn.tag = i
                if i == 0 {
                    btn.isSelected = true
                    currentBtn = btn
                    
                    
                }
            }
            yellowView.frame = CGRect.init(x: 5, y: 37, width: Btnwidth - 10, height: 2)
            Titlescrollview.addSubview(yellowView)
            scrollView.contentSize = CGSize.init(width: SCREEN_WIDTH * CGFloat(titles!.count), height: 0)
            Titlescrollview.contentSize = CGSize.init(width:  Btnwidth * titles!.count, height: 0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        view.addSubview(scrollView)
        view.addSubview(Titlescrollview)
        let Tableview = CategoryTableView()
        Tableview.tag = 100
        refresh(tableView: Tableview)
        
        
        let vcW = scrollView.frame.size.width
        let vcH = scrollView.frame.size.height
        
        Tableview.frame =  CGRect.init(x: 0 , y: 0, width: vcW, height: vcH)
        
        scrollView.addSubview(Tableview)
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func refresh(tableView:CategoryTableView) {
        let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(CategoryViewController.loadData))
        
        tableView.mj_header = header
        let footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(CategoryViewController.loadMoreData))
        tableView.mj_footer = footer
        tableView.mj_footer.isHidden = true
        currentTableView = tableView
        tableView.del = self
    }
    //MARK: - 网络请求
    func loadData()  {
        
        var url = "https://api.kkmh.com/v1/topic_new/lists/get_by_tag?count=20&since=0&tag=0"
        if  titles != nil {
            url = "https://api.kkmh.com/v1/topic_new/lists/get_by_tag?count=20&since=0&tag=\(titles![(currentTableView?.tag)! - 100].tag_id)"
        }
        
        NetworkTools.shardTools.requestL(method: .get, URLString: url, parameters: nil) { (response, error) in
            self.currentTableView?.mj_header.endRefreshing()
            
            if error == nil {
                guard let object = response as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                
                let model = Model.init(dict: object)
                if (self.currentTableView?.tag) == 100 {
                    self.titles = (model.data?.tags)!
                }
                self.currentTableView?.mj_footer.isHidden = false
                self.currentTableView?.dataArray = (model.data?.topics)!
                self.currentTableView?.reloadData()
            }else {
                 JGPHUD.showErrorWithStatus(status: "无网络连接", view: self.view)
            }
        }
    }
    func loadMoreData()  {
        since = since + 20
        var url = "https://api.kkmh.com/v1/topic_new/lists/get_by_tag?count=20&since=\(since)&tag=0"
        if  titles != nil {
            url = "https://api.kkmh.com/v1/topic_new/lists/get_by_tag?count=20&since=\(since)&tag=\(titles![(currentTableView?.tag)! - 100].tag_id)"
        }
        
        NetworkTools.shardTools.requestL(method: .get, URLString: url, parameters: nil) { (response, error) in
            self.currentTableView?.mj_footer.endRefreshing()
            
            if error == nil {
                guard let object = response as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                
                let model = Model.init(dict: object)
                
                
                self.currentTableView?.dataArray =  (self.currentTableView?.dataArray)! + (model.data?.topics)!
                self.currentTableView?.reloadData()
                if (model.data?.topics)!.count < 20 {
                    self.currentTableView?.mj_footer.isHidden = true
                    
                }
            }else {
            }
        }
    }
    var currentTableView:CategoryTableView?
    // MARK: - 懒加载
    fileprivate lazy var Titlescrollview:UIScrollView = {
        let view = UIScrollView.init(frame: CGRect.init(x: 0, y:0, width: SCREEN_WIDTH, height: 40))
        // let titles = ["全部","恋爱","耿美","恐怖","古风","爆笑","奇幻","校园","都市","少年","治愈","百合","完结"]
        //        for i in 0..<titles.count {
        //
        //            let btn = UIButton.init(title: titles[i], color: BLACK_COLOR, fontSize: 14, target: self, actionName: #selector(self.topBtnClick(sender:)))
        //
        //            btn.frame = CGRect.init(x: i * Btnwidth, y: 0, width:Btnwidth, height: 40)
        //            btn.setTitleColor(mainColor, for: .selected)
        //            view.addSubview(btn)
        //
        //            btn.tag = i
        //
        //        }
        
        
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    fileprivate lazy var scrollView:UIScrollView = {
        let view = UIScrollView.init(frame: CGRect.init(x: 0, y:40, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-49-40))
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.isPagingEnabled = true;
        view.bounces = false
        
        return view
    }()
    
    fileprivate lazy var currentBtn:UIButton = {
        let btn = UIButton.init()
        
        return btn
    }()
    fileprivate lazy var yellowView:UIView = {
        let view = UIView.init()
        view.backgroundColor = mainColor
        return view
    }()
}
// MARK: - 代理方法/自定义方法
extension CategoryViewController : UIScrollViewDelegate,CategoryTableViewDel {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == self.scrollView {
            let  offsetX = (Titlescrollview.contentSize.width -  (currentBtn.width - 5) )/(SCREEN_WIDTH * CGFloat((titles!.count-1)))
            if scrollView.contentOffset.x * offsetX <= 5 {
                yellowView.x = 5
                return
            }
            
            yellowView.x = scrollView.contentOffset.x * offsetX
            
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            scrollViewDidEndScrollingAnimation(scrollView)
        }
        
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        let index = scrollView.contentOffset.x / scrollView.bounds.size.width
        let btn = (Titlescrollview.subviews[NSInteger(index)] as! UIButton)
        addChildView(index: index)
        topViewOffset(sender: btn)
    }
    func topBtnClick(sender: UIButton) {
        
        let offsetX = CGFloat(sender.tag) * SCREEN_WIDTH
        
        scrollView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)
        
    }
    func addChildView(index:CGFloat)  {
        
        var Tableview = view.viewWithTag(100 + Int(index))
        
        if (Tableview  != nil) {
            currentTableView = Tableview as! CategoryTableView?
            return
        }
        Tableview = CategoryTableView()
        Tableview?.tag = 100 + Int(index)
        refresh(tableView: Tableview as! CategoryTableView)
        let vcW = scrollView.frame.size.width
        let vcH = scrollView.frame.size.height
        let vcY:CGFloat = 0
        let vcX = index * vcW
        Tableview?.frame = CGRect.init(x: vcX, y: vcY, width: vcW, height: vcH)
        scrollView.addSubview(Tableview!)
        currentTableView?.mj_header.beginRefreshing()
    }
    
    func topViewOffset(sender:UIButton) {
        currentBtn.isSelected = false
        currentBtn = sender
        sender.isSelected = true
        var offset = sender.center.x - Titlescrollview.bounds.size.width*0.6
        let maxoffset = Titlescrollview.contentSize.width - SCREEN_WIDTH/6 - Titlescrollview.bounds.size.width
        if offset < 0 {
            offset = 0
        }else if offset > maxoffset  {
            offset = maxoffset + SCREEN_WIDTH/6
        }
        Titlescrollview.setContentOffset(CGPoint.init(x: offset, y: 0), animated: true)
        
        
    }
    func didSelectRowAtIndex(ID: Int) {
        let controller = WordDetailViewController.init(ID:"\(ID)")
        controller.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

