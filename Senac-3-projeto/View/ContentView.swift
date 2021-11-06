//
//  ContentView.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 10/30/21.
//

import SwiftUI

struct ContentView: View {
    @State var usuario = Usuario(nome: "Rafael", numero: "(51) 99199-2306") //TODO: UTILIZAR USERDEFAULTS

    init() {
        MensagensViewModel.usuario = usuario
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
