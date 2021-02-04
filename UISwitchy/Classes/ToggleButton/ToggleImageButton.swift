//
//  ToggleImageButton.swift
//
//  Created by Omar on 12/21/20.
//  Copyright © 2020 Baianat. All rights reserved.
//

import UIKit

public class ToggleImageButton: UIView {

    // MARK: Variable
    public var isActive = false

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    @IBInspectable public var buttonFillColorOn: UIColor = #colorLiteral(red: 0.00038495849, green: 0.5735282302, blue: 0.8625876307, alpha: 1)
    @IBInspectable public var buttonFillColorOff: UIColor = #colorLiteral(red: 0.9132830501, green: 0.9583753943, blue: 0.9874874949, alpha: 1)

    @IBInspectable public var buttonImageTintingColorOn: UIColor = #colorLiteral(red: 0.9132830501, green: 0.9583753943, blue: 0.9874874949, alpha: 1)
    @IBInspectable public var buttonImageTintingColorOff: UIColor = #colorLiteral(red: 0.00038495849, green: 0.5735282302, blue: 0.8625876307, alpha: 1)

    @IBInspectable public var buttonImageOn: UIImage = UIImage() {
        didSet {
            reset()
        }
    }
    @IBInspectable public var buttonImageOff: UIImage = UIImage() {
        didSet {
            reset()
        }
    }
    private func reset() {
        isActive ? setOn() : setOff()
    }

    // MARK: Setup functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    private func setup() {
        setupImageViewConstraint()
        setOff()
    }
    private func setupImageViewConstraint() {
        addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        setCircle()
    }
}

extension ToggleImageButton {

    public func set(isOn: Bool) {
        isOn ? setOn() : setOff()
    }

    public var isOn: Bool {
        isActive
    }

    public func toggle() {
        isActive ? setOff() : setOn()
    }

    private func setOn() {
        backgroundColor = buttonFillColorOn
        imageView.image = buttonImageOn
        imageView.tintImage(withColor: buttonImageTintingColorOn)
        isActive = true
    }

    private func setOff() {
        backgroundColor = buttonFillColorOff
        imageView.image = buttonImageOff
        imageView.tintImage(withColor: buttonImageTintingColorOff)
        isActive = false
    }
}
