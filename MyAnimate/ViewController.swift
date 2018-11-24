//
//  ViewController.swift
//  MyAnimate
//
//  Created by student on 2018/11/24.
//  Copyright © 2018年 2016110305. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TestView: UIView!
    @IBOutlet weak var MyView: UIView!
    //移动
    @IBAction func MyMove(_ sender: Any) {
        UIView.animate(withDuration: 2, animations: {
            self.MyView.center.x += 200.0
        },completion: { _ in
            UIView.animate(withDuration: 1, animations: {
                self.MyView.center.x -= 200.0
            }, completion:nil)
        })
    }
    //放大及缩小
    @IBAction func MyScale(_ sender: Any) {
        UIView.animate(withDuration: 2, animations: {
            self.MyView.bounds.size = CGSize(width: 200, height: 200)
        },completion: { _ in
            UIView.animate(withDuration: 2, animations: {
                self.MyView.bounds.size = CGSize(width: 50, height: 50)
            }, completion:{
                _ in self.MyView.bounds.size = CGSize(width: 113 , height: 108)
            }
            )
        })
    }
    //旋转
    @IBAction func MyTrans(_ sender: Any) {
         UIView.animate(withDuration: 1) {
            //旋转时放大倍数
            var trans = CGAffineTransform(scaleX: 1, y: 1)
            //旋转时的角度(180度)
            trans = trans.rotated(by: CGFloat(Double.pi))
            //旋转的an affine transformation matrix
            trans = trans.translatedBy(x: 300, y: 300)
            self.MyView.transform = trans
        }
        //另外180度旋转回来
        UIView.animate(withDuration: 4, delay: 0, options: .curveEaseInOut, animations: {
            self.MyView.transform =  CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }, completion: { _ in
            self.MyView.transform =  CGAffineTransform(rotationAngle: CGFloat(0))

        })
    }
    //视图间的切换
    @IBAction func MyTransition(_ sender: Any) {
        //增加的子视图
        let theView = UIView(frame: MyView.bounds)
        theView.backgroundColor = UIColor.green
        UIView.transition(with: MyView, duration: 2, options: .transitionFlipFromLeft, animations: {
            self.MyView.addSubview(theView)
        }, completion: {
            //切换回来
            _ in  UIView.transition(with: self.MyView, duration: 2, options: .transitionFlipFromRight, animations: {
                //移除子视图
                theView.removeFromSuperview()
            }, completion: nil)
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }


}

