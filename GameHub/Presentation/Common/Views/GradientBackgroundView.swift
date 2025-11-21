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
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (view: GradientBackgroundView, _) in
            view.updateColors()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint   = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradient, at: 0)
        updateColors()
    }
    
    private func updateColors() {
        let topColor = UIColor.gradientTop.cgColor
        let bottomColor = UIColor.gradientBottom.cgColor
        
        gradient.colors = [topColor, bottomColor]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
}
