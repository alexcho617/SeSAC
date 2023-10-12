import UIKit


//n^2
func find(_ arr: [Int]) -> Bool{
    for number in arr{
        for target in arr{
            if number + target == 101{
                return true
            }
        }
    }
    return false
}

print(find([1,100,0]))

//using compbinations
func findComb(arr: [Int], target: Int){
    //ncr
    //arr.count C 2
    //array -> 최대 5050개
    //loop array sum
}
