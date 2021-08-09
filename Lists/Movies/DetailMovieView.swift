
//
//  DetailMangaView.swift
//  Lists
//
//  Created by Aarish Rahman on 08/08/21.
//

import SwiftUI
import CoreData

struct DetailMovieView: View{
    
    @ObservedObject var movie: Movie
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    //@FetchRequest(entity: Manga.entity(), sortDescriptors: []) var manga: FetchedResults<Manga>
    
   
    @State private var rating: Int16 = 0
    @State private var review = ""
    
    
    
   
    var body: some View {
        VStack{
            Form{
                
                Section{
                    Stepper(value:$rating,in: 0...10, step: 1){
                        HStack{
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(rating)")
                        }
                    }
                }
                
                
                Section{
                    Text("Review")
                    TextEditor(text: $review)
                        .frame(height: 170)
                        .disableAutocorrection(true)
                        
                    
                }
                
            }
        }
        .onAppear{
            self.rating = self.movie.rating
            
            self.review = self.movie.review ?? "-"
        }
        .onDisappear(perform: saveChanges)
        .navigationBarTitle("\(movie.name ?? "-")",displayMode: .inline)
        
        
    }
    func saveChanges(){
        
        movie.rating = rating
        movie.review = review
        
       
        try? self.moc.save()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    
}

struct DetailMovieView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let movie = Movie(context: moc)
        movie.name = "Anime"
        
        movie.rating = 0
       
        movie.review = "ok"
        
        return NavigationView {
                    DetailMovieView(movie: movie)
                }
    }
}
