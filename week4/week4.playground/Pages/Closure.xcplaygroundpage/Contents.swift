//: [Previous](@previous)

import Foundation
func studyiOS(){ //Function Type? No parameter, void type: () -> Void
    print("Study on weekends")
}

let study:() -> () = { //Function Type? No parameter, void type: () -> Void
    print("Study on weekends")
}

study()

//Function Type? No parameter, void type: () -> Void
//closure header in closur body
let studyHarder = { () -> () in
    print("Study on weekends")
}
//: [Next](@next)

//function type as parameter
func getStudyWithMe(study: () -> () ){
    print("Study on weekends")
    study()
}

//코드를 생략하지않고 클로저 구문을 사용한 상태, 함수의 매개변수 내에 클로저가 그대로 들어간 형태
//인라인 클로저 Inline Closure
getStudyWithMe(study: { () -> () in
    print("Study on weekends")
})
//경량화 된 상태
getStudyWithMe {

}

//트레일링 클로저 Trailing Closure
//함수 뒤에 클로저가 실행. 함수란걸 조금 더 명확하게 알려줌
getStudyWithMe() { () -> () in
    print("Study on weekends")
}

// (Int) -> String
func example(number: Int) -> String{
    return "\(number)"
}
example(number: Int.random(in: 1...10))


func randomNumber(result: (Int) -> String){
    result(Int.random(in: 0...10))
}

//bracket 앞으로 옮기고 in 키워드로 헤더와 바디 구분
//inline closure
randomNumber(result: {(number: Int) -> String in
    return "행운의 숫자는\(number) 입니다"
})

//return, parameter 타입 생략
randomNumber(result: {(number) in
    return "행운의 숫자는\(number) 입니다"
})

//parameter 생략되면 내부 상수 $0사용 가능
//Swift 5.1  한줄일 경우 return 생략 가능
randomNumber(result: {
    "행운의 숫자는\($0) 입니다"
})

//trailing closure
randomNumber {
    "행운의 숫자는\($0) 입니다"
}


///Example 1
///4.0이상 학생들을 뽑아내보자
let students = [2.2,4.5,3.6,4.1,4.2,3.7]

var smartStudent: [Double] = []
for item in students{
    if item >= 4.0{
        smartStudent.append(item)
    }
}
print(smartStudent)

//고차 함수 사용 High Order Functions
let filterStudents = students.filter{ $0 >= 4.0 }
let filter = students.filter { value in
    value >= 4.0
}
print(filterStudents)
print(filter)


///Example 2 Multiply array of numbers by 3
let number = [Int](1...100)
var newNumber: [Int] = []
for number in number{
    newNumber.append(number * 3)
}
//print(newNumber)

//map은 반환값이 Generic Type T 이기 때문에 인트, 스트링 다 가능
let mapNumber = number.map{$0 * 3}
let mapResult = number.map{"\($0)번 입니다"}

//print(mapNumber)
//print(mapResult)

///Example3 Movie
let movieList = [
    "괴물": "박찬욱",
    "기생충": "봉준호",
    "옥자": "봉준호",
    "인셉션": "놀란 형",
    "인터스텔라": "놀란 형",
    "아바타": "제임스 형"
]

//특정 감독의 영화만 출력
let movieResult = movieList.filter { $0.value == "봉준호"}.map{$0.key}
print(movieResult)
//영화 이름을 배열로 변환
