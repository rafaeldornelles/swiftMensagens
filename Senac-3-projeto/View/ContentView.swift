//
//  ContentView.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 10/30/21.
//

import SwiftUI

struct ContentView: View {
    @State var mensagem: String = ""
    @State var mensagens = ContainerMensagens().mensagens
    var body: some View {
        VStack{
            Spacer()
            MensagensContainer(mensagens: $mensagens)
            HStack{
                TextField("Mensagem...", text: $mensagem)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Enviar"){
                    mensagens.append(Mensagem(
                        conteudo: mensagem,
                        destinatario: ContainerUsuarios.usuarios.last!,
                        remetente: ContainerUsuarios.usuarios.first!,
                        hora: Date(),
                        status: .criado)
                    )
                    mensagem = ""
                }.disabled(mensagem.count <= 0)
                
            }
        }.padding()
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
