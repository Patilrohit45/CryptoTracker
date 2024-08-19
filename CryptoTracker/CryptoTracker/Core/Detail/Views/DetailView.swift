//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Rohit Patil on 18/08/24.
//

import SwiftUI


struct DetailLoadingView:View {
    @Binding var coin:CoinModel?
    
    var body: some View {
        ZStack{
            if let coin = coin {
               DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject private var vm : DetailViewModel
    private let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing:CGFloat = 30
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing Detail View for \(coin.name)")
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing:20){
                Text("")
                    .frame(height:150)
                
                overviewTitle
                Divider()
                
                overviewGrid
                
                additionalTitle
                Divider()
                
                additionalGrid
            }
        }
        .padding()
        .navigationTitle(vm.coin.name)
    }
}

struct DetailView_Previews:PreviewProvider{
    static var previews: some View{
        NavigationView{
            DetailView(coin: dev.coin)
        }
    }
}

extension DetailView{
    
    private var overviewTitle:some View{
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accentColor)
            .frame(maxWidth:.infinity,alignment: .leading)
    }
    
    private var additionalTitle:some View{
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accentColor)
            .frame(maxWidth:.infinity,alignment: .leading)
    }
    
    private var overviewGrid:some View{
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.overviewStatistics){ stats in
                    StatisticView(stat: stats)
                }
            })
    }
    
    private var additionalGrid:some View{
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.additionalStatistics){ stats in
                    StatisticView(stat: stats)
                }
            })
    }

    
}
