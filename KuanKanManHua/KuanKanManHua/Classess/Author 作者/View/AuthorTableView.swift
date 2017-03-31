//
//  AuthorTableView.swift
//  KuanKanManHua
//
//  Created by Youcai on 17/2/23.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit
private let ID = "AuthorCell"
private let leftID = "leftID"
protocol AuthorTableViewDel:NSObjectProtocol {
    func didSelectLeftRowAtIndex(ID:Int)
    func didSelectRithtRowAtIndex(data:Feeds)
    
}
class AuthorTableView: UITableView {
    var isleft = false
    var data:ModelData?
    lazy var leftArray = [Topics]()
    lazy var dataArray = [Feeds]()
    weak var del:AuthorTableViewDel?
    // MARK: - init
    init() {
        super.init(frame: CGRect.zero, style: .plain)
        backgroundColor = WHITE_COLOR
        dataSource = self
        delegate = self
        register(CommunityTableViewCell.self, forCellReuseIdentifier: ID)
        register(AuthorLeftCell.self, forCellReuseIdentifier: leftID)
        register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        estimatedRowHeight = 200
        
        separatorStyle = .none
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK: - 数据源/代理
extension AuthorTableView : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isleft {
            return leftArray.count + 3
        }
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isleft {
            if indexPath.row < 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                
                cell.selectionStyle = .none
                switch indexPath.row {
                case 0:
                    
                    cell.textLabel?.font = Font(fontSize: 17)
                    cell.textLabel?.text = "简介"
                    
                case 1:
                    cell.textLabel?.font = Font(fontSize: 12)
                    cell.textLabel?.numberOfLines = 0
                    if ((data?.intro) != nil) {
                        cell.textLabel?.text = data?.intro
                    }else {
                        cell.textLabel?.text = "作者辛苦赶稿，都没来得及填写资料哦"
                    }
                    
                case 2:
                    
                    cell.textLabel?.font = Font(fontSize: 17)
                    cell.textLabel?.text = "TA的作品"
                default:
                    break
                }
                
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: leftID, for: indexPath) as! AuthorLeftCell
            
            cell.selectionStyle = .none
            cell.data = leftArray[indexPath.row - 3]
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: ID, for: indexPath) as! CommunityTableViewCell
        cell.data = dataArray[indexPath.row]
        cell.selectionStyle = .none
        cell.isAuthor = true
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isleft {
            if indexPath.row < 3 {
                return
            }
            del?.didSelectLeftRowAtIndex(ID: leftArray[indexPath.row-3].id)
        }else {
            del?.didSelectRithtRowAtIndex(data: dataArray[indexPath.row])
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isleft {
            if indexPath.row < 3 {
                if indexPath.row == 1 && ((data?.intro) != nil){
                    return (NSString.init(string: (data?.intro)!)).ew_height(with: Font(fontSize: 12), lineWidth: SCREEN_WIDTH) + 20
                }
                return 44
            }
            return 130
        }
        return dataArray[indexPath.row].rowHeight
    }
    
}
