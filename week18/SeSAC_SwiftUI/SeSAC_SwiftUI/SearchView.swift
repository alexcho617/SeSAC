//
//  SearchView.swift
//  SeSAC_SwiftUI
//
//  Created by Alex Cho on 2023/11/16.
//

import SwiftUI

struct Movie: Hashable, Identifiable{
    let id = UUID()
    let count = Int.random(in: 20...50)
    let name: String
    let color = Color.random()
}
struct SearchView: View{
    
    @State private var searchQuery = ""
    @State private var isChartPresented = false
    let movies = [
        Movie(name: "Aarry Potter"),
        Movie(name: "Barry Potter"),
        Movie(name: "Carry Potter"),
        Movie(name: "Darry Potter"),
        Movie(name: "Garry Potter"),
        Movie(name: "Harry Potter"),
        Movie(name: "Iarry Potter"),
    ]
    var filterMovie: [Movie] {
        return searchQuery.isEmpty ? movies : movies.filter{$0.name.contains(searchQuery)}
    }
    
    @available(iOS 16.0, *)
    var body: some View{
        NavigationStack {
            List{
//                SecureField("hi", text: $searchQuery)
                ForEach(filterMovie, id: \.self){movie in
                    //cell accessory 에 > 표시 자동으로 생김
                    //버튼과 같은것
                    //ios 15 navigationview + navigation link
//                    NavigationLink {
//                        LazyContainerView(SearchDetailView(movie: movie))
//
//                    } label: {
//                        HStack {
//                            Circle().fill(movie.color)
//                            Text(movie.name)
//                        }
//                        .frame(height: 60)
//                    }
                    //뷰만 보여줌
                    NavigationLink(value: movie) {
                        HStack {
                            Circle().fill(movie.color)
                            Text(movie.name)
                        }
                        .frame(height: 60)
                    }
                }
            }
            .navigationTitle("검색")
            .navigationBarTitleDisplayMode(.large)
            //navigation bar, tabbar toolbar 다 가능
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        print("Right Click")
                        isChartPresented.toggle()
                    } label: {
                        Image(systemName: "star")
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        print("Right Click")
                    } label: {
                        Image(systemName: "pencil")
                    }

                }
            }
            .searchable(text: $searchQuery, placement: .navigationBarDrawer, prompt: "Search")
            .onSubmit(of: .search) {
                print("Search: \(searchQuery)")
            }
            //data 기반
            .sheet(isPresented: $isChartPresented) {
                ChartView(movies: movies)
            }
            //Diffable Datasource 유사
            //ios 16 navigation stack + navigationd destination
            .navigationDestination(for: Movie.self) { movie in
                SearchDetailView(movie: movie)
            }
        }
    }
    
}

struct SearchDetailView: View{
    let movie: Movie?
    init(movie:Movie) {
        self.movie = movie
        print("Network Request to fetch detail movie info")
    }
    @State private var isOn = false
    var body: some View{
        VStack {
            Button("Hi") {
                print("Derp")
            }
            Text(movie?.name ?? "nil")
                .background(movie?.color)
            Button {
                print("Derp")
            } label: {
                HStack {
                    Text("Circle Button")
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(movie?.color)
                }.background(.black)
            }
            
            Toggle(isOn: $isOn) {
                Text("HI")
            }

        }
        
        
    }
}

////not really searchview
//struct SearchView: View {
//
//    @State var randomNumber = 0
//    init(randomNumber: Int = 0) {
//        self.randomNumber = randomNumber
//        print("SearchView Init")
//    }
//    var body: some View {
//        VStack {
//            HueView()
//            jackView
//            kokoView()
//            Text("Hello, Bran! \(randomNumber)").background(Color.random())
//
//            //bran만 바뀌길 원하는데 property, function으로 만든 뷰도 다시 그려진다.
//            Button("Click") {
//                randomNumber = Int.random(in: 1...100)
//            }
//
//        }
//    }
//
//    //property
//    var jackView: some View{
//        Text("Hello JAck").background(Color.random())
//    }
//
//    //function
//    func kokoView() -> some View{
//        Text("Hello koko").background(Color.random())
//    }
//}

//separate view
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

//상위 뷰 바디에서 다시 그릴 때 init은 호출 되지만 색은 왜 안바뀌나?
//바디는 연산 프로퍼티라서 별도로 동작한다
struct HueView: View {
    init() {
        print("Hue Init")
        //네트워크가 여기에 있다면? 계속 호출 될 것임
        print("Network Request")
    }
    var body: some View {
        Text("Hello, Hue!").background(Color.random())
    }
}


extension Color{
    static func random() -> Color{
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: .random(in: 0...1)
        )
    }
}

