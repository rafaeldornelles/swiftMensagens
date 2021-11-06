//
//  TelaMensagens.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 11/6/21.
//

import SwiftUI

struct TelaMensagens: View {
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
                                        usuarios: [ContainerUsuarios.usuarios.first!, ContainerUsuarios.usuarios.last!],
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

struct TelaMensagens_Previews: PreviewProvider {
    static var previews: some View {
        TelaMensagens()
    }
}
