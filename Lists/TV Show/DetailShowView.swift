
//
//  DetailMangaView.swift
//  Lists
//
//  Created by Aarish Rahman on 08/08/21.
//

import SwiftUI
import CoreData

struct DetailShowView: View{
    
    @ObservedObject var show: TvShow
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    //@FetchRequest(entity: Manga.entity(), sortDescriptors: []) var manga: FetchedResults<Manga>
    
    @State private var episode: Int16 = 0
    @State private var rating: Int16 = 0
    @State private var review = ""
    @State private var type = ""
    
    
    let types = ["Watching","On hold","Dropped","Completed","ReWatching","Plan to Watch"]
    
    var body: some View {
        VStack{
            Form{
                Stepper(value:$episode, step: 1){
                    Text("\(episode) Chapters")
                }
                Section{
                    Stepper(value:$rating,in: 0...10, step: 1){
                        HStack{
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(rating)")
                        }
                    }
                }
                Picker("Select", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 50, alignment: .center)
                    
                
                Section{
                    Text("Review")
                    TextEditor(text: $review)
                        .frame(height: 170)
                        .disableAutocorrection(true)
                        
                    
                }
                
            }
        }
        .onAppear{self.episode = self.show.episode
            self.rating = self.show.rating
            self.type = self.show.type ?? "-"
            self.review = self.show.review ?? "-"
        }
        .onDisappear(perform: saveChanges)
        .navigationBarTitle("\(show.name ?? "-")",displayMode: .inline)
        
        
    }
    func saveChanges(){
        show.episode = episode
        show.rating = rating
        show.review = review
        show.type = type
        try? self.moc.save()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    
}

struct DetailShowView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let show = TvShow(context: moc)
        show.name = "Anime"
        show.episode = 0
        show.rating = 0
        show.type = "Watching"
        show.review = "ok"
        
        return NavigationView {
                    DetailShowView(show: show)
                }
    }
}
