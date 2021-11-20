//
//  TelaMensagens.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 11/6/21.
//

import SwiftUI

struct TelaMensagens: View {
    @State var mensagem: String = ""
    @ObservedObject var mensagensViewModel: MensagensViewModel
    let usuarios: [Usuario]
    let remetente: Usuario
    
    
    var body: some View {
        VStack{
            Spacer()
            MensagensContainerView(mensagens: mensagensViewModel.mensagensByUsuarios(usuarios: usuarios))
            HStack{
                TextField("Mensagem...", text: $mensagem)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Enviar"){
                    mensagensViewModel.sendMensagem(mensagem: Mensagem(
                        conteudo: mensagem,
                        usuarios: usuarios,
                        remetente: remetente,
                        hora: Date(),
                        status: .criado)
                    )
                    mensagem = ""
                }.disabled(mensagem.count <= 0)
                
            }
        }.padding()
    }

}

struct TelaMensagens_Previews: PreviewProvider {
    static var previews: some View {
        TelaMensagens(mensagensViewModel: MensagensViewModel(), usuarios: [Usuario(nome: "Rafael", numero: "51 99199-2306"), Usuario(nome: "João", numero: "51 99199-2307")], remetente: Usuario(nome: "Rafael", numero: "51 99199-2306"))
    }
}
