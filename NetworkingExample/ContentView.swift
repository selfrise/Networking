//
//  ContentView.swift
//  NetworkingExample
//
//  Created by OO E on 1.05.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel

    init() {
        self.viewModel = ContentViewModel()
    }
    
    var body: some View {
        
        VStack {
            
            Button("Test Request 1") {
                
                self.viewModel.getMyWordsList()
                
            }.padding(.all)
            
            Button("Test Request 2") {
                
            }.padding(.all)
            
            
            
            Text("Count \(viewModel.count)")
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
