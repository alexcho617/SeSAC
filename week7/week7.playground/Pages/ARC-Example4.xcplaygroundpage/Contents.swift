import Foundation

func makeIncrement(value: Int) -> () -> Int{
    var total = 0
    
    func increment() -> Int { //total, value 캡쳐하고있음
        total += value
        return total //closure는 값을 캡쳐할때 value/reference타입 상관 없이 Reference capture함
    }
    return increment
}
//외부 함수 생명주기 끝남. 내부 함수는 살아있음
let result = makeIncrement(value: 10)
//result에는 함수가 들어왔음
result()
result()
result()
result()

//how does closure capture?
func sampleClosure(){
    var number = 0
    print("1- \(number)")
    
    let closure: () -> Void = { [number] in //이게 없으면 값타입 캡쳐
        print("closure - \(number)")
    } //참조 타입으로 캡쳐함
    
    closure()
    
    number = 100
    
    closure()
    print("2- \(number)")
}
sampleClosure()

