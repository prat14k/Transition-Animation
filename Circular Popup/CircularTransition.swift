//
//  CircularTransition.swift
//  Circular Popup
//
//  Created by DEN on 06/08/17.
//  Copyright © 2017 14K. All rights reserved.
//

import UIKit

class CircularTransition: NSObject {

    var circle = UIView()
    
    var startingPoint = CGPoint.zero{
        didSet{
            circle.center = startingPoint;
        }
    }
    var circleColor = UIColor.white
    var duration = 0.3
    
    enum CircularTransitionMode{
        case present
        case dismiss
        case pop
    }
    
    var transitionMode:CircularTransitionMode = .present
    
}


extension CircularTransition:UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if transitionMode == .present{
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to){
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                circle = UIView()
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0.0
                
                containerView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1.0
                    presentedView.center = viewCenter
                }, completion:{ (success:Bool) in
                    transitionContext.completeTransition(success)
                })
            }
        }
        else{
            let transitionKey = (transitionMode == .pop) ? 	UITransitionContextViewKey.to : UITransitionContextViewKey.from
            
            if let returningView = transitionContext.view(forKey: transitionKey){
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height/2
                circle.center = startingPoint
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.center = self.startingPoint
                    returningView.alpha = 0
                    
                    if self.transitionMode == .pop{
                        containerView.insertSubview(returningView, belowSubview: returningView)
                        containerView.insertSubview(self.circle, belowSubview: returningView)
                    }
                    
                }, completion:{ (success : Bool) in
                
                     returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(success)
                
            })
        }
    }
}
    
    func frameForCircle(withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startPoint:CGPoint) -> CGRect{
        let xlength = fmax(startPoint.x,viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        
        let offSetVector = sqrt(xlength*xlength + yLength*yLength)*2
        let size = CGSize(width: offSetVector, height: offSetVector)
        
        return CGRect(origin: CGPoint.zero, size:size)
    }
    
}













