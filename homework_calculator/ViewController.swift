//
//  ViewController.swift
//  homework_calculator
//
//  Created by Ruslan Ismailov on 19/06/22.
//

import UIKit

class ViewController: UIViewController {
    // Добавляю все кнопки в код
    @IBOutlet weak var digitalScreen: UILabel!
    
    @IBOutlet weak var num1: UIButton!
    @IBOutlet weak var num2: UIButton!
    @IBOutlet weak var num3: UIButton!
    @IBOutlet weak var num4: UIButton!
    @IBOutlet weak var num5: UIButton!
    @IBOutlet weak var num6: UIButton!
    @IBOutlet weak var num7: UIButton!
    @IBOutlet weak var num8: UIButton!
    @IBOutlet weak var num9: UIButton!
    @IBOutlet weak var num0: UIButton!
    
    @IBOutlet weak var eraseScreen: UIButton!
    
    @IBOutlet weak var symbolComma: UIButton!
    
    @IBOutlet weak var equals: UIButton!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var multiply: UIButton!
    @IBOutlet weak var divide: UIButton!
    
    @IBOutlet weak var changePlusAndMinus: UIButton!
    @IBOutlet weak var percent: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //задаю параметры по умолчанию при первом запуске
        digitalScreen.text = "0"
        screenDigitalString = ""
        screenDigitalCharackter = []
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //устанавливаю свою тему, прописанную в коде
        interfaceCalc()

    }
    // тема калькулятора
    func interfaceCalc(){
        let operatorTheme: [UIButton] = [plus, minus, multiply, divide, equals]
        for x in operatorTheme{
            theme(button: x, color: .systemGreen)
        }
        let digitalArray: [UIButton] = [num0, num1, num2, num3, num4, num5, num6, num7, num8, num9]
        for x in digitalArray{
            theme(button: x, color: .white)
        }
        let yellowButton: [UIButton] = [changePlusAndMinus, symbolComma, percent]
        for x in yellowButton{
            theme(button: x, color: .init(red: 0.86, green: 0.75, blue: 0.31, alpha: 1))
        }
        theme(button: eraseScreen, color: .init(red: 1, green: 0.5, blue: 0.5, alpha: 1))
    }
    // универсальность оформления каждой кнопки
    func theme(button: UIButton, color: UIColor){
        button.backgroundColor = color
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "Arial", size: 30)
        button.frame.size.width = 15
        
    }
    //массив с символами
    var screenDigitalCharackter: [Character] = ["0"]
    //цифры при расчетах
    var firstNum: Double = 0
    var secondNum: Double = 0
    //перевод символов в строчку для вывода в лейбле
    var screenDigitalString: String = ""
    //отсечение первой цифры и начало записи второй
    var switchToSecond = 0
    //перевод второй цифры в строчку
    var secondNumString = ""
    //выбор оператора + - / *, хотел сделать enum но уже мозг выжат =)
    var task = 0
    //указание оператора в переменную
    var operatoR: Character = " "
    //когда отработал код с первой цифрой то это то что передает вторую цифру в лейбл
    var newDisplay: String = ""
    //переменная нужная при отрезании оператора с сторки
    var secondTrashString: String = ""
    //калькулятор работает в режиме double по умолчанию, проверяет есть ли цифры после запятой и если нет то переводит в Int
    var doubleAnswer: Double = 0
    //использование точки
    var useComma: Bool = false
    //работа с процентами
    var percendOperator = 0
    //добавление минуса к цифре
    var useSpecialMinus = false
    //если использовали минус и при этом добавляем минус к цифре, переменная уберает конфликты
    var usedOperator = false
    //возможность продолжать вычисления с ответом до бесконечности в теории =)
    var continuedCalculate = false
    
    //проверка возможноти продолжения вычисления
    private func checkContinuedCalc(){
        if (screenDigitalCharackter.firstIndex(of: operatoR) != nil){
            continuedCalculate = true
        }else{
            continuedCalculate = false
        }
    }
    
    //экшн для цифр
    @IBAction func touchNum1(_ sender: UIButton) {
        //добавление в массив символа
        screenDigitalCharackter.append("1")
        //проверка
        checkContinuedCalc()
        //отработка отображения в лейбле
        addNum()
    }
    
    @IBAction func touchNum2(_ sender: UIButton) {
        screenDigitalCharackter.append("2")
        checkContinuedCalc()
        addNum()
    }
    @IBAction func touchNum3(_ sender: UIButton) {
        screenDigitalCharackter.append("3")
        checkContinuedCalc()
        addNum()
    }
    @IBAction func touchNum4(_ sender: UIButton) {
        screenDigitalCharackter.append("4")
        checkContinuedCalc()
        addNum()
    }
    @IBAction func touchNum5(_ sender: UIButton) {
        screenDigitalCharackter.append("5")
        checkContinuedCalc()
        addNum()
    }
    @IBAction func touchNum6(_ sender: UIButton) {
        screenDigitalCharackter.append("6")
        checkContinuedCalc()
        addNum()
    }
    @IBAction func touchNum7(_ sender: UIButton) {
        screenDigitalCharackter.append("7")
        checkContinuedCalc()
        addNum()
    }
    
    @IBAction func touchNum8(_ sender: UIButton) {
        screenDigitalCharackter.append("8")
        checkContinuedCalc()
        addNum()
    }
    @IBAction func touchNum9(_ sender: UIButton) {
        screenDigitalCharackter.append("9")
        checkContinuedCalc()
        addNum()
    }
    @IBAction func touchNum0(_ sender: UIButton) {
        screenDigitalCharackter.append("0")
        checkContinuedCalc()
        //если не переключен на запись второй цифры и первый символ ноль, то нажимая на ноль повторно будет срываться операция в исходную, защита от неправильных цифр
        if switchToSecond == 0 && screenDigitalCharackter[0] == "0"  {
             screenDigitalCharackter = ["0"]
             screenDigitalString = "0"
             digitalScreen.text = "0"
        }else{
            //иначе отработка добавление символа в массив
            addNum()
        }
        
    }
    
    //кнопка сброса
    @IBAction func touchEraseScreen(_ sender: UIButton) {
        digitalScreen.text = "0"
        screenDigitalString = ""
        screenDigitalCharackter = []
        continuedCalculate = false
    }
    
    //кнопка плюс
    @IBAction func touchPlus(_ sender: UIButton) {
        //нажав на кнопку срабатывает триггер на запись второй цифры
        switchToSecond = 1
        //выбор режима +
        task = 1
        //выбор режима для процентов, тоже +
        percendOperator = 1
        //добавление в переменную символа
        operatoR = "+"
        //при повторном нажатии этой кнопки произойдет автоматическое нажатие ровно
        if screenDigitalString.contains(operatoR){
            equals.sendActions(for: UIControl.Event.touchUpInside)
        }else{
            //иначе запись в переменную первой цифры
            firstNum = Double(screenDigitalString) ?? 0
            //указание в текстовой переменной знака +
            screenDigitalString = "+"
            //вывод в лейбл
            digitalScreen.text = screenDigitalString
            //сброс массива с первой цифрой
            screenDigitalCharackter = []
            
        }
        //если триггер стоит то ответ будет автоматически добавлен в переменную первой цифры
        if continuedCalculate{
            firstNum = doubleAnswer
        }
    }
    
    //кнопка минус, по описанию тоже самое
    @IBAction func touchMinus(_ sender: UIButton) {
        switchToSecond = 1
        task = 2
        percendOperator = 2
        operatoR = "-"
        if screenDigitalString.contains(operatoR) && useSpecialMinus == false{
            equals.sendActions(for: UIControl.Event.touchUpInside)
        }else{
            firstNum = Double(screenDigitalString) ?? 0
            screenDigitalString = "-"
            digitalScreen.text = screenDigitalString
            screenDigitalCharackter = []
            
        }
        if continuedCalculate{
            firstNum = doubleAnswer
        }
    }
    
    //кнопка умножить
    @IBAction func touchMultiply(_ sender: UIButton) {
        switchToSecond = 1
        task = 3
        percendOperator = 3
        operatoR = "*"
        if screenDigitalString.contains(operatoR){
            equals.sendActions(for: UIControl.Event.touchUpInside)
        }else{
            
            firstNum = Double(screenDigitalString) ?? 0
            screenDigitalString = "*"
            digitalScreen.text = screenDigitalString
            screenDigitalCharackter = []
            
        }
        if continuedCalculate{
            firstNum = doubleAnswer
        }
    }
    
    //кнопка разделить
    @IBAction func touchDivide(_ sender: UIButton) {
        switchToSecond = 1
        task = 4
        percendOperator = 4
        operatoR = "/"
        if screenDigitalString.contains(operatoR){
            equals.sendActions(for: UIControl.Event.touchUpInside)
        }else{
            
            firstNum = Double(screenDigitalString) ?? 0
            screenDigitalString = "/"
            digitalScreen.text = screenDigitalString
            screenDigitalCharackter = []
            
        }
        if continuedCalculate{
            firstNum = doubleAnswer
        }
    }
    
    //кнопка точка
    @IBAction func touchComma(_ sender: UIButton) {
        //триггер на использование точки
        useComma = true
        //защита от повторного нажатия
        if screenDigitalCharackter.contains("."){
            useComma = false
        }else{
            screenDigitalCharackter.append(".")
            addNum()
        }
        
    }
    
    //кнопка заменить + на - и наоборот
    @IBAction func touchChandgeMinusAndPlus(_ sender: UIButton) {
        //триггер на использование именно этого минуса и защиту от конфликта оператора минус
        useSpecialMinus = true
        
        //если используется переменная с нулем то минус добавляется к первой цифре
        if switchToSecond == 0{
            //если повторно нажать то минус исчезнет
            if (screenDigitalString.firstIndex(of: "-") == nil){
                screenDigitalString = "-" + screenDigitalString
                digitalScreen.text = String(screenDigitalString)
            }else{
                screenDigitalString.remove(at: screenDigitalString.startIndex)
                digitalScreen.text = String(screenDigitalString)
                print(screenDigitalString)
            }
            
        }else{
            //иначе минус поставиться ко второму значению и так же будет исчезать при повторном нажатии
            if newDisplay.firstIndex(of: "-") == nil{
                newDisplay = "-" + newDisplay
                digitalScreen.text = String(newDisplay)
            }else{
                newDisplay.remove(at: newDisplay.startIndex)
                digitalScreen.text = String(newDisplay)
            }
        }
        
    }
    
    //кнопка проценты
    @IBAction func touchPercent(_ sender: UIButton) {
        switchToSecond = 1
        task = 5
    }
    
    //кнопка ровно
    @IBAction func touchEqual(_ sender: UIButton) {
        //переменная для отсечения оператора из строки
        var secondNumStringTemp = ""
        //указание если использовали кнопку +/-
        if (newDisplay.firstIndex(of: "-") != nil){
            secondNumStringTemp = newDisplay
        }else{
            //находим оператора в строке
            let index = secondTrashString.firstIndex(of: operatoR) ?? secondTrashString.endIndex
            //задаем промежуток в массиве строки в подстроку
            let partOfIt = secondTrashString[index..<secondTrashString.endIndex]
            //переводим подстроку в строку
            secondNumStringTemp = String(partOfIt)
            //защита от остатка оператора в строке
            if secondNumStringTemp.contains(operatoR){
                secondNumStringTemp.remove(at: secondNumStringTemp.startIndex)
            }
        }
        //переводим строку в цифру
        secondNum = Double(secondNumStringTemp) ?? 0
        //выполняем функцию вычисления
        methods(task: task)

    }
    
    //функция округления, а так же вывода круглых цифр без запятых и дробных частей
    private func roundedDigital(){
        //нахождение остатка от деления
        let dividingBy = doubleAnswer.truncatingRemainder(dividingBy: 1)
        //если цифра целая
        if dividingBy == 0 {
            digitalScreen.text = String(Int(doubleAnswer))
        }else{
            //чтоб не выводить большое количество цифр округляю до 5 цифр после запятой
            digitalScreen.text = String(((doubleAnswer * 100000).rounded()) / 100000)
        }
    }
    
    //функция для всех математических вычислений
    private func methods(task:Int){
        //сортировка по оператору
        switch task{
        case 0:
            break
        case 1:
            doubleAnswer = firstNum + secondNum
            //округление ответа
            roundedDigital()
            //возможноть продолжать вычисления с ответом
            continuedCalculate = true
        case 2:
            doubleAnswer = firstNum - secondNum
            roundedDigital()
            continuedCalculate = true
        case 3:
            doubleAnswer = firstNum * secondNum
            roundedDigital()
            continuedCalculate = true
        case 4:
            doubleAnswer = firstNum / secondNum
            roundedDigital()
            continuedCalculate = true
        case 5:
            //вычисление процента
            let tempAnswer = firstNum / 100 * secondNum
            //что сделать с процентом при указании оператора перед набором второй цифры и нажатием кнопки процента
            switch percendOperator{
            case 0:
                break
            case 1:
                doubleAnswer = firstNum + tempAnswer
            case 2:
                doubleAnswer = firstNum - tempAnswer
            case 3:
                doubleAnswer = firstNum * tempAnswer
            case 4:
                doubleAnswer = firstNum / tempAnswer
            default:
                break
            }
            //после отработки возможноть продолжить действия с ответом
            continuedCalculate = true
            roundedDigital()
        default:
            break
        }
        //обнуление всего и вся
        screenDigitalCharackter = []
        screenDigitalString = ""
        secondNumString = ""
        firstNum = 0
        secondNum = 0
        switchToSecond = 0
        newDisplay = ""
        
    }

    //функция добавления символов
    private func addNum(){
        //переменная для выборки каждого символа
        var num: Character
        //в случае использования точки
        if useComma{
            num = screenDigitalCharackter[screenDigitalCharackter.endIndex - 1]
            screenDigitalString = screenDigitalString + String(num)
            digitalScreen.text = screenDigitalString
        }else{
            num = screenDigitalCharackter[screenDigitalCharackter.endIndex - 1]
            screenDigitalString = screenDigitalString + String(num)
            digitalScreen.text = screenDigitalString
        }
        
       //вывод в переменную для защиты перед удалением
        secondTrashString = screenDigitalString
        //если триггер 1 то начинать записывать цифру 2
        if switchToSecond == 1{
            if screenDigitalString.contains(operatoR){
                newDisplay = screenDigitalString
                newDisplay.remove(at: newDisplay.startIndex)
                digitalScreen.text = newDisplay
            }
            
        }
    }
    
}






