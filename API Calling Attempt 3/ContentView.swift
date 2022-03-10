//
//  ContentView.swift
//  API Calling Attempt 3
//
//  Created by Student on 2/17/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    @State private var shows = [Show]()
    var body: some View {
        NavigationView {
            List(shows) { show in
                NavigationLink(
                    destination: VStack {
                        Text(show.actors)
                            .padding()
    
                    },
                    label: {
                        Text(show.title)
                    })
            }
            .navigationTitle("Listing of Shows")
        }
        .onAppear(perform: {
            getShow()
        })
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Loading Error"),
                  message: Text("There was a problem loading the data"),
                  dismissButton: .default(Text("OK")))
        }
        
    }
    func getShow() {
        let apiKey = "rapidapi-key=e466d8cfeamsh994ebcf54622aeep17993cjsn2fbf6b8204a6"
        let query = "https://imdb8.p.rapidapi.com/auto-complete/?q=Game%20of%20Thrones&\(apiKey)"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                let contents = json["d"].arrayValue
                for item in contents {
                    let title = item["l"].stringValue
                    let actors = item["s"].stringValue // (Add value to show destination. Reminder)
                    let show = Show(title: title, actors: actors)
                    shows.append(show)
                }
                return
            }
        }
        showingAlert = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct Show: Identifiable {
    let id = UUID()
    var title: String
    var actors: String
}




