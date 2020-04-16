//
//  ListViewController.swift
//  NewsReader
//
//  Created by 開発アカウント on 2020/04/09.
//  Copyright © 2020 開発アカウント. All rights reserved.
//

import UIKit

//XMLPerserクラスのデリゲートになる為のXMLPerserDelegateを批准
class ListViewController: UITableViewController, XMLParserDelegate {
    
    //RSSデータ解析の為のXMLPerserクラスのインスタンス格納の為のparserプロパティ
    var parser:XMLParser!
    //複数の記事を格納する為の配列を用意（Itemクラス作成）
    var items = [Item]()
    //Itemクラスのプロパティを作成
    var item:Item?
    //RSSデータ解析で抽出した文字列を一時的に格納する為のcurrentStringプロパティ
    var currentString = ""
    
    //配列itemsの数だけセルを作成？
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView,
                            //セルの内容をiPhoneに伝えるcellForRowAtメソッド
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                                                    //indexPathの数だけセルの内容を設定
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startDownload()
    }
    
    //RSSデータをDLする為のstartDownloadメソッド
    func startDownload() {
        //記事が重複しない様に配列「items」を一度クリアする
        self.items = []
        //Webサイト「WIRED」のRSSフィードのURLを指定
        if let url = URL(
            string: "https://wired.jp/rssfeeder/"){
            //XMLPerserのインスタンスを作成。引数にはWIREDのURLを指定。
            if let parser = XMLParser(contentsOf: url) {
                self.parser = parser
                //parserのデリゲートにListViewControllerを指定
                self.parser.delegate = self
                //parse()メソッドを呼び出し、データ解析を開始
                self.parser.parse()
            }
        }
    }
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String]) {
        //一時的に要素を保存する為の変数currentStringを空にする
        self.currentString = ""
        //RSSデータの要素名を文字列「item」と比較し、要素名がitemのデータのみを取得
        if elementName == "item" {
            self.item = Item()
        }
    }
    //内容を取り出す為のparserメソッド
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //変数currentStringに要素の内容を追加
        self.currentString += string
    }
    
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        
        //要素を各プロパティに格納
        switch elementName {
        case "title": self.item?.title = currentString
        case "link": self.item?.link = currentString
        case "item": self.items.append(self.item!)
        default : break
        }
    }
    
    //テーブルビューの内容を更新し、取得したニュース記事を画面に表示
    func parserDidEndDocument(_ parser: XMLParser) {
        //reloadDataメソッドを実行する事で24,30行目のメソッドが再実行され、データが表示される
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //ユーザーがタップしたセルのindexPathを取得
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let item = items[indexPath.row]
            //定数controllerには、遷移先のビューコントローラーが格納されている
            let controller = segue.destination as! DetailViewController
            //遷移先の(DetailViewController)のtitleプロパティに記事のタイトルを格納
            controller.title = item.title
            //DetailViewControllerのlinkプロパティに記事のURLを格納
            controller.link = item.link
        }
    }
}

