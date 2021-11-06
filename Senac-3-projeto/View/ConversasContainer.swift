//
//  ConversaContainer.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 11/6/21.
//

import SwiftUI

struct ConversasContainer: View {
    
    @ObservedObject var viewModel: MensagensViewModel = MensagensViewModel()
    
    var body: some View{
        List(self.viewModel.conversas){ conversa in
            NavigationLink(destination: TelaMensagens(
                    mensagem: "",
                    mensagens: viewModel.containerMensagens.mensagens.filter{ mensagem in
                    conversa.usuarios.allSatisfy { usuario in
                        mensagem.usuarios.contains(usuario)
                    }
            }
            )){
                ConversasView(
                    nomeConversa: conversa.usuarios.map{ usuario in usuario.nome}.joined(separator: ", "),
                    nomeUltimoRemetente: conversa.ultimaMensagem?.remetente.nome ?? "",
                    conteudo: conversa.ultimaMensagem?.conteudo ?? "",
                    hora: dateToString(date: conversa.ultimaMensagem?.hora ?? Date()),
                    countMensagensNaoLidas: conversa.countMensagensNaoLidas)
            }
        }.toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button("Configurar"){
                    //TODO: configurar dados do usuario
                }
            }
            ToolbarItem(placement: .navigationBarTrailing){
                Button("Nova Conversa"){
                    //TODO: Iniciar uma nova conversa
                }
            }
        }
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        if Calendar.current.isDateInToday(date) {
            formatter.dateFormat = "hh mm a"
        } else{
            formatter.dateFormat = "dd MM yyyy"
        }
        return formatter.string(from: date)
    }

}


struct ConversasContainer_Preview: PreviewProvider {
    static var previews: some View{
        ConversasContainer()
    }
}
