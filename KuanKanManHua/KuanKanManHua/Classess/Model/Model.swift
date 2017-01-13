//
//  Model.swift
//  KuanKanManHua
//
//  Created by Youcai on 16/12/14.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

class Model: NSObject {
    var message: String?
    var data: ModelData?
    var code: Int = 0
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "data" {
            
            if let dict = value as? [String: AnyObject] {
                
                data = ModelData.init(dict: dict)
                
            }
            return
            
        }
        
        
        
        super.setValue(value, forKey: key)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["data"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
}
class ModelData: NSObject {
    //登录
    
    var alter_nickname: Int = 0
    var avatar_url: String?
    var youzan_user_id: String?
    var follower_cnt: Int = 0
  
    var reply_remind_flag: Int = 0
    var update_remind_flag: Int = 0
    var reg_type: String?
    var raw_nickname: String?
    var nickname: String?
    var grade: Int = 0
    var msg_nickname: String?
    var u_intro: String?
    //历史
    var info:     [Info]?
    //漫画详情
    var comments: [Comments]?
    var image_infos: [Image_infos]?
    var next_comic_id: Int = 0
    var status: String?
    
    var url: String?
    var topic: Topic?
    var push_flag: Int = 0
    
    var previous_comic_id: Int = 0
    var banner_info: Banner_info?
    var images: [String]?
    
    var is_liked: Bool = false
    var recommend_count: Int = 0
    
    
    
    var serial_no: Int = 0
    var storyboard_cnt: Int = 0
    
    
    //作品简介
    var des: String?
    var title: String?
    var update_status: String?
    var update_day: String?
    var updated_at: Int = 0
    var vertical_image_url: String?
    var label_id: Int = 0
    var comments_count: Int = 0
    var sort: Int = 0
    var category: [String]?
    var id: Int = 0
    var user: User?
    var discover_image_url: String?
    var comics_count: Int = 0
    var label: Label?
    
    var is_favourite: Bool = false
    var likes_count: Int = 0
    var view_count: Int = 0
    var fav_count: Int = 0
    var created_at: Int = 0
    var order: Int = 0
    var cover_image_url: String?
    //社区
    var current: Int = 0
    
    var feeds: [Feeds]?
    var pub_feed: Int = 0
    //发现.推荐
    var infos: [Infos]?
    //发现.分类
    var tags: [Tags]?
    var topics: [Topics]?
    //首页
    var comics: [Comics]?
    var since: Int = 0
    var timestamp: Int = 0
    init(dict:[String:AnyObject]) {
        super.init()
        
        
        setValuesForKeys(dict)
        
    }
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "info" {
            var arr = [Info]()
            for data in value as! [AnyObject] {
                arr.append(Info.init(dict: (data as? [String : AnyObject])!))
                
            }
            info = arr
            return
        }
        if key == "comments" {
            var arr = [Comments]()
            for data in value as! [AnyObject] {
                arr.append(Comments.init(dict: (data as? [String : AnyObject])!))
                
            }
            comments = arr
            return
        }
        if key == "next_comic_id" {
            if let dict = value as? Int {
                
                next_comic_id = dict
                
            }
            return
        }
        if key == "previous_comic_id" {
            if let dict = value as? Int {
                
                previous_comic_id = dict
                
            }
            return
        }
        if key == "banner_info" {
            
            if let dict = value as? [String: AnyObject] {
                
                banner_info = Banner_info.init(dict: dict)
                
            }
            return
            
        }
        if key == "image_infos" {
            var arr = [Image_infos]()
            for data in value as! [AnyObject] {
                arr.append(Image_infos.init(dict: (data as? [String : AnyObject])!))
                
            }
            image_infos = arr
            return
        }
        if key == "topic" {
            
            if let dict = value as? [String: AnyObject] {
                
                topic = Topic.init(dict: dict)
                
            }
            return
            
        }
        if key == "storyboard_cnt" {
            if let dict = value as? Int {
                
                storyboard_cnt = dict
                
            }
            return
        }
        
        if key == "label" {
            
            if let dict = value as? [String: AnyObject] {
                
                label = Label.init(dict: dict)
                
            }
            return
            
        }
        if key == "user" {
            
            if let dict = value as? [String: AnyObject] {
                
                user = User.init(dict: dict)
                
            }
            return
            
        }
        if key == "description" {
            
            if let dict = value as? String {
                
                des = dict
                
            }
            return
            
        }
        if key == "feeds" {
            var arr = [Feeds]()
            for data in value as! [AnyObject] {
                arr.append(Feeds.init(dict: (data as? [String : AnyObject])!))
                
            }
            feeds = arr
            return
        }
        if key == "tags" {
            var arr = [Tags]()
            for data in value as! [AnyObject] {
                arr.append(Tags.init(dict: (data as? [String : AnyObject])!))
                
            }
            tags = arr
            return
        }
        if key == "topics" {
            var arr = [Topics]()
            for data in value as! [AnyObject] {
                arr.append(Topics.init(dict: (data as? [String : AnyObject])!))
                
            }
            topics = arr
            return
        }
        if key == "infos" {
            var arr = [Infos]()
            for data in value as! [AnyObject] {
                arr.append(Infos.init(dict: (data as? [String : AnyObject])!))
                
            }
            infos = arr
            return
        }
        if key == "comics" {
            var arr = [Comics]()
            for data in value as! [AnyObject] {
                arr.append(Comics.init(dict: (data as? [String : AnyObject])!))
                
            }
            comics = arr
            return
        }
        
        super.setValue(value, forKey: key)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["comics"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
    
}
class Comics: NSObject {
    var topic_id: Int = 0
    var cover_image_url: String?
    var id: Int = 0
    var status: String?
    var is_liked: Bool = false
    var label_color: String?
    var created_at: Int = 0
    var push_flag: Int = 0
    var storyboard_cnt: Int = 0
    var url: String?
    var label_text: String?
    var title: String?
    var topic: Topic?
    var updated_at: Int = 0
    var info_type: Int = 0
    var serial_no: Int = 0
    var likes_count: Int = 0
    var comments_count: Int = 0
    var shared_count: Int = 0
    var label_text_color: String?
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    lazy var rowHeight:CGFloat = {
        if self.topic_id > 0 {
            return RightCell.init(style: .default, reuseIdentifier: "RightCell").rowHeight(data: self)
        }
        return HomeTableViewCell.init(style: .default, reuseIdentifier: cellID).rowHeight(data: self)
    }()
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "topic" {
            
            if let dict = value as? [String: AnyObject] {
                
                topic = Topic.init(dict: dict)
                
            }
            return
            
        }
        if key == "storyboard_cnt" {
            if let dict = value as? Int {
                
                storyboard_cnt = dict
                
            }
            return
        }
        
        
        super.setValue(value, forKey: key)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["url"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
}
class Topic: NSObject,NSCoding {
    
    
    var related_authors: [Related_authors]!
    var is_favourite: Bool = false
    var update_day: String?
    
    var update_status: String?
    
    var cover_image_url: String?
    var des: String?
    var id: Int = 0
    var created_at: Int = 0
    var discover_image_url: String?
    var label_id:Int = 0
    var title: String?
    var order: Int = 0
    var updated_at: Int = 0
    var vertical_image_url: String?
    var user: User?
    var comics_count: Int = 0
    
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        
        cover_image_url = aDecoder.decodeObject(forKey: "cover_image_url") as! String?
        id = Int(aDecoder.decodeCInt(forKey: "id"))
        
        
        
        
        des = aDecoder.decodeObject(forKey: "des") as! String?
        title = aDecoder.decodeObject(forKey: "title") as! String?
        
    }
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(cover_image_url, forKey: "cover_image_url")
        aCoder.encode(id, forKey: "id")
        
        
        
        aCoder.encode(des, forKey: "des")
        aCoder.encode(title, forKey: "title")
        
    }
//    lazy var rowHeight:CGFloat = {
//        
//        return HistoryTableViewCell.init(style: .default, reuseIdentifier: "cell").rowHeight(data: self)
//    }()
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "related_authors" {
            var arr = [Related_authors]()
            for data in value as! [AnyObject] {
                arr.append(Related_authors.init(dict: (data as? [String : AnyObject])!))
                
            }
            related_authors = arr
            return
        }
        if key == "user" {
            
            if let dict = value as? [String: AnyObject] {
                
                user = User.init(dict: dict)
                
            }
            return
            
        }
        if key == "description" {
            
            if let dict = value as? String {
                
                des = dict
                
            }
            return
            
        }
        
        
        super.setValue(value, forKey: key)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["title"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
}
class User: NSObject {
    var reg_type: String?
    var id: Int = 0
    var avatar_url: String?
    var grade: Int = 0
    var nickname: String?
    var pub_feed: Int = 0
    
    
    
    
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    override func setValue(_ value: Any?, forKey key: String) {
        
        super.setValue(value, forKey: key)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["nickname"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
}
// MARK: - 发现.推荐
class Infos: NSObject {
    var item_type: Int = 0
    var more_flag: Bool = false
    var topics: [Topics]?
    var guide_text: String!
    var action: String?
    var style: Int = 0
    var title: String?
    var action_type: Int = 0
    var banners:[Banners]?
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "topics" {
            var arr = [Topics]()
            for data in value as! [AnyObject] {
                arr.append(Topics.init(dict: (data as? [String : AnyObject])!))
                
            }
            topics = arr
            return
        }
        
        if key == "banners" {
            var arr = [Banners]()
            for data in value as! [AnyObject] {
                arr.append(Banners.init(dict: (data as? [String : AnyObject])!))
                
            }
            banners = arr
            return
        }
        
        
        super.setValue(value, forKey: key)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["title"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
}
class Banners: NSObject {
    var target_app_url: String?
    var special_list_url: String?
    var good_price: String?
    var target_id: Int = 0
    var sub_title: String?
    var type: Int = 0
    var pic: String?
    var target_package_name: String?
    var target_web_url: String?
    var target_title: String?
    var id: Int = 0
    var request_id: String?
    var good_alias:  String?
    var chapter_count = 0
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        
        
        
        super.setValue(value, forKey: key)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["pic"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
}
class Topics: NSObject {
    var des: String?
    var category: [String]?
    var label_color: String?
    var label_id: Int = 0
    var pic: String?
    var type: Int = 0
    var title: String?
    var target_id: Int = 0
    var recommended_text: String?
    var label_text: String?
    var likes_count: Int = 0
    var comments_count: Int = 0
    var user: User?
    var label_text_color: String?
    
    //发现.分类
    var cover_image_url: String?
    var id: Int = 0
    var is_favourite: Bool = false
    var comics_count: Int = 0
    var created_at: Int = 0
    var discover_image_url: String?
    var user_id: Int = 0
    var order: Int = 0
    var updated_at: Int = 0
    var vertical_image_url: String?
    var update_day: String?
    var update_status: String?
    
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    lazy var rowHeight:CGFloat = {
        
        return CategoryCell.init(style: .default, reuseIdentifier: "cell").rowHeight(data: self)
    }()
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "user" {
            
            if let dict = value as? [String: AnyObject] {
                
                user = User.init(dict: dict)
                
            }
            return
            
        }
        if key == "description" {
            
            if let dict = value as? String {
                
                des = dict
                
            }
            return
            
        }
        
        
        super.setValue(value, forKey: key)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["des"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
}
class Tags: NSObject {
    var title: String?
    var tag_id: Int = 0
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        
        super.setValue(value, forKey: key)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["title"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
}
// MARK: - Feeds
class Feeds: NSObject {
    var user: User?
    var content: Content?
    var is_liked: Bool = false
    var created_at: Int = 0
    var feed_id: Int = 0
    var updated_at: Int = 0
    var share_url: String?
    var following: Bool = false
    var likes_count: Int = 0
    var comments_count: Int = 0
    var shared_count: Int = 0
    var feed_type: Int = 0
    lazy var rowHeight:CGFloat = {
        
        return CommunityTableViewCell.init(style: .default, reuseIdentifier: "cell").rowHeight(data: self)
    }()
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "user" {
            
            if let dict = value as? [String: AnyObject] {
                
                user = User.init(dict: dict)
                
            }
            return
            
        }
        if key == "content" {
            
            if let dict = value as? [String: AnyObject] {
                
                content = Content.init(dict: dict)
                
            }
            return
            
        }
        super.setValue(value, forKey: key)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["content"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
}
class Content: NSObject {
    var identity: String?
    var image_base: String?
    var images: [String]?
    var text: String?
    
    
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        
        super.setValue(value, forKey: key)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["text"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
}
// MARK: - Label
class Label: NSObject {
    
    var bg_color: String?
    var id: Int = 0
    var text_color: String?
    var text: String?
    
    
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        
        super.setValue(value, forKey: key)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["text"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
}
// MARK: - Image_infos
class Image_infos: NSObject {
    
    var width: Int = 0
    var height: Int = 0
    
    
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        
        super.setValue(value, forKey: key)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["width"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
}
// MARK: - Related_authors
class Related_authors: NSObject {
    
    var reg_type: String?
    var id: Int = 0
    var avatar_url: String?
    var grade: Int = 0
    var nickname: String?
    var pub_feed: Int = 0
    
    
    
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        
        super.setValue(value, forKey: key)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["nickname"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
}
// MARK: - Banner_info
class Banner_info: NSObject {
    
    
    var type: Int = 0
    
    
    
    
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        
        super.setValue(value, forKey: key)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["type"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
}
// MARK: - comments
class Comments: NSObject {
    
    
    var comic_id: Int = 0
    var replied_comment_id: Int = 0
    var likes_count: Int = 0
    var id: Int = 0
    var target_type: Int = 0
    var created_at: Int = 0
    var content: String?
    var replied_user_id: Int = 0
    var comment_type: Int = 0
    var is_liked: Bool = false
    var user: User?
    
    
    lazy var rowHeight:CGFloat = {
        
        return CommentCell.init(style: .default, reuseIdentifier: "CommentCell").rowHeight(data: self)
    }()
    
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "user" {
            
            if let dict = value as? [String: AnyObject] {
                
                user = User.init(dict: dict)
                
            }
            return
            
        }
        super.setValue(value, forKey: key)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["content"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
}
// MARK: - hsitory ,NSCoding
class Info: NSObject {
    var cover_image_url: String?
    var topic_id: Int = 0
    var latest_comic_title: String?
    var title: String?
    var old_comic_title: String?
    var id: Int = 0
     init(dict:[String: AnyObject]?) {
        super.init()
        if dict != nil {
             setValuesForKeys(dict!)
        }
        
    
    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init()
//        
//        
//        cover_image_url = aDecoder.decodeObject(forKey: "cover_image_url") as! String?
//        id = Int(aDecoder.decodeCInt(forKey: "id"))
//        
//          topic_id = Int(aDecoder.decodeCInt(forKey: "topic_id"))
//        old_comic_title = aDecoder.decodeObject(forKey: "old_comic_title") as! String?
//        
//        latest_comic_title = aDecoder.decodeObject(forKey: "latest_comic_title") as! String?
//        title = aDecoder.decodeObject(forKey: "title") as! String?
//        
//    }
//    func encode(with aCoder: NSCoder) {
//        
//        aCoder.encode(cover_image_url, forKey: "cover_image_url")
//        aCoder.encode(id, forKey: "id")
//        aCoder.encode(topic_id, forKey: "topic_id")
//
//        aCoder.encode(latest_comic_title, forKey: "latest_comic_title")
//        
//        aCoder.encode(old_comic_title, forKey: "old_comic_title")
//        aCoder.encode(title, forKey: "title")
//        
//    }
    override func setValue(_ value: Any?, forKey key: String) {
        
        
        super.setValue(value, forKey: key)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["topic_id"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
    
    
}
