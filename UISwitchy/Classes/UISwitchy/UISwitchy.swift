//
//  UISwitchy.swift
//
//  Created by Omar on 12/23/20.
//  Copyright © 2020 Baianat. All rights reserved.
//

import UIKit

public protocol Switchable {
    var isOn: Bool {
        get
    }
    func set(isOn: Bool, animated: Bool)
    func toggle(animated: Bool)
    func startAnimating(loadingColor: UIColor)
    func stopAnimating(withNewState isOn: Bool?)
}

public class UISwitchy: UIControl {

    // MARK: Outlets
    @IBInspectable public var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
            borderWidth = 1.5
        }
    }
    public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = (borderWidth <= 2) ? borderWidth : 2
        }
    }

    private var offset: CGFloat = 3 {
        didSet {
            setNeedsLayout()
        }
    }
    private var circleDiameter: CGFloat = 28 {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable public var backgroundColorOff: UIColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) {
        didSet {
            if !isActive {
                backgroundColor = backgroundColorOff
            }
        }
    }
    @IBInspectable public var backgroundColorOn: UIColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1) {
        didSet {
            if isActive {
                backgroundColor = backgroundColorOn
            }
        }
    }

    @IBInspectable public var buttonFillColorOn: UIColor = #colorLiteral(red: 0.00038495849, green: 0.5735282302, blue: 0.8625876307, alpha: 1) {
        didSet {
            toggleButton.buttonFillColorOn = buttonFillColorOn
        }
    }
    @IBInspectable public var buttonFillColorOff: UIColor = #colorLiteral(red: 0.9132830501, green: 0.9583753943, blue: 0.9874874949, alpha: 1) {
        didSet {
            toggleButton.buttonFillColorOff = buttonFillColorOff
        }
    }

    @IBInspectable public var imageTintingColorOn: UIColor = #colorLiteral(red: 0.9132830501, green: 0.9583753943, blue: 0.9874874949, alpha: 1) {
        didSet {
            toggleButton.buttonImageTintingColorOn = imageTintingColorOn
        }
    }
    @IBInspectable public var imageTintingColorOff: UIColor = #colorLiteral(red: 0.00038495849, green: 0.5735282302, blue: 0.8625876307, alpha: 1) {
        didSet {
            toggleButton.buttonImageTintingColorOff = imageTintingColorOff
        }
    }
    @IBInspectable public var buttonImageOn: UIImage = UIImage() {
        didSet {
            toggleButton.buttonImageOn = buttonImageOn
        }
    }
    @IBInspectable public var buttonImageOff: UIImage = UIImage() {
        didSet {
            toggleButton.buttonImageOff = buttonImageOff
        }
    }
    @IBInspectable var isActiveInitially: Bool = false {
        willSet {
            isActive = newValue
        }
        didSet {
            reset()
        }
    }
    private func reset() {
        isActive ? setOn(animated: false) : setOff(animated: false)
    }
    var isActive: Bool = false

    // MARK: Views
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var rightFillerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    lazy var leftFillerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    lazy var toggleButton: ToggleImageButton = {
        let button = ToggleImageButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        setupToggleButton(button)
        return button
    }()
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        if #available(iOS 13.0, *) {
            spinner.style = .medium
        }
        return spinner
    }()
    private func setupToggleButton(_ toggleButton: ToggleImageButton) {
        toggleButton.buttonFillColorOn = buttonFillColorOn
        toggleButton.buttonFillColorOff = buttonFillColorOff
        toggleButton.buttonImageTintingColorOn = imageTintingColorOn
        toggleButton.buttonImageTintingColorOff = imageTintingColorOff
        toggleButton.buttonImageOn = buttonImageOn
        toggleButton.buttonImageOff = buttonImageOff
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        

    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
}

extension UISwitchy {

    // MARK: Setup functions
    private func setup() {
        addTapGesture()
        setupSubViews()
        setOff(animated: false)
    }
    private func addTapGesture() {
        stackView.isUserInteractionEnabled = true
        stackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchState)))
    }
    private func setupSubViews() {
        setupParentStackView()
        setupMiddleToggleButton()
        setupSpinner()
    }
    private func setupParentStackView() {
        stackView.removeFromSuperview()
        stackView.addArrangedSubview(leftFillerView)
        stackView.addArrangedSubview(toggleButton)
        stackView.addArrangedSubview(rightFillerView)
        addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: offset).isActive = true
    }
    private func setupMiddleToggleButton() {
        toggleButton.heightAnchor.constraint(equalToConstant: circleDiameter).isActive = true
        toggleButton.heightAnchor.constraint(equalTo: toggleButton.widthAnchor).isActive = true
    }
    private func setupSpinner() {
        addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: toggleButton.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: toggleButton.centerYAnchor).isActive = true
        spinner.leadingAnchor.constraint(equalTo: toggleButton.leadingAnchor, constant: offset).isActive = true
        spinner.topAnchor.constraint(equalTo: toggleButton.topAnchor, constant: offset).isActive = true
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        setCircle()
    }

    @objc private func switchState() {
        toggle()
        sendActions(for: .valueChanged)
    }
}

extension UISwitchy: Switchable {

    public func startAnimating(loadingColor: UIColor) {
        self.spinner.color = loadingColor

        UIView.animate(withDuration: 0.2) {
            self.spinner.startAnimating()

            self.leftFillerView.hide()
            self.rightFillerView.hide()
        }

        UIView.animate(withDuration: 0.3) {
            self.toggleButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.toggleButton.alpha = 0
        }
        UIView.animate(withDuration: 0.3,
                       delay: 0.1,
                       usingSpringWithDamping: 10,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.spinner.transform = .identity
                        self.spinner.alpha = 1
                       })
    }

    public func stopAnimating(withNewState isOn: Bool? = nil) {
        UIView.animate(withDuration: 0.2) {
            self.spinner.stopAnimating()
            if let isOn = isOn {
                self.set(isOn: isOn, animated: false)
                self.isActive = isOn
            } else {
                if self.isActive {
                    self.leftFillerView.reveal()
                } else {
                    self.rightFillerView.reveal()
                }
            }
        }

        UIView.animate(withDuration: 0.3) {
            self.spinner.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.spinner.alpha = 0
        }
        UIView.animate(withDuration: 0.3,
                       delay: 0.1,
                       usingSpringWithDamping: 10,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.toggleButton.transform = .identity
                        self.toggleButton.alpha = 1
                       })
    }
    public var isOn: Bool {
        isActive
    }

    public func set(isOn: Bool, animated: Bool) {
        isOn ? setOn(animated: animated) : setOff(animated: animated)
    }
    public func toggle(animated: Bool = true) {
        isOn ? setOff(animated: animated) : setOn(animated: animated)
        isActive.toggle()
    }
    private func setOn(animated: Bool) {
        let duration = animated ? 0.2 : 0
        UIView.animate(withDuration: duration) {
            self.leftFillerView.reveal()
            self.rightFillerView.hide()
            self.backgroundColor = self.backgroundColorOn
            self.toggleButton.transform = CGAffineTransform(rotationAngle: .pi * 2)
        } completion: { (_) in
            self.toggleButton.set(isOn: true)
        }
    }
    private func setOff(animated: Bool) {
        let duration = animated ? 0.2 : 0
        UIView.animate(withDuration: duration) {
            self.leftFillerView.hide()
            self.rightFillerView.reveal()
            self.backgroundColor = self.backgroundColorOff
            self.toggleButton.transform = .identity

        } completion: { (_) in
            self.toggleButton.set(isOn: false)
        }

    }

}
