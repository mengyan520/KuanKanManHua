//
//  SQLiteManager.swift

//

//

import Foundation

/// 数据库名称 - 关于数据名称 readme.txt
private let dbName = "readme.db"

class SQLiteManager {
    
    /// 单例
    static let sharedManager = SQLiteManager()
    
    /// 全局数据库操作队列
    let queue: FMDatabaseQueue
    
    private init() {
        
        // 0. 数据库路径 - 全路径(可读可写)
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        
        path = (path as NSString).appendingPathComponent(dbName)
        
        print("数据库路径 " + path)
        
        // 1. 打开数据库队列
        // 如果数据库不存在，会建立数据库，然后，再创建队列并且打开数据库
        // 如果数据库存在，会直接创建队列并且打开数据库
        queue = FMDatabaseQueue(path: path)
        
        // createTable()
    }
    
    /// 执行 SQL 返回字典数组
    ///
    /// - parameter sql: SQL
    ///
    /// - returns: 字典数组
    func execRecordSet(sql: String) -> [[String: AnyObject]] {
        
        // 定义结果[字典数组]
        var result = [[String: AnyObject]]()
        
        // `同步`执行数据库查询 - FMDB 默认情况下，都是在主线程上执行的
        SQLiteManager.sharedManager.queue.inDatabase { (db) -> Void in
            
            
            
            guard let rs = try? db?.executeQuery(sql: sql) else {
                print("没有结果")
                
                return
            }
            
            while rs!.next() {
                // 1. 列数
                let colCount = rs!.columnCount()
                
                // 创建字典
                var dict = [String: AnyObject]()
                
                // 2. 遍历每一列
                for col in 0..<colCount {
                    // 1> 列名
                    let name = rs!.columnName(for: col)
                    // 2> 值
                    let obj = rs!.object(forColumnIndex: col)
                    
                    // 3> 设置字典
                    dict[name!] = obj as AnyObject?
                }
                // 将字典插入数组
                result.append(dict)
            }
        }
        
        // 返回结果
        return result
    }
    
    func createTable(name:String) {
        
        // 1. 准备 SQL(只读，创建应用程序时，准备的素材)
        let sql =  "CREATE TABLE IF NOT EXISTS \(name) (ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,topic_id integer,tid integer,title text,latest_comic_title text,old_comic_title text,cover_image_url text );"
        
        
        // 2. 执行 SQL
        queue.inDatabase { (db) -> Void in
            
            // 创建数据表的时候，最好选择 executeStatements，可以执行多个 SQL
            // 保证能够一次性创建所有的数据表！
            if (db?.executeStatements(sql))! {
                print("创表成功")
            } else {
                print("创表失败")
            }
        }
    }
    // MARK: - save
    //保存多条数据
    
func saveData(data: Info,name:String) {
        if ((checkData(name: name, topic_id: data.topic_id)?.count)! > 0) {
            deleteData(name: name, topic_id: data.topic_id)
        }
        let sql = "INSERT OR REPLACE INTO \(name) (topic_id ,tid ,title ,latest_comic_title ,old_comic_title ,cover_image_url) VALUES (?,  ?,  ?,  ?,  ?,  ?)"
        SQLiteManager.sharedManager.queue.inTransaction { (db, rollback) -> Void in
         
            let topic_id = data.topic_id
            let tid = data.id
            let title = data.title
            let latest_comic_title = data.latest_comic_title
            let old_comic_title = data.old_comic_title
            let cover_image_url = data.cover_image_url
            
            
            
            do {
                try db?.executeUpdate(sql: sql,topic_id as AnyObject,tid as AnyObject,title as AnyObject,latest_comic_title as AnyObject,old_comic_title as AnyObject ,cover_image_url as AnyObject )
            } catch {
                
                print("插入数据失败")
                return
            }
            
            
            
            
            
        }
        
        print("数据插入完成！")
    }
    // MARK: - check
    /// 目标：检查本地数据库中，是否存在需要的数据
    func checkAllData(name:String) -> [Info]? {
        
        let sql = "SELECT * FROM \(name) "
        
        // 2. 执行 SQL -> 返回结果集合
        let array = SQLiteManager.sharedManager.execRecordSet(sql: sql)
       // print(array)
        var arrayM = [Info]()
        for dict in array {
            let data = Info.init(dict:nil)
            data.topic_id = dict["topic_id"] as! Int
            data.id = dict["tid"] as! Int
            data.title = dict["title"] as! String?
            data.latest_comic_title = dict["latest_comic_title"] as! String?
            data.old_comic_title = dict["old_comic_title"] as! String?
            data.cover_image_url = dict["cover_image_url"] as! String?
            
            // 添加到数组
            arrayM.append(data )
        }
        
        arrayM =   arrayM.reversed()
        
        
        // 返回结果 － 如果没有查询到数据，会返回一个空的数组
        return arrayM
    }
    func checkData(name:String,topic_id:Int) -> [Info]? {
        
        let sql = "SELECT * FROM \(name) where topic_id = \(topic_id)"
        let array = SQLiteManager.sharedManager.execRecordSet(sql: sql)
        var arrayM = [Info]()
        for dict in array {
            let data = Info.init(dict:nil)
            data.topic_id = dict["topic_id"] as! Int
            data.id = dict["tid"] as! Int
            data.title = dict["title"] as! String?
            data.latest_comic_title = dict["latest_comic_title"] as! String?
            data.old_comic_title = dict["old_comic_title"] as! String?
            data.cover_image_url = dict["cover_image_url"] as! String?
            
            // 添加到数组
            arrayM.append(data )
        }
      
       
        return arrayM
    }
    // MARK: - update
    func updateData(name:String,topic_id:Int,latest_comic_title: String)  {
        let sql = "update \(name) set latest_comic_title = '\(latest_comic_title)' where topic_id = \(topic_id) "
        queue.inTransaction { (db, rollback) -> Void in
            
            
            
            do {
                try db?.executeUpdate(sql: sql)
            } catch {
                
                print("更新数据失败")
                return
            }
            
            
        }
    }
    // MARK: - delete
    func deleteData(name:String,topic_id:Int)  {
        
        let sql =  "delete  from \(name)  where topic_id = \(topic_id) "
        
        
        
        queue.inDatabase { (db) -> Void in
            
            
            if (db?.executeStatements(sql))! {
                print("删除成功")
            } else {
                print("删除失败")
            }
        }
        
    }

    func deleteTable(name:String)  {
        
        let sql =  "delete from \(name)"
        
        
        
        queue.inDatabase { (db) -> Void in
            
            
            if (db?.executeStatements(sql))! {
                print("删除成功")
            } else {
                print("删除失败")
            }
        }
        
    }
    // MARK: - path
    func getDBPath(name:String) -> String? {
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        
        path = (path as NSString).appendingPathComponent(name)
        return path
    }
}
