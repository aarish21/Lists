//
//  MangaList.swift
//  Lists
//
//  Created by Aarish Rahman on 08/08/21.
//

import SwiftUI

struct Recents: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Manga.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Manga.date, ascending: false),
    ]) var manga: FetchedResults<Manga>
    @FetchRequest(entity: Anime.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Anime.date, ascending: false),
    ]) var anime: FetchedResults<Anime>
    @FetchRequest(entity: TvShow.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \TvShow.date, ascending: false),
    ]) var show: FetchedResults<TvShow>
    @FetchRequest(entity: Movie.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Movie.date, ascending: false),
    ]) var movie: FetchedResults<Movie>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        List{
            Section(header:Text("Manga")){
                ForEach(manga[0...3],id: \.self){manga in
                    NavigationLink(destination: DetailMangaView(manga: manga)){
                        VStack(alignment: .leading){
                            HStack{
                                Text(manga.name ?? "Unknown")
                                    .font(.title2)
                                    
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
                        .frame(height: 40)
                    }
                }
            }
            Section(header:Text("Anime")){
                ForEach(anime,id: \.self){anime in
                    NavigationLink(destination: DetailAnimeView(anime: anime)){
                        VStack(alignment: .leading){
                            HStack{
                                Text(anime.name ?? "Unknown")
                                    .font(.title2)
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
                        .frame(height: 40)
                    }
                }
            }
            Section(header:Text("Tv Shows")){
                ForEach(show,id: \.self){show in
                    NavigationLink(destination: DetailShowView(show: show)){
                        VStack(alignment: .leading){
                            HStack{
                                Text(show.name ?? "Unknown")
                                    .font(.title2)
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
                        .frame(height: 40)
                    }
                }
            }
            Section(header:Text("Movie")){
                ForEach(movie,id: \.self){movie in
                    NavigationLink(destination: DetailMovieView(movie: movie)){
                        VStack(alignment: .leading){
                            
                                Text(movie.name ?? "Unknown")
                                    .font(.title2)
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
            }
            
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle("Recents")
        
        
        
        
        
        
    }
    func removeItems(at offsets: IndexSet){
        for offset in offsets{
            let book = manga[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
}

struct Recents_Previews: PreviewProvider {
    static var previews: some View {
        MangaList()
    }
}

