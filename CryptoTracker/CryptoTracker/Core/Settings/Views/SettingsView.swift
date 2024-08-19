//
//  SettingsView.swift
//  CryptoTracker
//
//  Created by Rohit Patil on 19/08/24.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string:"https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/c/swiftuithinking")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let linkedinURL = URL(string: "https://www.linkedin.com/in/rohit-patil-1ba06b1b5?")!
    let instagramURL = URL(string: "https://www.instagram.com/rohit.patil45?igsh=MWNicmxvNTRibW5zNw%3D%3D&utm_source=qr")!
    
    var body: some View {
        NavigationView{
            List{
                coinGeckoSection
                profileSection
                developerSection
                applicationSection
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    XmarkButton()
                }
            }
        }
    }
}

struct SettingsView_Previews:PreviewProvider{
    static var previews: some View{
        SettingsView()
    }
}


extension SettingsView{
    
    private var coinGeckoSection: some View{
        Section(header: Text("CoinGecko")) {
            VStack(alignment:.leading){
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data that is used in this app comes form a free API from CoinGecko! Price may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accentColor)
            }
            .padding()
            Link("Visit CoinGecko 🥳 ",destination: coingeckoURL)
        }

    }
    
    private var profileSection: some View{
        Section(header: Text("ROHIT PATIL")) {
            VStack(alignment:.leading){
                Image("Rohit")
                    .resizable()
                   // .scaledToFit()
                    .frame(width:75,height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("I am Rohit Patil, Am an iOS developer with 3 years of experience in iOS and development.")
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accentColor)
            }
            .padding()
            Link("Connect me on Linkedin 💻 ",destination: linkedinURL)
            Link("Follow me on Instagram 📱",destination: instagramURL)
        }

    }

    private var developerSection: some View{
        Section(header: Text("Swiftful Thininking")) {
            VStack(alignment:.leading){
                Image("logo")
                    .resizable()
                    .frame(width:100,height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This App was made by following a @SwiftuiThinking course on Youtube. It uses MVVM Architecture,Combine, and CoreData!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accentColor)
            }
            .padding()
            Link("Subscribe on Youtube 🥳 ",destination: youtubeURL)
        }

    }
    
    private var applicationSection:some View{
        Section(header: Text("Application")) {
            Link("Visit Website",destination: defaultURL)
            Link("Privacy Policy",destination: defaultURL)
            Link("Company Website",destination: defaultURL)
            Link("Learn More",destination: defaultURL)
        }
    }

}
