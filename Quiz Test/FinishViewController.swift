//
//  FinishViewController.swift
//  Quiz Test
//
//  Created by Alexwrom on 29.06.2021.
//

import UIKit

class FinishViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "\(result) из \(quizArray.count)"
    }
}
