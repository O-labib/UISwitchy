//
//  ViewController.swift
//  UISwitchy
//
//  Created by o.labib1995@gmail.com on 02/04/2021.
//  Copyright (c) 2021 o.labib1995@gmail.com. All rights reserved.
//

import UIKit
import UISwitchy

class ViewController: UIViewController {

    @IBOutlet weak var switchy: UISwitchy!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchy.buttonFillColorOn = .blue
        switchy.buttonFillColorOff = .red
        
        switchy.backgroundColorOn = .gray
        switchy.backgroundColorOff = .green
        
        switchy.borderColor = .blue
        switchy.borderWidth = 2
        
        switchy.buttonImageOn = UIImage(named: "play.png") ?? UIImage()
        switchy.buttonImageOff = UIImage(named: "pause.png") ?? UIImage()
        
        switchy.imageTintingColorOn = .brown
        switchy.imageTintingColorOff = .orange
    }


    @IBAction func switchyAction(_ sender: Any) {
        guard let switchy = sender as? UISwitchy else { return }
        print(switchy.isOn)
    }
    var animating = false
    @IBAction func toggleAnimationAction(_ sender: Any) {
        if animating {
            switchy.stopAnimating(withNewState: !switchy.isOn)
        } else {
            switchy.startAnimating(loadingColor: .blue)
        }
        
        animating.toggle()
    }
    
}

