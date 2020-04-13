//
//  ListViewController.swift
//  NewsReader
//
//  Created by 開発アカウント on 2020/04/09.
//  Copyright © 2020 開発アカウント. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    //表示するセルの数を3つにする
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    //表示するセルを作成する
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
}
