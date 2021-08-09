//
//  AddAnime.swift
//  Lists
//
//  Created by Aarish Rahman on 07/08/21.
//

import SwiftUI
import AYPopupPickerView

struct AddMovie: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
   
    @State private var rating = 0
    @State private var review = ""
    
    
  
    var body: some View {
        NavigationView{
            Form {
                TextField("Name of Movie", text: $name)
                    .disableAutocorrection(true)
                //MARK:- Pickers
               
               
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
                
            }.navigationBarItems(trailing:
                Button("Save") {
                let newMovie = Movie(context: self.moc)
                newMovie.name = self.name
                newMovie.date = Date()
                newMovie.rating = Int16(self.rating)
                newMovie.review = self.review
                
                try? self.moc.save()
                
                self.presentationMode.wrappedValue.dismiss()
                
            })
        }
    }
}

struct AddMovie_Previews: PreviewProvider {
    static var previews: some View {
        AddMovie()
    }
}

