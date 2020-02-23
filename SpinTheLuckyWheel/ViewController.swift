//
//  ViewController.swift
//  SpinTheLuckyWheel
//
//  Created by TheGrey on 2020/2/19.
//  Copyright © 2020 thegrey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var numOfOption = 0
    //spin
    var currentValue:Double = 0
    var optionsArray = [Any?]()
    var degreeArray = [Double]()
    //spin-e
    
    @IBOutlet weak var theWheel: TheWheel!
    @IBOutlet weak var showTheOption: UILabel!
    @IBAction func numbers(_ sender: UIButton) {
        let number = sender.tag
        showTheOption.text = String(number)
//        print("number=\(number)")
        numOfOption = number
    }
    
    @IBAction func goToWheelPage(_ sender: UIButton) {
        
    }
    
    
    @IBAction func spinTheWheel(_ sender: UIButton) {
        sender.isEnabled = false
        rotateGradually(handler: {
            (result) in
//            print("result=\(result)")
            let alert = UIAlertController(title: "你選到了\(result)", message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: {
                (result) in
                sender.isEnabled = true
//                if self.currentValue > 2500{
//                    self.currentValue = 0
//                }
            })
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion:nil)
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        optionsArray = ["1","2","3","4"]
        UserDefaults.standard.register(defaults: ["optionslist":optionsArray])
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        print("WillAppear")
        reloadOption()
    }
    
    var tempdegree = 0.0
    func reloadOption() {
        if let opArray = UserDefaults.standard.array(forKey: "optionslist"){
            optionsArray = opArray
            for _ in 0...optionsArray.count{
                let degreeOfPiece = 360.0 / Double(optionsArray.count)
                let gapOfDegree = (degreeOfPiece * 100.0).rounded() / 100.0
                
                degreeArray.append(tempdegree)
                tempdegree += gapOfDegree
            }
        }

    }


    func rotateGradually(handler: @escaping (String)->()){
        var result = ""
        let randomDouble = Double.random(in: 0..<2*Double.pi)//0~2pi,確認會多轉幾度
//        print("viewC:randomDouble=\(randomDouble)")
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        CATransaction.begin()
        animation.fromValue = currentValue
        currentValue = currentValue + 100 * Double.pi + randomDouble
//        print("viewC:currentValue=\(currentValue)")
        let value = currentValue.truncatingRemainder(dividingBy: Double.pi * 2)
    //       print("轉的圈數除以2pi求於數=\(value)")
        let degree = value * 180/Double.pi // 以弧度的角度，把弧度乘以 180/pi 轉為角度
//        print("viewC:degree=\(degree)")
//        print("viewC:degreeArray=\(degreeArray)")
        print("optionArray=\(optionsArray)")
        for i in 0..<degreeArray.count{
            if degree >= degreeArray[i] && degree < degreeArray[i + 1]{
                print("viewC:degreeArray[i] = \(degreeArray[i]) and \(degreeArray[i + 1])")
                let x = optionsArray.count - i
                let opName = optionsArray[x - 1]
                print("x===\(x), i== \(i)")
                result = opName as! String
                break
            }
        }
        
        
//        switch degree { // 依照不同角度判斷轉到的區塊,指標指向正上方,所以想像正上方為0度，且順時針旋轉所以圖片要逆時針看
//            case 0..<45:
//                result = "淺藍色"
//            case 45..<90:
//                result = "橘色"
//            case 90..<135:
//                result = "黃色"
//            case 135..<180:
//                result = "紫色"
//            case 180..<225:
//                result = "深藍色"
//            case 225..<270:
//                result = "紅色"
//            case 270..<315:
//                result = "黃色"
//            case 315..<360:
//                result = "綠色"
//            default:
//                result = "彩色(?)"
//            }
        animation.toValue = currentValue
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.duration = 3 //動畫時間
        //animation.autoreverses = true //迴轉
        animation.repeatCount = 1
        CATransaction.setCompletionBlock({
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute:{
                handler(result)
            })
        })
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0, 0.9, 0.4, 1.00) //
        theWheel.layer.add(animation, forKey: nil)
        CATransaction.commit()
    }
    

}

