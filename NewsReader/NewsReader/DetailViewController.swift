//
//  DetailViewController.swift
//  NewsReader
//
//  Created by 開発アカウント on 2020/04/13.
//  Copyright © 2020 開発アカウント. All rights reserved.
//

import UIKit
import WebKit

//UIViewControllerクラスを継承したDetailViewControllerクラスを宣言
class DetailViewController : UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var link:String!
    
    override func viewDidLoad() {
        //viewDidLoad内に記述しているので、画面が表示される前に呼び出される
        super.viewDidLoad()
        //linkプロパティを引数にして、URLクラスのurlインスタンスを作成する
        if let url = URL(string: self.link) {
            //urlインスタンスを引数にして、URLRequestクラスのrequestインスタンスを作成する
            let request = URLRequest(url: url)
            //requestインスタンスを引数にして、webViewクラスのインスタンスを作成する
            self.webView.load(request)
        }
    }
}
