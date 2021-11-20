//
//  ContentView.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 10/30/21.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        setUserDefaultsInfo(id: "921AB8B1-4231-4403-9021-B3E5FB89F7EA", nome: "Rafael", numero: "51 99199-2306")
    }

    var body: some View {
        NavigationView{
            ConversasContainer().navigationBarTitle("Minhas Conversas")
        }
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
