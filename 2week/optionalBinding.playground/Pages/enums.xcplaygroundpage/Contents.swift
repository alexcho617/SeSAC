//: [Previous](@previous)

import Foundation

//1. 미디어 종류 - 영화/드라마/애니메이션
//2. 성별 - 남자/여자

//CaseIterable protocol: 열거형의 멤버들을 순회할 수 있는 컬렉션 타입처럼 사용가능. 배열처럼 쓸 수 있음.
enum InternetSlang: Int, CaseIterable { //works like index
    case 워드랩 = 1
    case 꿀잼 = 11 //11부터 1개씩 올라감
    case 이따금
    case 품절남
    case 먹통
}

enum Media: String {
    case movie = "영화"
    case drama = "드라마"
    case animation = "애니메이션"
    case none
}

enum Gender: String {
    case male, female
}

var user: Gender = .male
var media: Media = .movie
var word: InternetSlang = .꿀잼
let wordList : [InternetSlang] = [.꿀잼,.먹통,.워드랩]
print(wordList[0])
print(wordList)


let wordListIterable = InternetSlang.allCases //CaseIterable
print(wordListIterable)

//rawvalue - member and value 분리 가능
//***컴파일 시점에서 케이스를 알 수 있기때문에 오타와 휴먼에러를 방지 할수 있다
//열거형으로 타입이 정해져있기 때문에 디폴트 생략 가능, 모든경우를 다 쓴게 아니라면 디폴트 필요

switch media{
case .animation:
    print(media)
case .drama:
    print(media.rawValue)
case .movie:
    print(media.rawValue)
case .none:
    print(media)
}
//: [Next](@next)


print(word.rawValue)
print(InternetSlang.품절남.rawValue)
//반대로 인덱스로 열거형을 가져올때 //UIView에 tag를 사용할때 유용
var tag = 11
print(InternetSlang(rawValue: tag))
