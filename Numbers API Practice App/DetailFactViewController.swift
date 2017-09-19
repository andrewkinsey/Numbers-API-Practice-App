//
//  DetailFactViewController.swift
//  Numbers API Practice App
//
//  Created by Andrew James Kinsey on 9/19/17.
//  Copyright © 2017 The Cabinents. All rights reserved.
//

import UIKit

class DetailFactViewController: UIViewController
{
    var fact = ""
    var number = ""
    
    @IBOutlet weak var factLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print(fact)
        factLabel.text = fact
        self.title = number
    }
}
