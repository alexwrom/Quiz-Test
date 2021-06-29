//
//  TestViewController.swift
//  Quiz Test
//
//  Created by Alexwrom on 26.06.2021.
//

import UIKit
var result: Int = 0

class TestViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var textQuestion: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnFinish: UIButton!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var progress: UIProgressView!
    // MARK: Variables
    var selectedQuestion : Questions!
    var selIndexes: [Int] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        result = 0
        newQuestion()
    }
    
    // Выключаем остальные свичи
    @IBAction func oneSwitch(_ sender: UISwitch) {
        for v in stack.subviews{
            if v is UIStackView {
                for sw in (v as! UIStackView).subviews{
                    if sw is UISwitch {
                        if (sw as! UISwitch) != sender {
                            (sw as! UISwitch).isOn = false
                        }
                    }
                }
            }
        }
    }
    
    // Следующий вопрос
    @IBAction func nextQuestion(_ sender: Any) {
        getResust()
        newQuestion()
    }
    
    //Переходим на окно результатов
    @IBAction func startFinish(_ sender: Any) {
        getResust()
        performSegue(withIdentifier: "Finish", sender: nil)
    }
    
    func getResust() {
        if selectedQuestion.typeAnswer == .textType {
            result += getDataFromTextView() == selectedQuestion.trueAnswer ? 1 : 0
        } else {
            result += getDataFromSwitch() == selectedQuestion.trueAnswer ? 1 : 0
        }
    }
    
    //Получаем данные из текствью
    func getDataFromTextView() -> String {
        var text = ""
        for v in stack.subviews{
            if v is UITextField {
                text = (v as! UITextField).text!
            }
        }
        return text
    }
    
    //Получаем данные из свичей
    func getDataFromSwitch() -> String {
        var text = ""
        for v in stack.subviews{
            if v is UIStackView {
                for sw in (v as! UIStackView).subviews{
                    if sw is UISwitch{
                        if (sw as! UISwitch).isOn == true{
                            if text != "" {
                                text += ","
                            }
                            text += String((sw as! UISwitch).tag)
                        }
                    }
                }
            }
        }
        return text
    }
    
    func nextQuestion() -> Questions {
        
        var index = Int.random(in: 0...quizArray.count - 1)
        if !selIndexes.contains(index) {
            selIndexes.append(index)
        } else {
            while selIndexes.contains(index) {
                index = Int.random(in: 0...quizArray.count - 1)
            }
            selIndexes.append(index)
        }
        
        return quizArray[index]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
        {

            textField.resignFirstResponder()
            return true
        }
    
    // Создаем новый вопрос
    func newQuestion() {
        // Очищаем stack от всех контролов
        for v in stack.subviews{
            v.removeFromSuperview()
        }
        
        if selIndexes.count != quizArray.count {
            selectedQuestion = nextQuestion()
            progress.progress = Float(selIndexes.count) / Float(quizArray.count)
            textQuestion.text = selectedQuestion.textLabel
            
            if (selectedQuestion.typeAnswer == .textType) {
                let tmpLabel = UILabel()
                tmpLabel.text = "Введите ответ:"
                tmpLabel.textColor = .white
                stack.addArrangedSubview(tmpLabel)
                
                let tmpText = UITextField()
                tmpText.font = .systemFont(ofSize: 25)
                tmpText.textAlignment = .center
                tmpText.backgroundColor = .orange
                tmpText.enablesReturnKeyAutomatically = true
                tmpText.returnKeyType = .done
                tmpText.delegate = self
                stack.addArrangedSubview(tmpText)
            } else {
                for i in 0...selectedQuestion.questionsArray.count - 1 {
                    let tmpLabel = UILabel()
                    tmpLabel.text = String(i + 1) + ". " + selectedQuestion.questionsArray[i]
                    tmpLabel.textColor = .white
                    let tmpStack = UIStackView()
                    tmpStack.axis = .horizontal
                    tmpStack.distribution = .fill
                    tmpStack.addArrangedSubview(tmpLabel)
                    
                    let tmpSwith = UISwitch()
                    tmpSwith.tag = i + 1
                    if selectedQuestion.typeAnswer == .checkType {
                        tmpSwith.addTarget(self, action: #selector(TestViewController.oneSwitch(_:)), for: .valueChanged)
                    }
                    tmpStack.addArrangedSubview(tmpSwith)
                    
                    stack.addArrangedSubview(tmpStack)
                    
                }
            }
            if selIndexes.count == quizArray.count {
                btnNext.isHidden = true
                btnFinish.isHidden = false
            }
        }
    }
    
}
