import UIKit

//func welcome() {
//    print("HI")
//}

//func welcome(name: String) {
//     print("Hi \(name)")
//}

func welcome(name: String) -> String{
    return "HI\(name)"
}
//func welcome() -> String{
//    return "Hi User"
//}

welcome(name: "alex")
welcome

//함수에 함수를 전달
func introduce(message: (String) -> ()){
    
}

/*
 변수/상수나 데이터 구조내에 자료형을 저장할 수 있다
 함수의 반환값으로 자료형을 사용할 수 있다
 함수의 인자값으로 자료형을 전달할 수 있다
 */


func checkBankInfo(bank: String) -> Bool{
    let bankArray = ["우리", "신한", "국민"]
    return bankArray.contains(bank) ? true : false
}


///1급객체 특성
///1 Function Type

//변수나 상수에 함수를 실행해서 반환된 값을 대입한것. 1급 객체의 특성은 아니다
let result = checkBankInfo(bank: "우리")

//변수나 상수에 함수 그 자체를 대입할 수 있다 (1급객체의 특성)
//함수만 대입한것으로, 함수가 실행된 상태는 아님
//(String) -> Bool : Function Type (ex.Tuple)
let checkAccount = checkBankInfo //함수 자체 대입
//호출하면 실행 가능
checkAccount("신한")
checkAccount("카카오")


//Tuple Example
let tupleExample: (Int,Int,String) = (1,2,"Hello")
//FunctionType: (String) -> String
func hello(username: String) -> String{
    return "im \(username)"
}

//Function Type: (String, Int) -> String
func hello(username: String, age: Int) -> String{
    return "i am \(username), and \(age) yearsnold"
}

func hello(nickname: String) -> String{
    return "저는 \(nickname)"
}
//타입 어노테이션으로 구별 가능, 또 함수 표기법으로 구별 가능
let example: (String) -> String = hello(nickname:) //1급 객체 특성
example("alex")

///2. 함수의 반환타입으로 함수를 사용할 수 있따
func currentAccount() -> String{
    return "account alert pop up"
}
func noCurrentAccount() -> String{
    return "go to account create page"
}

//가장 왼쪽에 위치한 ->를 기준으로,오른쪽에 놓인 모든 타입은 반환값을 의미한다
//이 경우엔 String
func checkBank( bank: String) -> () -> String{
    let bankArray = ["우리", "국민", "신한"]
    return bankArray.contains(bank) ? currentAccount : noCurrentAccount
}

let alex = checkBank(bank: "신한")
alex()


func plus(a: Int, b: Int) -> Int{
    return a + b
}
func minus(a: Int, b: Int) -> Int{
    return a - b
}
func multiply(a: Int, b: Int) -> Int{
    return a * b
}
func divide(a: Int, b: Int) -> Int{
    return a / b
}

func calculate(operand: String) -> (Int,Int) -> Int{
    switch operand {
    case "+":  return plus
    case "-":  return minus
    case "*":  return multiply
    case "/":  return divide
    default:   return plus
    }
}
calculate(operand: "+")(1,2)
calculate(operand: "-")(1,2)
calculate(operand: "*")(1,2)
calculate(operand: "/")(1,2)

let resultCalculate = calculate(operand: "*")
resultCalculate(5,9)

/// 3. 함수의 인자(parameter) 에 함수가 들어간다
func oddNumber(){ // () -> () 빈 튜플이다 사실
    print("odd")
}

func evenNumber(){
    print("even")
}

func weirdFunc1(){

}
func weirdFunc2(){
    
}

func resultNumber(number: Int, odd: () -> Void, even: () -> Void){
    //    return number.isMultiple(of: 2) ? even() : odd() //실행까지 함
    return number.isMultiple(of: 2) ? even() : odd()
}


resultNumber(number: 3, odd: oddNumber, even: evenNumber)
resultNumber(number: 3, odd: weirdFunc1, even: weirdFunc2) //이렇게 해도 상관 없이 실행됨

//중요
resultNumber(number: 3,//바디만 가져옴  이게 바로 closure
             odd: {print("odd")},
             even: {print("even")}
            )

resultNumber(number: <#T##Int#>, odd: <#T##() -> Void#>, even: <#T##() -> Void#>)
//그래서 쓰고 엔터치면 되는거임
resultNumber(number: <#T##Int#>) {
    <#code#>
} even: {
    <#code#>
}

