//
//  WordDetailTableView.swift
//  KuanKanManHua
//
//  Created by Youcai on 16/12/28.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit
private let RightID = "RightCell"
private let LeftID = "LeftCell"
protocol WordDetailTableViewDel:NSObjectProtocol {
    func didSelectRowAtIndex(ID:Int,name:String)
    
    
}

class WordDetailTableView: UITableView {
    lazy var rightArray = [Comics]()
    var data:ModelData?
    var isleft = true
    // MARK: - init
    init() {
        super.init(frame: CGRect.zero, style: .grouped)
        backgroundColor = WHITE_COLOR
        dataSource = self
        delegate = self
        register(RightCell.self, forCellReuseIdentifier: RightID)
        register(LeftCell.self, forCellReuseIdentifier: LeftID)
        estimatedRowHeight = 200
        register(wordRightSectionView.self, forHeaderFooterViewReuseIdentifier: "RightHeader")
        register(wordLeftSectionView.self, forHeaderFooterViewReuseIdentifier: "LeftHeader")
        separatorStyle = .none
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    weak var  del:WordDetailTableViewDel?
    
}

//MARK: - 数据源/代理
extension WordDetailTableView : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isleft {
            return 1
        }
        return rightArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isleft {
            let cell = tableView.dequeueReusableCell(withIdentifier: LeftID, for: indexPath) as! LeftCell
            
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RightID, for: indexPath) as! RightCell
        cell.data = rightArray[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isleft {
            return 20
        }
        return rightArray[indexPath.row].rowHeight
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isleft {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "LeftHeader") as! wordLeftSectionView
            view.data = data
            
            return view
        }
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RightHeader") as! wordRightSectionView
        view.data = data
        
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //SQLiteManager.sharedManager.saveData(data:rightArray[indexPath.row].topic!, name: "history")
        del?.didSelectRowAtIndex(ID: rightArray[indexPath.row].id,name:rightArray[indexPath.row].title! )
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isleft {
            
            return  200
        }
        return 44
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}
