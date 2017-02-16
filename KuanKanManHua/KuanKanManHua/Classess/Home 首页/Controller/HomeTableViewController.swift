//
//  HomeTableViewController.swift
//  kuaikan
//
//  Created by 马鸣 on 2016/12/4.
//  Copyright © 2016年 马鸣. All rights reserved.
//https://api.kkmh.com/v1/daily/comic_lists/0?gender=1&sa_event=eyJldmVudCI6IlJlYWRIb21lUGFnZSIsInByb3BlcnRpZXMiOnsiVHJpZ2dlclBhZ2UiOiJIb21lUGFnZSIsIiRvc192ZXJzaW9uIjoiMTAuMiIsIkZyb21Ib21lcGFnZVVwZGF0ZURhdGUiOjAsIiRjYXJyaWVyIjoi5Lit5Zu956e75YqoIiwiJG9zIjoiaU9TIiwiJHNjcmVlbl9oZWlnaHQiOjEzMzQsIiRsaWIiOiJpT1MtbmV0IiwiJG1vZGVsIjoiaVBob25lIiwiJHNjcmVlbl93aWR0aCI6NzUwLCIkd2lmaSI6dHJ1ZSwiR2VuZGVyVHlwZSI6IueUt-eJiCIsIiRhcHBfdmVyc2lvbiI6IjMuNi4zIiwiJG1hbnVmYWN0dXJlciI6IkFwcGxlIiwiJG5ldHdvcmtfdHlwZSI6IldJRkkiLCJhYnRlc3RfZ3JvdXAiOjcwLCJIb21lcGFnZVRhYk5hbWUiOiLng63pl6giLCJIb21lcGFnZVVwZGF0ZURhdGUiOjB9LCJwcm9qZWN0Ijoia3VhaWthbl9hcHAiLCJkaXN0aW5jdF9pZCI6Imk6M0Y0NDlEQjYtNTNGNS00OTNDLTlERTUtN0U3MUNGRDkzNkQ4IiwidGltZSI6MTQ4NDIwNDMyNjE5OCwidHlwZSI6InRyYWNrIn0%3D&since=0
//https://api.kkmh.com/v1/daily/comic_lists/0?gender=0&sa_event=eyJldmVudCI6IlJlYWRIb21lUGFnZSIsInByb3BlcnRpZXMiOnsiVHJpZ2dlclBhZ2UiOiJIb21lUGFnZSIsIiRvc192ZXJzaW9uIjoiMTAuMi4xIiwiRnJvbUhvbWVwYWdlVXBkYXRlRGF0ZSI6MCwiJGNhcnJpZXIiOiLkuK3lm73np7vliqgiLCIkb3MiOiJpT1MiLCIkc2NyZWVuX2hlaWdodCI6MTMzNCwiJGxpYiI6ImlPUy1uZXQiLCIkbW9kZWwiOiJpUGhvbmUiLCIkc2NyZWVuX3dpZHRoIjo3NTAsIiR3aWZpIjp0cnVlLCJHZW5kZXJUeXBlIjoi5aWz54mIIiwiJGFwcF92ZXJzaW9uIjoiMy44LjMiLCIkbWFudWZhY3R1cmVyIjoiQXBwbGUiLCIkbmV0d29ya190eXBlIjoiV0lGSSIsImFidGVzdF9ncm91cCI6NzAsIkhvbWVwYWdlVGFiTmFtZSI6IueDremXqCIsIkhvbWVwYWdlVXBkYXRlRGF0ZSI6MH0sInByb2plY3QiOiJrdWFpa2FuX2FwcCIsImRpc3RpbmN0X2lkIjoiNDY5Mzg1MCIsInRpbWUiOjE0ODcxNDM2NzEzMTIsInR5cGUiOiJ0cmFjayJ9&since=1487113805
//https://api.kkmh.com/v1/fav/timeline?sa_event=eyJldmVudCI6IlJlYWRIb21lUGFnZSIsInByb3BlcnRpZXMiOnsiVHJpZ2dlclBhZ2UiOiJIb21lUGFnZSIsIiRvc192ZXJzaW9uIjoiMTAuMiIsIkZyb21Ib21lcGFnZVVwZGF0ZURhdGUiOjAsIiRjYXJyaWVyIjoi5Lit5Zu956e75YqoIiwiJG9zIjoiaU9TIiwiJHNjcmVlbl9oZWlnaHQiOjEzMzQsIiRsaWIiOiJpT1MtbmV0IiwiJG1vZGVsIjoiaVBob25lIiwiJHNjcmVlbl93aWR0aCI6NzUwLCIkd2lmaSI6dHJ1ZSwiR2VuZGVyVHlwZSI6IueUt-eJiCIsIiRhcHBfdmVyc2lvbiI6IjMuNi4zIiwiJG1hbnVmYWN0dXJlciI6IkFwcGxlIiwiJG5ldHdvcmtfdHlwZSI6IldJRkkiLCJhYnRlc3RfZ3JvdXAiOjcwLCJIb21lcGFnZVRhYk5hbWUiOiLlhbPms6gifSwicHJvamVjdCI6Imt1YWlrYW5fYXBwIiwiZGlzdGluY3RfaWQiOiI0NjkzODUwIiwidGltZSI6MTQ4NDI4OTQzOTIzNywidHlwZSI6InRyYWNrIn0%3D&since=0 关注
import UIKit
import MJRefresh


let cellID = "Homecell"
class HomeTableViewController: UITableViewController,HomeTableViewCellDel {
    var time:String = "0"
    var isLeft = false
    private var dataArray:[Comics] = [Comics].init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(self.loadData))
        
        tableView.mj_header = header
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        
        tableView.backgroundColor = WHITE_COLOR
        
        if isLeft {
            
            if MMUtils.userHasLogin()  {
                loadData() 
            }else {
             tableView.insertSubview(backLoginView, at: 0)
            }
            NotificationCenter.default.addObserver(self, selector: #selector(self.reloadUser), name: NSNotification.Name.init(rawValue: "UserLogin"), object: nil)
        }else {
           
          loadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    fileprivate lazy var backLoginView:BackLoginView = {
        let view = BackLoginView.init(frame: CGRect.init(x: 0, y:0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-49-64))
        view.imgString = "empty_comic_text"
        return view
    }()
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! HomeTableViewCell
        
        cell.data = dataArray[indexPath.row]
        cell.del = self
        cell.selectionStyle = .none
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataArray[indexPath.row].rowHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let data = Info.init(dict: nil)
//        data.title = dataArray[indexPath.row].topic!.title
//        data.topic_id = dataArray[indexPath.row].topic!.id
//        data.latest_comic_title = dataArray[indexPath.row].title
//        data.id = dataArray[indexPath.row].id
//        data.cover_image_url = dataArray[indexPath.row].topic!.cover_image_url
//        data.old_comic_title = dataArray[indexPath.row].title
//        SQLiteManager.sharedManager.saveData(data: data, name: "history")
        let controller = CartoonDetailViewController.init(ID: dataArray[indexPath.row].id, name: dataArray[indexPath.row].title!)
        
        controller.topicID = "\(dataArray[indexPath.row].topic!.id)"
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
    func didClickTopView(id: Int) {
        let controller = WordDetailViewController.init(ID:"\(id)")
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
    func didBtnClick(sender: UIButton, data: Comics) {
        if sender.tag == 2 {
            let controller = AllCommentTableViewController.init(feed_id: data.id,type:0)
            
            controller.nickname = (data.topic?.user?.nickname)!
            controller.hidesBottomBarWhenPushed = true
            let nav = UINavigationController.init(rootViewController:controller)
            self.present(nav, animated: true, completion: nil)
        } else {
            
            sender.isSelected = !sender.isSelected
            
        }
    }
    //MARK: - 网络请求
    func loadData()  {
        
        MMUtils.showLoading()
       
        var url = "https://api.kkmh.com/v1/daily/comic_lists/\(time)?gender=0&sa_event=eyJldmVudCI6IlJlYWRIb21lUGFnZSIsInByb3BlcnRpZXMiOnsiVHJpZ2dlclBhZ2UiOiJIb21lUGFnZSIsIiRvc192ZXJzaW9uIjoiMTAuMiIsIkZyb21Ib21lcGFnZVVwZGF0ZURhdGUiOjAsIiRjYXJyaWVyIjoi5Lit5Zu956e75YqoIiwiJG9zIjoiaU9TIiwiJHNjcmVlbl9oZWlnaHQiOjEzMzQsIiRsaWIiOiJpT1MtbmV0IiwiJG1vZGVsIjoiaVBob25lIiwiJHNjcmVlbl93aWR0aCI6NzUwLCIkd2lmaSI6dHJ1ZSwiR2VuZGVyVHlwZSI6IueUt-eJiCIsIiRhcHBfdmVyc2lvbiI6IjMuNi4zIiwiJG1hbnVmYWN0dXJlciI6IkFwcGxlIiwiJG5ldHdvcmtfdHlwZSI6IldJRkkiLCJhYnRlc3RfZ3JvdXAiOjcwLCJIb21lcGFnZVRhYk5hbWUiOiLng63pl6giLCJIb21lcGFnZVVwZGF0ZURhdGUiOjB9LCJwcm9qZWN0Ijoia3VhaWthbl9hcHAiLCJkaXN0aW5jdF9pZCI6Imk6M0Y0NDlEQjYtNTNGNS00OTNDLTlERTUtN0U3MUNGRDkzNkQ4IiwidGltZSI6MTQ4NDIwNDMyNjE5OCwidHlwZSI6InRyYWNrIn0%3D&since=0"
        if isLeft {
            url = "https://api.kkmh.com/v1/fav/timeline?sa_event=eyJldmVudCI6IlJlYWRIb21lUGFnZSIsInByb3BlcnRpZXMiOnsiVHJpZ2dlclBhZ2UiOiJIb21lUGFnZSIsIiRvc192ZXJzaW9uIjoiMTAuMiIsIkZyb21Ib21lcGFnZVVwZGF0ZURhdGUiOjAsIiRjYXJyaWVyIjoi5Lit5Zu956e75YqoIiwiJG9zIjoiaU9TIiwiJHNjcmVlbl9oZWlnaHQiOjEzMzQsIiRsaWIiOiJpT1MtbmV0IiwiJG1vZGVsIjoiaVBob25lIiwiJHNjcmVlbl93aWR0aCI6NzUwLCIkd2lmaSI6dHJ1ZSwiR2VuZGVyVHlwZSI6IueUt-eJiCIsIiRhcHBfdmVyc2lvbiI6IjMuNi4zIiwiJG1hbnVmYWN0dXJlciI6IkFwcGxlIiwiJG5ldHdvcmtfdHlwZSI6IldJRkkiLCJhYnRlc3RfZ3JvdXAiOjcwLCJIb21lcGFnZVRhYk5hbWUiOiLlhbPms6gifSwicHJvamVjdCI6Imt1YWlrYW5fYXBwIiwiZGlzdGluY3RfaWQiOiI0NjkzODUwIiwidGltZSI6MTQ4NDI4OTQzOTIzNywidHlwZSI6InRyYWNrIn0%3D&since=0"
        }
      
        NetworkTools.shardTools.requestL(method: .get, URLString:url , parameters: nil) { (response, error) in
            self.tableView?.mj_header.endRefreshing()
            MMUtils.hideLoading()
            
            if error == nil {
                guard let object = response as? [String: AnyObject] else {
                    print("格式错误")
                    return
                }
                let model = Model.init(dict: object)
                if model.code == 200 {
                    self.dataArray = model.data!.comics!
                    self.tableView.reloadData()
                }
                
            }else {
               
                MMUtils.hideLoading()
                MMUtils.showError()
            }
        }
    }
    func reloadUser() {
        if dataArray.count == 0 {
            backLoginView.removeFromSuperview()
            loadData()
        }else {
            dataArray.removeAll()
            tableView.reloadData()
         tableView.insertSubview(backLoginView, at: 0)
        }
    }
}
