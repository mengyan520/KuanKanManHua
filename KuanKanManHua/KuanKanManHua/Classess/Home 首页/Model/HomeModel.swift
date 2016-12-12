//
//  HomeModel.swift
//  KuanKanManHua
//
//  Created by Youcai on 16/12/7.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

class HomeModel: NSObject {
    var message: String?
    var data: Data?
    var code: Int = 0
    init(dict:[String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
    }
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "data" {
            
            if let dict = value as? [String: AnyObject] {
                
                data = Data.init(dict: dict)
                
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
class Data: NSObject {
    var comics: [Comics]?
    var since: Int = 0
    var timestamp: Int = 0
    init(dict:[String:AnyObject]) {
        super.init()
        
        
        setValuesForKeys(dict)
        
    }
    override func setValue(_ value: Any?, forKey key: String) {
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
        
      return HomeTableViewCell.init(style: .default, reuseIdentifier: cellID).rowHeight(data: self)
    }()
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "topic" {
            
            if let dict = value as? [String: AnyObject] {
                
                topic = Topic.init(dict: dict)
                
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
class Topic: NSObject {
    var cover_image_url: String?
    var des: String?
    var id: Int = 0
    var created_at: Int = 0
    var discover_image_url: String?
    var label_id: Int = 0
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
