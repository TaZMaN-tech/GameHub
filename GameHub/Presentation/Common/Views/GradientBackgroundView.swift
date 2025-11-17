//
//  GradientBackgroundView.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 17.11.2025.
//

import UIKit

final class GradientBackgroundView: UIView {
    
    private let gradient = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        gradient.colors = [
            UIColor.systemIndigo.cgColor,
            UIColor.systemPurple.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradient, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
}
