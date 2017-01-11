//
//  CommunityTableView.swift
//  KuanKanManHua
//
//  Created by Youcai on 16/12/26.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit
private let ID = "cell"
protocol CommunityTableViewDel:NSObjectProtocol {
    
    func didSelectRowAtIndex(data:Feeds)
}
class CommunityTableView: UITableView {
     weak var del: CommunityTableViewDel?
     var dataArray = [Feeds]()
    // MARK: - init
    init() {
        super.init(frame: CGRect.zero, style: .plain)
        backgroundColor = WHITE_COLOR
        dataSource = self
        delegate = self
        register(CommunityTableViewCell.self, forCellReuseIdentifier: ID)
        estimatedRowHeight = 200
        
        separatorStyle = .none
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
//MARK: - 数据源/代理
extension CommunityTableView : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID, for: indexPath) as! CommunityTableViewCell
        cell.data = dataArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataArray[indexPath.row].rowHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        del?.didSelectRowAtIndex(data: dataArray[indexPath.row])
    }
}
