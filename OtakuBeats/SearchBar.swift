//
//  SearchBar.swift
//  OtakuBeats
//
//  Created by Derrick on 5/15/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: {
                searchText = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
        }
    }
}


//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar()
//    }
//}
