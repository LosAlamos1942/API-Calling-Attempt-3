//
//  ContentView.swift
//  API Calling Attempt 3
//
//  Created by Student on 2/17/22.
//

import SwiftUI

struct ContentView: View {
    @State private var IMDB = [IMDB]()
    @State private var showingAlert = false
    
    
    var body: some View {
        NavigationView {
            List(IMDB) { IMDB in
                NavigationLink(
                    destination: Text(IMDB.width)
                        .padding(),
                    label: {
                        Text(IMDB.imageURL)
                    })
            }
            .navigationTitle("IMDB Listing")
        }
        .onAppear(perform: {
            getIMDB()
        })
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text("Loading Error"),
                  message: Text("There was a problem loading the data"),
                  dismissButton: .default(Text("OK")))
        })
    }
    func getIMDB() {
        let apiKey = "?rapidapi-key=(e466d8cfeamsh994ebcf54622aeep17993cjsn2fbf6b8204a6)"
        
        let query = "https://rawg-video-games-database.p.rapidapi.com/games\(apiKey)"
        
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                if json["success"] == true {
                    let contents = json["body"].arrayValue
                    for item in contents {
                        let setup = item["imageURL"].stringValue
                        let width = item["width"].stringValue
                        let IMDB = IMDB(imageURL: imageURL, width: width)
                        IMDB.append(IMDB)
                    }
                    return
                }
            }
        }
        showingAlert = true
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
    struct IMDB: Identifiable {
        var id: ObjectIdentifier
        let height = UUID()
        var imageURL: String
        var width: String
    }
}
