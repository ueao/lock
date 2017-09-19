//
//  ViewController.swift
//  lock
//
//  Created by Aoi Sakaue on 2017/09/12.
//  Copyright © 2017年 com.ueao. All rights reserved.
//

import UIKit
//ここでライブラリインストール
import SmileLock

class ViewController: UIViewController {

    // タイマー宣言
    var timer: Timer = Timer()
    var count: Int = 0
    
    @IBOutlet var timepicker: UIDatePicker!
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet var lockview: UIView!
    @IBOutlet var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lockview.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // SmileLock
    func smilelock(){
        // パスコードロック画面 ////////////////////////
        // パスコードの桁数
        lockview.isHidden = false
        let kPasswordDigit = 6
        // パスコード入力画面を表示
        let contentView = PasswordContainerView.createWithDigit(kPasswordDigit)
        
        var lockView = contentView
        
        if let window = view.window {
            let baseView = UIView(frame: window.bounds)
            baseView.addSubview(contentView)
            contentView.center = baseView.center
            window.addSubview(baseView)
        }
    }////////////////////////////////////////////////

    
    @IBAction func changeDate(sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH時間mm分だけ！"
        
        label.text = formatter.string(from: sender.date)
        
    }
    
    @IBAction func start(sender: UIButton) {
        count = Int(timepicker.countDownDuration)
        
//        if !timer.isValid {
            // タイマー処理
            timer = Timer.scheduledTimer(
                // メソッドを呼び出す間隔
                timeInterval: 1.0,
                // ターゲット
                target: self,
                //
                selector: #selector(self.countdown),
                
                userInfo: nil,
                // 繰り返し処理をするかどうか
                repeats: true)
//            timer.fire()
//        }
        button.isEnabled = false

    }
    
    func countdown(){
        count = count - 1
        // カウントダウン状況をラベルに表示する
        if count >= 0 {
            label.text = "あと\(count)秒だけ！"
            
        } else {
            label.text = ""
            timer.invalidate()
            // SmileLock呼び出す
            smilelock()
            button.isEnabled = true

        }
    }
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

