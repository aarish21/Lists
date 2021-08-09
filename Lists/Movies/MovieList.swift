
//
//  AnimeList.swift
//  Lists
//
//  Created by Aarish Rahman on 08/08/21.
//

import SwiftUI

struct MovieList: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Movie.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Movie.name, ascending: true),
        NSSortDescriptor(keyPath: \Movie.rating, ascending: true)
    ]) var movie: FetchedResults<Movie>

    @State private var showingAddScreen = false
    
    var body: some View {
        
        List{
            ForEach(movie,id: \.self){movie in
                NavigationLink(destination: DetailMovieView(movie: movie)){
                    VStack(alignment: .leading){
                        
                            Text(movie.name ?? "Unknown")
                                .font(.title)
                            Spacer()
                            HStack(alignment:.center){
                               
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text("\(movie.rating)/10")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                               
                            }
                        
                    }
                    .frame(height: 50)
                }
            }
            .onDelete(perform: removeItems)
        }
        .navigationBarTitle("Movies")
        .listStyle(PlainListStyle())
        .navigationBarItems( trailing:HStack{ EditButton().accentColor(.red); Button(action: {
            self.showingAddScreen.toggle()
        }) {
            Image(systemName: "plus")
        }})
        .sheet(isPresented: $showingAddScreen) {
            AddMovie().environment(\.managedObjectContext, self.moc)
        }
        
        
        
    }
    func removeItems(at offsets: IndexSet){
        for offset in offsets{
            let book = movie[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList()
    }
}
