
import UIKit

struct Movie{
    var title: String
    var releaseDate: String
    var runtime: Int
    var overview: String
    var rate: Float
    var isLiked: Bool
    var backgroundColor: UIColor
    var memo: String?
}

struct MovieInfo {
    static func generateColor() -> UIColor{
        let color = UIColor(cgColor: .init(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: CGFloat.random(in: 0...1)))
        return color
    }
    var searchResults: [Movie] = []
    var movies: [Movie] = [
        Movie(title: "명량", releaseDate: "2014.07.30.", runtime: 128, overview: "1597년 임진왜란 6년, 오랜 전쟁으로 인해 혼란이 극에 달한 조선. 무서운 속도로 한양으로 북상하는 왜군에 의해 국가존망의 위기에 처하자 누명을 쓰고 파면 당했던 이순신 장군(최민식)이 삼도수군통제사로 재임명된다. 하지만 그에게 남은 건 전의를 상실한 병사와 두려움에 가득 찬 백성, 그리고 12척의 배 뿐. 마지막 희망이었던 거북선마저 불타고 잔혹한 성격과 뛰어난 지략을 지닌 용병 구루지마(류승룡)가 왜군 수장으로 나서자 조선은 더욱 술렁인다. 330척에 달하는 왜군의 배가 속속 집결하고 압도적인 수의 열세에 모두가 패배를 직감하는 순간, 이순신 장군은 단 12척의 배를 이끌고 명량 바다를 향해 나서는데…! 12척의 조선 vs 330척의 왜군 역사를 바꾼 위대한 전쟁이 시작된다!", rate: 8.88, isLiked: true, backgroundColor: generateColor(), memo: "이순신 그는 신이야..."),
        Movie(title: "부산행", releaseDate: "2016.07.20.", runtime: 118, overview: "정체불명의 바이러스가 전국으로 확산되고 대한민국 긴급재난경보령이 선포된 가운데, 열차에 몸을 실은 사람들은 단 하나의 안전한 도시 부산까지 살아가기 위한 치열한 사투를 벌이게 된다. 서울에서 부산까지의 거리 442KM 지키고 싶은, 지켜야만 하는 사람들의 극한의 사투!", rate: 8.60, isLiked: false, backgroundColor: generateColor()),
        Movie(title: "아바타", releaseDate: "2009.12.17.", runtime: 162, overview: "지구 에너지 고갈 문제를 해결하기 위해 판도라 행성으로 향한 인류는 원주민 ‘나비족’과 대립하게 된다. 이 과정에서, 전직 해병대원 제이크 설리(샘 워싱턴)가 ‘아바타’ 프로그램을 통해 ‘나비족’의 중심부에 투입되는데… 피할 수 없는 전쟁! 이 모든 운명을 손에 쥔 제이크! 그 누구도 넘보지 못한 역대급 세계가 열린다! 아바타: 인간과 ‘나비족’의 DNA를 결합해 만들어졌으며 링크룸을 통해 인간의 의식으로 원격 조종할 수 있는 새로운 생명체", rate: 9.07, isLiked: false, backgroundColor: generateColor()),
        Movie(title: "어벤져스 엔드 게임", releaseDate: "2019.04.24.", runtime: 181, overview: "인피니티 워 이후 절반만 살아남은 지구 마지막 희망이 된 어벤져스 먼저 떠난 그들을 위해 모든 것을 걸었다! 위대한 어벤져스 운명을 바꿀 최후의 전쟁이 펼쳐진다!", rate: 9.49, isLiked: true, backgroundColor: generateColor()),
        Movie(title: "해운대", releaseDate: "2009.07.22.", runtime: 120, overview: "2004년 역사상 유례없는 최대의 사상자를 내며 전세계에 엄청난 충격을 안겨준 인도네시아 쓰나미. 당시 인도양에 원양어선을 타고 나갔던 해운대 토박이 만식은 예기치 못한 쓰나미에 휩쓸리게 되고, 단 한 순간의 실수로 그가 믿고 의지했던 연희 아버지를 잃고 만다. 이 사고 때문에 그는 연희를 좋아하면서도 자신의 마음을 숨길 수 밖에 없다. 그러던 어느 날, 만식은 오랫동안 가슴 속에 담아두었던 자신의 마음을 전하기로 결심하고 연희를 위해 멋진 프로포즈를 준비한다. 한편 국제해양연구소의 지질학자 김휘 박사는 대마도와 해운대를 둘러싼 동해의 상황이 5년전 발생했던 인도네시아 쓰나미와 흡사하다는 엄청난 사실을 발견하게 된다. 그는 대한민국도 쓰나미에 안전하지 않다고 수차례 강조하지만 그의 경고에도 불구하고 재난 방재청은 지질학적 통계적으로 쓰나미가 한반도를 덮칠 확률은 없다고 단언한다. 그 순간에도 바다의 상황은 시시각각 변해가고, 마침내 김휘 박사의 주장대로 일본 대마도가 내려 앉으면서 초대형 쓰나미가 생성된다. 한여름 더위를 식히고 있는 수백만의 휴가철 인파와 평화로운 일상을 보내고 있는 부산 시민들, 그리고 이제 막 서로의 마음을 확인한 만식과 연희를 향해 초대형 쓰나미가 시속 800km의 빠른 속도로 밀려오는데… 가장 행복한 순간 닥쳐온 엄청난 시련, 남은 시간은 단 10분! 그들은 가장 소중한 것을 지켜내야만 한다!", rate: 7.45, isLiked: false, backgroundColor: generateColor()),
        Movie(title: "인셉션", releaseDate: "2010.07.21.", runtime: 148, overview: "꿈의 속으로 빠져들어 생각의 중요성을 인식하게 된다.", rate: 8.83, isLiked: false, backgroundColor: generateColor()),
        Movie(title: "라라랜드", releaseDate: "2016.12.07.", runtime: 128, overview: "재즈 피아니스트와 배우의 로맨틱한 사랑 이야기.", rate: 8.95, isLiked: true, backgroundColor: generateColor()),
        Movie(title: "겨울왕국", releaseDate: "2013.11.21.", runtime: 102, overview: "눈과 얼음의 나라에서 언뜻 보기에 완벽한 언니들의 자매 사랑 이야기.", rate: 8.21, isLiked: false, backgroundColor: generateColor()),
        Movie(title: "캐치미 이프 유캔", releaseDate: "2002.09.11.", runtime: 134, overview: "신이 내린 축복을 찾기 위해 여행을 떠나는 소년의 성장 이야기.", rate: 8.10, isLiked: false, backgroundColor: generateColor()),
        Movie(title: "포레스트 검프", releaseDate: "1994.06.23.", runtime: 142, overview: "바보라 불리는 포레스트의 특별한 인생 이야기.", rate: 9.20, isLiked: false, backgroundColor: generateColor()),
        Movie(title: "인터스텔라", releaseDate: "2014.11.06.", runtime: 169, overview: "우리가 살던 행성은 멸망했다. 지구 이후의 우주 여행.", rate: 8.65, isLiked: true, backgroundColor: generateColor()),
        Movie(title: "위대한 쇼맨", releaseDate: "2017.12.20.", runtime: 105, overview: "자신의 꿈을 위해 끝까지 싸우는 쇼맨의 이야기.", rate: 8.76, isLiked: false, backgroundColor: generateColor()),
        Movie(title: "레옹", releaseDate: "1994.09.14.", runtime: 133, overview: "청소부가 된 소년과 살인마 사이의 독특한 우정 이야기.", rate: 9.15, isLiked: false, backgroundColor: generateColor()),
        Movie(title: "타이타닉", releaseDate: "1997.12.19.", runtime: 195, overview: "사랑과 비극이 만난 대서사시적인 선박 침몰 이야기.", rate: 9.45, isLiked: false, backgroundColor: generateColor()),
        Movie(title: "어벤져스 인피니티 워", releaseDate: "2018.04.25.", runtime: 149, overview: "어벤져스와 다른 영웅들이 인피니티 스톤을 차지하기 위한 전쟁을 벌인다.", rate: 9.11, isLiked: false, backgroundColor: generateColor())
        
    ]
}
