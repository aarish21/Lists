//
//  DetailMangaView.swift
//  Lists
//
//  Created by Aarish Rahman on 08/08/21.
//

import SwiftUI
import CoreData

struct DetailMangaView: View{
    
    @ObservedObject var manga: Manga
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    //@FetchRequest(entity: Manga.entity(), sortDescriptors: []) var manga: FetchedResults<Manga>
    
    @State private var chapters: Int16 = 0
    @State private var rating: Int16 = 0
    @State private var review = ""
    @State private var type = ""
    
    
    let types = ["Reading","On hold","Dropped","Completed","Rereading","Plan to read"]
    
    var body: some View {
        VStack{
            Form{
                Stepper(value:$chapters, step: 1){
                    Text("\(chapters) Chapters")
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
        .onAppear{self.chapters = self.manga.chapters
            self.rating = self.manga.rating
            self.type = self.manga.type ?? "-"
            self.review = self.manga.review ?? "-"
        }
        .onDisappear(perform: saveChanges)
        .navigationBarTitle("\(manga.name ?? "-")",displayMode: .inline)
        
        
    }
    func saveChanges(){
        manga.chapters = chapters
        manga.rating = rating
        manga.review = review
        manga.type = type
        try? self.moc.save()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    
}

struct DetailMangaView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let manga = Manga(context: moc)
        manga.name = "Manga"
        manga.chapters = 0
        manga.rating = 0
        manga.type = "reading"
        manga.review = "ok"
        
        return NavigationView {
                    DetailMangaView(manga: manga)
                }
    }
}
