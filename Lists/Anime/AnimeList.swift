//
//  AnimeList.swift
//  Lists
//
//  Created by Aarish Rahman on 08/08/21.
//

import SwiftUI

struct AnimeList: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Anime.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Anime.name, ascending: true),
        NSSortDescriptor(keyPath: \Anime.episode, ascending: true)
    ]) var anime: FetchedResults<Anime>

    @State private var showingAddScreen = false
    
    var body: some View {
        
                List{
                    ForEach(anime,id: \.self){anime in
                        NavigationLink(destination: DetailAnimeView(anime: anime)){
                            VStack(alignment: .leading){
                                HStack(alignment: .top){
                                    Text(anime.name ?? "Unknown")
                                        .font(.title)
                                    Spacer()
                                    VStack{
                                        Text("Ep \(anime.episode)")
                                            .font(.subheadline)
                                            .multilineTextAlignment(.trailing)
                                            .foregroundColor(.secondary)
                                        HStack{
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                            Text("\(anime.rating)/10")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                            }
                            .frame(height: 50)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                .navigationBarTitle("Anime")
                .listStyle(PlainListStyle())
                .navigationBarItems(trailing:HStack{ EditButton().accentColor(.red); Button(action: {
                    self.showingAddScreen.toggle()
                }) {
                    Image(systemName: "plus")
                }})
                .sheet(isPresented: $showingAddScreen) {
                    AddAnime().environment(\.managedObjectContext, self.moc)
                }
                
                
                
        
    }
    func removeItems(at offsets: IndexSet){
        for offset in offsets{
            let book = anime[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
}

struct AnimeList_Previews: PreviewProvider {
    static var previews: some View {
        AnimeList()
    }
}
