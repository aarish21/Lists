//
//  AnimeList.swift
//  Lists
//
//  Created by Aarish Rahman on 08/08/21.
//

import SwiftUI

struct ShowList: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: TvShow.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \TvShow.name, ascending: true),
        NSSortDescriptor(keyPath: \TvShow.episode, ascending: true)
    ]) var show: FetchedResults<TvShow>

    @State private var showingAddScreen = false
    
    var body: some View {
        
                List{
                    ForEach(show,id: \.self){show in
                        NavigationLink(destination: DetailShowView(show: show)){
                            VStack(alignment: .leading){
                                HStack(alignment: .top){
                                    Text(show.name ?? "Unknown")
                                        .font(.title)
                                    Spacer()
                                    VStack{
                                        Text("Ep \(show.episode)")
                                            .font(.subheadline)
                                            .multilineTextAlignment(.trailing)
                                            .foregroundColor(.secondary)
                                        HStack{
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                            Text("\(show.rating)/10")
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
                .navigationBarTitle("Tv Shows")
                .listStyle(PlainListStyle())
                .navigationBarItems( trailing:HStack{ EditButton().accentColor(.red); Button(action: {
                    self.showingAddScreen.toggle()
                }) {
                    Image(systemName: "plus")
                }})
                .sheet(isPresented: $showingAddScreen) {
                    AddShow().environment(\.managedObjectContext, self.moc)
                }
                
                
        
    }
    func removeItems(at offsets: IndexSet){
        for offset in offsets{
            let book = show[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
}

struct AnimeShow_Previews: PreviewProvider {
    static var previews: some View {
        ShowList()
    }
}
