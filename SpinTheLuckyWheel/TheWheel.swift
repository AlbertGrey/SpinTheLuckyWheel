//
//  DrawTheWheel.swift
//  SpinTheLuckyWheel
//
//  Created by TheGrey on 2020/2/19.
//  Copyright © 2020 thegrey. All rights reserved.
//

import UIKit

class TheWheel: UIView {


    override func draw(_ rect: CGRect) {
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let aDegree = Double.pi / 180
        let radius:Double = 125
        var num = 4
        var startDegree:Double = 270
        var percentOfNum:Double = Double(100 / num)
        print("percentOfNum=\(percentOfNum)")
        var x = 0
        for _ in 0..<num{
            x += 1
            let endDegree = startDegree + Double(360 * 1 / num)
            print("end=\(endDegree)")
            let path = UIBezierPath()
            path.move(to: CGPoint(x: center.x, y: center.y))
            path.addArc(withCenter: center, radius: CGFloat(radius), startAngle: CGFloat(startDegree * aDegree), endAngle: CGFloat(endDegree * aDegree), clockwise: true)
            let pathLayer = CAShapeLayer()
            pathLayer.path = path.cgPath
            pathLayer.fillColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1).cgColor
            self.layer.addSublayer(pathLayer)
            startDegree = endDegree
        }
        
        
//        let path = UIBezierPath()
//        //sin(𝛳) = y / r => y = r * sin(𝛳)
//        //cos(𝛳) = x / r => x = r * cos(𝛳)
//        let radius:Double = 125//半徑
//        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
//
//        path.move(to: CGPoint(x: center.x + CGFloat(radius), y: center.y)) //畫圖起始點在整張圖的中心點相Ｘ方向移動一個半徑長
//        for i in stride(from: 0, to: 361.0, by: 5){
//            //radians = degrees * pi /180 （ 弧度 ＝ 角度 ＊ pi / 180）
//            let radians = i * Double.pi / 180
//            let x = Double(center.x) + radius * cos(radians)
//            let y = Double(center.y) + radius * sin(radians)
//            path.addLine(to: CGPoint(x: x, y: y))
//        }
//        UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).setStroke()
//        path.lineWidth = 1 //線寬
//        path.stroke()
//
//        let pie = 360.0 / 8.0
//        // print("pie=\(pie)")
//        for j in stride(from: 0, to: 361.0, by: pie){
//            path.move(to: CGPoint(x: center.x , y: center.y))
//            //print("j=\(j)")
//            let radians = j * Double.pi / 180
//            let x = Double(center.x) + radius * cos(radians)
//            let y = Double(center.y) + radius * sin(radians)
//            path.addLine(to: CGPoint(x: x, y: y))
//
//        }
//        path.stroke()
    }
}
