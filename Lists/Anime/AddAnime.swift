//
//  AddAnime.swift
//  Lists
//
//  Created by Aarish Rahman on 07/08/21.
//

import SwiftUI
import AYPopupPickerView

struct AddAnime: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var episode = 0
    @State private var rating = 0
    @State private var review = ""
    @State private var type = ""
    
    let types = ["Watching","On hold","Dropped","Completed","ReWatching","Plan to Watch"]
    
    let popupPickerView = AYPopupPickerView()
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Name of Anime", text: $name)
                    .disableAutocorrection(true)
                //MARK:- Pickers
                Section {
                    Picker("Select", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section{
                    HStack{
                        Text("Episodes")
                                  .font(.headline)
                       Spacer()
                        Picker("Episodes", selection: $episode) {
                            ForEach(0..<2000){
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 100,height: 40, alignment: .center)
                        .clipped()
                        .compositingGroup()
                        
                    }
                }
                Section{
                        Picker("Rating",selection: $rating){
                            ForEach(0..<11){i in
                                HStack{
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    Text(" \(i)")
                                }
                            }
                        }
                }
                //MARK:- Review
                Section{
                    Text("Review")
                    TextEditor(text: $review)
                        .frame(height: 170)
                        .disableAutocorrection(true)
                        
                    
                }
                
            }
            .navigationBarItems(trailing:
             Button("Save") {
                let newManga = Anime(context: self.moc)
                newManga.name = self.name
                newManga.type = self.type
                newManga.episode = Int16(self.episode)
                newManga.rating = Int16(self.rating)
                newManga.review = self.review
                newManga.date = Date()
                try? self.moc.save()
                
                self.presentationMode.wrappedValue.dismiss()
                
            })
        }
    }
}

struct AddAnime_Previews: PreviewProvider {
    static var previews: some View {
        AddAnime()
    }
}

