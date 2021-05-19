//
//  UserLocationButton.swift
//  coriander
//
//  Created by Tomas Korcak on 14.05.2021.
//

import Foundation
import SwiftUI
import Mapbox

class UserLocationButton: UIButton {
    private var shape: CAShapeLayer?
    private let buttonSize: CGFloat

    // Initializer to create the user tracking mode button
    init(buttonSize: CGFloat) {
        self.buttonSize = buttonSize
        
        super.init(
            frame: CGRect(
                x: 0,
                y: 0,
                width: buttonSize,
                height: buttonSize
            )
        )
        self.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        self.layer.cornerRadius = 4

        let shape = CAShapeLayer()
        shape.path = drawArrow()
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

        self.shape = shape

        // Initial shape update
        updateShape(mode: .none)
        layer.addSublayer(self.shape!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Create a new bezier path to represent the tracking mode arrow,
    // making sure the arrow does not get drawn outside of the
    // frame size of the UIButton.
    private func drawArrow() -> CGPath {
        let bezierPath = UIBezierPath()
        let max: CGFloat = buttonSize / 2
        
        bezierPath.move(to: CGPoint(x: max * 0.5, y: 0))
        bezierPath.addLine(to: CGPoint(x: max * 0.1, y: max))
        bezierPath.addLine(to: CGPoint(x: max * 0.5, y: max * 0.65))
        bezierPath.addLine(to: CGPoint(x: max * 0.9, y: max))
        bezierPath.addLine(to: CGPoint(x: max * 0.5, y: 0))
        bezierPath.close()

        return bezierPath.cgPath
    }

    // Update the arrow's color and rotation when tracking mode is changed.
    func updateShape(mode: MGLUserTrackingMode) {
        let activePrimaryColor = UIColor.red
        let disabledPrimaryColor = UIColor.clear
        let disabledSecondaryColor = UIColor.black
        let rotatedArrow = CGFloat(0.66)

        switch mode {
        case .none:
            updateArrow(fillColor: disabledPrimaryColor, strokeColor: disabledSecondaryColor, rotation: 0)
        case .follow:
            updateArrow(fillColor: disabledPrimaryColor, strokeColor: activePrimaryColor, rotation: 0)
        case .followWithHeading:
            updateArrow(fillColor: activePrimaryColor, strokeColor: activePrimaryColor, rotation: rotatedArrow)
        case .followWithCourse:
            updateArrow(fillColor: activePrimaryColor, strokeColor: activePrimaryColor, rotation: 0)
        @unknown default:
            fatalError("Unknown user tracking mode")
        }
    }

    func updateArrow(fillColor: UIColor, strokeColor: UIColor, rotation: CGFloat) {
        guard let shape = self.shape else { return }
        shape.fillColor = fillColor.cgColor
        shape.strokeColor = strokeColor.cgColor
        shape.setAffineTransform(CGAffineTransform.identity.rotated(by: rotation))

        // Re-center the arrow within the button if rotated
        if rotation > 0 {
            shape.position = CGPoint(x: buttonSize / 2 + 2, y: buttonSize / 2 - 2)
        }

        layoutIfNeeded()
    }
}
