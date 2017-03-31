//
//  CategoryTableView.swift
//  KuanKanManHua
//
//  Created by Youcai on 16/12/16.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit
import MJRefresh
private let ID = "cell"
protocol CategoryTableViewDel:NSObjectProtocol {
    func didSelectRowAtIndex(ID:Int)
    
    
}
class CategoryTableView: UITableView {
    weak var del :CategoryTableViewDel?
    var dataArray = [Topics]()
     // MARK: - init
    init() {
    super.init(frame: CGRect.zero, style: .plain)
        backgroundColor = WHITE_COLOR
        dataSource = self
        delegate = self
        register(CategoryCell.self, forCellReuseIdentifier: ID)
        estimatedRowHeight = 200
       
       separatorStyle = .none
    
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - 数据源/代理
extension CategoryTableView : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID, for: indexPath) as! CategoryCell
        cell.data = dataArray[indexPath.row]
          cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        del?.didSelectRowAtIndex(ID: dataArray[indexPath.row].id)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataArray[indexPath.row].rowHeight
    }
}
