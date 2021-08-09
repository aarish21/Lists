//
//  MangaList.swift
//  Lists
//
//  Created by Aarish Rahman on 08/08/21.
//

import SwiftUI

struct MangaList: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Manga.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Manga.name, ascending: true),
        NSSortDescriptor(keyPath: \Manga.chapters, ascending: true),
        
    ]) var manga: FetchedResults<Manga>

    @State private var showingAddScreen = false
   
    
    var body: some View {
        
                List{
                    ForEach(manga,id: \.self){manga in
                        NavigationLink(destination: DetailMangaView(manga: manga)){
                            VStack(alignment: .leading){
                                HStack(alignment: .top){
                                   
                                    Text(manga.name ?? "Unknown")
                                        .font(.title)
                                    Spacer()
                                    VStack{
                                        Text("Ch \(manga.chapters)")
                                            .font(.subheadline)
                                            .multilineTextAlignment(.trailing)
                                            .foregroundColor(.secondary)
                                        HStack{
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                            Text("\(manga.rating)/10")
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
                .navigationBarTitle("Manga")
                .listStyle(PlainListStyle())
                .navigationBarItems(trailing:
                HStack{
                    EditButton()
                        .accentColor(.red)
                    Button(action: {
                    self.showingAddScreen.toggle()
                }) {
                    Image(systemName: "plus")
                }})
                .sheet(isPresented: $showingAddScreen) {
                    AddManga().environment(\.managedObjectContext, self.moc)
                }
                
                
        
    }
    func removeItems(at offsets: IndexSet){
        for offset in offsets{
            let book = manga[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
}

struct MangaList_Previews: PreviewProvider {
    static var previews: some View {
        MangaList()
    }
}
