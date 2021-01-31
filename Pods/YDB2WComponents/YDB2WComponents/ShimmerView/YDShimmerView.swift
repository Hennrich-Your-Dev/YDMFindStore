//
//  YDShimmerView.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 29/01/21.
//

import UIKit

public class YDShimmerView: UIView {
  // MARK: Properties
  public var gradientColorOne: CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
  public var gradientColorTwo: CGColor = UIColor(white: 0.95, alpha: 1.0).cgColor
  public var speed: Double = 0.9

  // MARK: Actions
  func addGradientLayer() -> CAGradientLayer {
    let gradientLayer = CAGradientLayer()

    gradientLayer.frame = self.bounds
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
    gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
    gradientLayer.locations = [0.0, 0.5, 1.0]
    self.layer.addSublayer(gradientLayer)

    return gradientLayer
  }

  func addAnimation() -> CABasicAnimation {
    let animation = CABasicAnimation(keyPath: "locations")
    animation.fromValue = [-1.0, -0.5, 0.0]
    animation.toValue = [1.0, 1.5, 2.0]
    animation.repeatCount = .infinity
    animation.duration = speed
    return animation
  }

  public func startAnimating() {
    let gradientLayer = addGradientLayer()
    let animation = addAnimation()
    gradientLayer.add(animation, forKey: animation.keyPath)
  }
}