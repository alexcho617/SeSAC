//
//  WalletView.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 2023/11/22.
//

import SwiftUI

struct WalletView: View {
    
    @State private var  isExpanded = false //animation
    @State private var showDetail = false //navigation
    @State private var cards = cardDataBank
    @State private var selectedCard = CardModel(name: "DefaultName", index: 0)
    @Namespace var myAnimation
    
    var body: some View {
        VStack {
            topTitle()
            cardSpace()
        }
        .overlay{
            if showDetail{ //for loop 밖에 있기 때문에 별도의 상태로 선택된 카드를 전달 할 필요
                //$를 쓰는거는 마치 포인터 처럼 변수 주소를 전달해주는것과 비슷한 느낌.
                WalletDetailView(
                    showDetail: $showDetail,
                    cardDetail: selectedCard,
                    animation: myAnimation
                )
            }
        }
    }
    
    func cardSpace() -> some View{
        ScrollView(showsIndicators: false){
            LazyVStack {
                ForEach(cards, id: \.self){ card in
                    cardView(card)
                    //현재 클릭한 카드 state 전달
                }
            }
        }
        //이렇게 하면 화면 어디를 클릭해도 펼쳐짐.
        .overlay{
            Rectangle()
                .fill(.black.opacity( isExpanded ? 0 : 0.01)) //0 으로 바뀌면서 클릭 할 수 없으며 하위 뷰인 카드를 클릭할 수 있음
                .onTapGesture {
                    withAnimation(.spring()) {
                        isExpanded = true
                    }
                }
        }
    }
    
    func cardView(_ card: CardModel) -> some View{
        return RoundedRectangle(cornerRadius: 16)
            .fill(card.color)
            .overlay(alignment: .topLeading){
                Text(card.name)
                    .font(.title3)
                    .bold()
                    .padding()
            }
            .frame(height: 150)
            .padding(.horizontal)
            .offset(y: CGFloat(card.index * (isExpanded ? 0 : -100))) //n(index) * offset 만큼 줘야함
        //card를 클릭하는게 아니라 위에 투명한 사각형을 둔다. 알파 0.01
            .onTapGesture {
                withAnimation(.spring()) {
                    selectedCard = card//선택된 카드 같이 변경
                    showDetail = true //데이터 기반 네비게이션
                }      
            }
        //TODO: Hero 안되고 있음 . .
        //Animation Group
            .matchedGeometryEffect(id: card, in: myAnimation) //id엔 보통 데이터의 고유 아이디 들어감. 이번 경우엔 데이터가 다 다르기 때문에 상관없음
            
    }
    
    //크기를 최대한 넓힌 후 정렬을 가지고 애니메이션을 줌
    func topTitle() -> some View {
        Text("Alex Wallet")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity,
                   alignment: isExpanded ? .leading : .center
            )
            .overlay(alignment: .trailing){
                topOverlayButton()
            }
            .padding()
    }
    
    //알파 값을 조정하여 애니메이션 효과를 줌
    func topOverlayButton() -> some View{
        Button {
            withAnimation(.spring()) {
                isExpanded = false
            }
            
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(.white)
                .padding()
                .background(.black, in: Circle())
        }
        .rotationEffect(Angle(degrees: isExpanded ? 225 : 45))
        .opacity(isExpanded ? 1 : 0)
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}

