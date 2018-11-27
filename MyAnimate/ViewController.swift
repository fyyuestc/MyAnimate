//
//  ViewController.swift
//  MyAnimate
//
//  Created by student on 2018/11/24.
//  Copyright © 2018年 2016110305. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //增加一个view,与buttons分离
    @IBOutlet weak var backView: UIView!
   
    @IBOutlet weak var MyView: UIView!
    //在backView上创建一个UIDynamicAnimator
    lazy var animator = UIDynamicAnimator(referenceView: self.backView)
    //创建一个重力行为
    let gravity = UIGravityBehavior()
    //创建一个碰撞行为
    let collision = UICollisionBehavior()
    
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
         UIView.animate(withDuration: 4) {
            //旋转时放大倍数
            var trans = CGAffineTransform(scaleX: 1, y: 1)
            //旋转时的角度(180度)
            trans = trans.rotated(by: CGFloat(Double.pi))
            //旋转的an affine transformation matrix
            //trans = trans.translatedBy(x: 300, y: 300)
            self.MyView.transform = trans
            //这样也能旋转回来(复原)
            self.MyView.transform = CGAffineTransform.identity
        }
        //另外180度旋转回来
//        UIView.animate(withDuration: 4, delay: 0, options: .curveEaseInOut, animations: {
//            self.MyView.transform =  CGAffineTransform(rotationAngle: CGFloat(Double.pi))
//        }, completion: { _ in
//            self.MyView.transform =  CGAffineTransform(rotationAngle: CGFloat(0))
//        })
    }
    //视图间的切换
    @IBAction func MyTransition(_ sender: Any) {
        //增加的子视图(从一个视图切换到另一个视图，但只在其上一级父容器里切换)
        let theView = UIView(frame: MyView.frame)
        theView.backgroundColor = UIColor.green
        UIView.transition(from: MyView, to: theView, duration: 2, options: .transitionCurlUp, completion: nil)
        
        //在一个view上操作(比如改它的背景颜色等等)
//        UIView.transition(with: MyView, duration: 2, options: .transitionFlipFromLeft, animations: {
//            self.MyView.addSubview(theView)
//        }, completion: {
//            //切换回来
//            _ in  UIView.transition(with: self.MyView, duration: 2, options: .transitionFlipFromRight, animations: {
//                //移除子视图
//                theView.removeFromSuperview()
//            }, completion: nil)
//        })
}
    
    //Dynamic(增加视图)
    @IBAction func addView(_ sender: Any) {
        self.MyView!.isHidden = true
        let width = Int(backView.bounds.width/10)
        let randX = Int(arc4random() % 10) * width
        let label = UILabel(frame: CGRect(x: randX, y: 5, width: width, height: 2*width))
        label.backgroundColor = UIColor.green
        label.text = "ljl"
        label.textAlignment = .center
        backView.addSubview(label)
        //在行为中要添加UIDynamicItems(usually a UIView)
        gravity.addItem(label)
        collision.addItem(label)
    }
    //Dynamic(向上移动视图)
    @IBAction func upViews(_ sender: Any) {
          gravity.gravityDirection = CGVector(dx: 0, dy: -1)
    }
    //Dynamic(向下移动视图)
    @IBAction func downViews(_ sender: Any) {
         gravity.gravityDirection = CGVector(dx: 0, dy: 1)
    }
    //Dynamic(向左移动视图)
    @IBAction func leftViews(_ sender: Any) {
         gravity.gravityDirection = CGVector(dx: -1, dy: 0)
    }
    //Dynamic(向右移动视图)
    @IBAction func rightViews(_ sender: Any) {
         gravity.gravityDirection = CGVector(dx: 1, dy: 0)
    }
    //Dynamic(删除视图)
    @IBAction func deleteViews(_ sender: Any) {
        for item in self.backView.subviews {
            if item is UILabel {
                item.removeFromSuperview()
                //在行为中去除item,否则清除不干净,那些item还会t悬停在那儿
                gravity.removeItem(item)
                collision.removeItem(item)
            }
        }
        MyView.isHidden = false
        gravity.gravityDirection = CGVector(dx: 0, dy: 1)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //在animator动画中添加之前创建的重力行为
        animator.addBehavior(gravity)
        //as follow like
        animator.addBehavior(collision)
        //设置碰撞行为时的边界
        collision.translatesReferenceBoundsIntoBoundary = true
    }


}

