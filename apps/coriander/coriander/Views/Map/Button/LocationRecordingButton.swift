//
//  LocationRecordingButton.swift
//  coriander
//
//  Created by Tomas Korcak on 19.05.2021.
//

import Foundation
import SwiftUI
import Mapbox

class LocationRecordingButton: UIButton {
    private var shape: CAShapeLayer?
    private let buttonSize: CGFloat

    init(buttonSize: CGFloat, isRecording: Bool) {
        self.buttonSize = buttonSize
        
        super.init(
            frame: CGRect(
                x: 0,
                y: 0,
                width: buttonSize,
                height: buttonSize
            )
        )
        
        self.backgroundColor = UIColor.red.withAlphaComponent(0.9)
        self.layer.cornerRadius = 4
        
        let shape = CAShapeLayer();
//        shape.path = drawCircle()
        shape.path = drawSquare()
        
        shape.lineWidth = 2
        shape.lineJoin = CAShapeLayerLineJoin.round
        
        shape.bounds = CGRect(
            x: 0,
            y: 0,
            width: buttonSize / 2,
            height: buttonSize / 2
        )
        
        shape.position = CGPoint(
            x: buttonSize / 2,
            y: buttonSize / 2
        )
        
        shape.shouldRasterize = true
        shape.rasterizationScale = UIScreen.main.scale
        shape.drawsAsynchronously = true
        
        shape.fillColor = UIColor.white.cgColor;
        
        self.shape = shape
        
        // Initial shape update
        updateShape(isRecording: isRecording)
        layer.addSublayer(self.shape!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawCircle() -> CGPath {
        let bezierPath = UIBezierPath(
            ovalIn: CGRect(
                x: 0,
                y: 0,
                width: buttonSize / 2,
                height: buttonSize / 2
            )
        )
        
        return bezierPath.cgPath
    }
    
    private func drawSquare() -> CGPath {
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: 0,
                y: 0,
                width: buttonSize / 2,
                height:buttonSize / 2
    
            ),
            cornerRadius: 0
        )
        
        return bezierPath.cgPath
    }
    
    func updateShape(isRecording: Bool) {
        guard let shape = self.shape else { return }
        
        if isRecording {
            shape.path = drawSquare()
        } else {
            shape.path = drawCircle()
        }
        
        layoutIfNeeded()
    }
}
