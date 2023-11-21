//
//  ContentView.swift
//  CoinOrderBook
//
//  Created by Alex Cho on 2023/11/20.
//

import SwiftUI

struct ContentView: View {
    //@StateObject ios14
    //listen
    @ObservedObject var viewModel =  ContentViewModel()
    
    @State var renderingTestNumber = 0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Parent View Test: \(renderingTestNumber)")
                NavigationLink("TestView", value: renderingTestNumber)
                VStack {
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(1..<5) { data in
                                bannerVew()
                                    .onTapGesture {
                                        viewModel.fetchBanner()
                                    }
                                //ios 17 넓이 화면에 맞춤
//                                    .containerRelativeFrame(.horizontal)
                            }
                        }
                        //ios 17 스크롤 하고자 하는 대상 설정
//                        .scrollTargetLayout()
                    }
                    .scrollIndicators(.visible)
//                    ios17 item snap 기능
                    //(.paging) frame 기준
//                    .scrolTargetBehavior(.viewAligned) //compositional layout이랑 비슷
                    //.safeAreaPadding([.horizontal, 40)
                    //pagecontrolview 쓰려면 uikit code 써야함
//                    LazyVStack {
//                        ForEach(viewModel.money, id: \.self){ data in
//                            ListView(data: data)
//                        }
//                    }
                    ListView()
                }
                .padding()
            }
            .scrollIndicators(.hidden)
            .refreshable { //iOS15부터 이기 때문에 iOS13,14에선 UIKit의 pull to refresh 코드를 가져왔다.
                print("Refreshed")
                viewModel.fetchBanner()
                renderingTestNumber = Int.random(in: 0...100)
//                viewModel.banner =
//                money = dummy.shuffled() //global
            }
            .onAppear {
                //여기는 여러번 실행되기 때문에 네트워크 코드가 들어가기엔 적합하지 않음.
                print("view appeared")
//                money = dummy
//                print("Network")
//                viewModel.fetchAllMarket()
            }
            .navigationTitle("My Wallet")
            .navigationDestination(for: Int.self) { _ in
                BannerTestView(testNumber: $renderingTestNumber)
            }
        }
    }
    
    func bannerVew() -> some View {
        ZStack {
            Rectangle()
                .fill(viewModel.banner.color)
                .overlay(content: {
                    Circle()
                        .fill(.red.opacity(0.9))
                        .offset(x: -100)
                        .scaleEffect(1.3 ,anchor: .leading)
                })
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .frame(maxWidth: .infinity)
                .frame(width: UIScreen.main.bounds.width - 32,height: 200)
            VStack(alignment: .leading) {
                Spacer()
                Text("나의 소비내역")
                    .font(.title3)
                    .foregroundColor(.white)
                Text(viewModel.banner.totalFormat)
                    .font(.title)
                    .foregroundColor(.white)
            }
            //ios17 geometry Proxy: 상위 뷰의 사이즈를 가지고 상대적 레이아웃 잡을 때
//            .visualEffect { content, geometryProxy in
//            content.offset(x: scrollOffset(geometryProxy))
//              }
//            .visualEffect { content, geometryProxy in
//                content.offset(x: geometyProxy.size.width / 2, y geometryProxy.size.height / 2)
//            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
    
    //GeometryProxy: 컨테이너 뷰에 대한 좌표나 크기에 접근
    //scroll의 끝을 정해줌
//    func scrollOffset(_ proxy: GeometryProxy) -> CGFloat{
//        let result = proxy.bounds(of: .scrollView)?.minX ?? 0
//        return -result
//    }
    
//    func ListView(data: Market) -> some View{
//
//        HStack{
//            VStack(alignment: .leading){
//                Text(data.korean_name)
//                Text(data.english_name)
//            }
//            Spacer()
//            Text(data.market)
//        }
////        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
//        .padding(.vertical, 8)
//
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
