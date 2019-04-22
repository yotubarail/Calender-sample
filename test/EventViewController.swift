//
//  EventViewController.swift
//  test
//
//  Created by 滝浪翔太 on 2019/04/08.
//  Copyright © 2019 滝浪翔太. All rights reserved.
//

import UIKit
import RealmSwift
// ディスプレイサイズ取得
let w2 = UIScreen.main.bounds.size.width
let h2 = UIScreen.main.bounds.size.height
// スケジュール内容入力テキスト
let eventText = UITextView(frame: CGRect(x: (w2-300)/2, y: 30, width: 300, height: 200))

// 日付フォーム
let y = UIDatePicker(frame: CGRect(x: 0, y: 200, width: w2, height: 300))

// 日付表示
let y_text = UILabel(frame: CGRect(x: (w2-300)/2, y: 470, width: 300, height: 20))

class EventViewController: UIViewController {
    
    var date: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // スケジュール内容入力テキスト設定
        eventText.text = ""
        eventText.layer.borderColor = UIColor.gray.cgColor
        eventText.layer.borderWidth = 1.0
        eventText.layer.cornerRadius = 10.0
        view.addSubview(eventText)
        
        // 日付フォーム設定
        y.datePickerMode = UIDatePicker.Mode.date
        y.timeZone = NSTimeZone.local
        y.addTarget(self, action: #selector(picker(_:)), for: .valueChanged)
        view.addSubview(y)
        
        // 日付表示設定
        y_text.backgroundColor = .white
        y_text.textAlignment = .center
        view.addSubview(y_text)
        
        
        
        // 「追加」ボタン
        let eventInsert = UIButton(frame: CGRect(x: (w2-200)/2, y: h2-180, width: 200, height: 50))
        eventInsert.setTitle("追加", for: UIControl.State())
        eventInsert.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        eventInsert.setTitleColor(.orange, for: UIControl.State())
        eventInsert.backgroundColor = .cyan
        eventInsert.addTarget(self, action: #selector(saveEvent(_:)), for: .touchUpInside)
        view.addSubview(eventInsert)
        
        // 「戻る」ボタン
        let backBtn = UIButton(frame: CGRect(x: (w2-200) / 2, y: h2-50, width: 200, height: 30))
        backBtn.setTitle("戻る", for: UIControl.State())
        backBtn.setTitleColor(.orange, for: UIControl.State())
        backBtn.backgroundColor = .white
        backBtn.layer.cornerRadius = 10.0
        backBtn.layer.borderColor = UIColor.cyan.cgColor
        backBtn.layer.borderWidth = 1.0
        backBtn.addTarget(self, action: #selector(onbackClick(_:)), for: .touchUpInside)
        view.addSubview(backBtn)
        
        
        
        // スケジュール削除ボタン
        let delBtn = UIButton(frame: CGRect(x: (w2-200)/2, y: h2-110, width: 200, height: 50))
        delBtn.setTitle("削除", for: UIControl.State())
        delBtn.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        delBtn.setTitleColor(.white, for: UIControl.State())
        delBtn.backgroundColor = .red
      
        delBtn.addTarget(self, action: #selector(click2(_:)), for: .touchUpInside)
        view.addSubview(delBtn)
        
    }
    
    // 画面遷移
    @objc func onbackClick(_: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // 日付フォーム
    @objc func picker(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyy/MM/dd"
        y_text.text = formatter.string(from: sender.date)
        view.addSubview(y_text)
    }
    
    
    
    // DB書き込み処理
    @objc func saveEvent(_: UIButton) {
        print("データ書き込み開始")
        
        let realm = try! Realm()
        
        try! realm.write {
            
            let Events = [Event(value: ["date": y_text.text, "event": eventText.text])]
            realm.add(Events)
            print("データ書き込み中")
        }
        
        
    print("データ書き込み完了")
        
        // 前のページに戻る
        dismiss(animated: true, completion: nil)

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    @objc func click2(_: UIButton) {
        do {
            let realm = try! Realm()
            let data = realm.objects(Event.self).last!
            try realm.write {
                realm.delete(data)
            }
        } catch {
            
        }
        
 
            
        
        
    }
    
    
    
}
