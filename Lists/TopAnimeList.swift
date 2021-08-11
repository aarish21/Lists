//
//  TopAnimeList.swift
//  Lists
//
//  Created by Aarish Rahman on 11/08/21.
//

import SwiftUI
struct TopData: Codable {
    
    var top: [TopAnime]
    
}
struct TopAnime: Codable {
    var title: String
    var rank: Int
    var episodes: Int
    var score: Double
    var start_date: String
    
}

struct TopAnimeList: View {
    @State private var results = [TopAnime]()
    var body: some View {
        
        List(results, id: \.rank) { item in
            VStack(alignment: .leading){
                
                HStack {
                    Text("\(item.rank).")
                    Text("\(item.title)")
                        .font(.title2)
                        .foregroundColor(.orange)
                }
                Text("     Aired \(item.start_date)")
                Text("     Rating \(String(item.score))")
                    .foregroundColor(.secondary)
                Text("     Episodes: \(item.episodes)")
                    .foregroundColor(.secondary)
                
            }.navigationBarTitle("Top Anime",displayMode: .inline)
        }
        .onAppear(perform: topAnime)
        
        
        
        
        
    }
    func topAnime(){
        guard let url = URL(string: "https://api.jikan.moe/v3/top/anime/1") else {
            print("error")
            return
        }
       
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data{
                if let decodedResponse = try? JSONDecoder().decode(TopData.self, from: data){
                    DispatchQueue.main.async {
                        self.results = decodedResponse.top
                    }
                }
                return
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
    }
}

struct TopAnimeList_Previews: PreviewProvider {
    static var previews: some View {
        TopAnimeList()
    }
}
