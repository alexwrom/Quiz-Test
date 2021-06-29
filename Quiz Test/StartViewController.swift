//
//  StartViewController.swift
//  Quiz Test
//
//  Created by Alexwrom on 26.06.2021.
//

import UIKit
var quizArray : [Questions] = []

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizArray.append(Questions(textLabel: "Сколько будет 2 + 2?", typeAnswer: .checkType,questionsArray: ["1","2","4"], trueAnswer: "3"))
        quizArray.append(Questions(textLabel: "Какие числа являются степенью 2-ки?", typeAnswer: .switchType,questionsArray: ["1","2","4","5"], trueAnswer: "2,3"))
        quizArray.append(Questions(textLabel: "Чему равен квадрат гипотенузы?", typeAnswer: .checkType,questionsArray: ["Сумме катетов","Сумме квадратов катетов","Наибольшему из катетов"], trueAnswer: "2"))
        quizArray.append(Questions(textLabel: "Сколько острых углов у трапеции?", typeAnswer: .textType,questionsArray: [], trueAnswer: "2"))
        quizArray.append(Questions(textLabel: "Какие стороны прямоугольного треугольника образут прямой угол?", typeAnswer: .switchType,questionsArray: ["Гипотенуза","1й катет","2й катет","Медиана"], trueAnswer: "2,3"))
    }

    @IBAction func startTest(_ sender: Any) {
        performSegue(withIdentifier: "Test", sender: nil)
    }
    
    @IBAction func backStart(to: UIStoryboardSegue) {
        
    }
    
}

