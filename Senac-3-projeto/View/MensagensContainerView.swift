//
//  MensagensContainer.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 10/30/21.
//

import SwiftUI

struct MensagensContainerView: View {
    var mensagens: [Mensagem]
    var body: some View {
        ScrollView{
            ScrollViewReader{ reader in
                ForEach(0..<mensagens.count, id: \.self) { index in
                    let mensagem = mensagens[index]
                    let nextMensagem = index + 1 < mensagens.count ? mensagens[index + 1] : nil
                    let previousMensagem = index > 0 ? mensagens[index - 1] : nil
                    
                    
                    MensagemView(
                        usuario: mensagem.remetente.nome.contains("Rafael") ? nil : mensagem.remetente,
                        conteudo: mensagem.conteudo,
                        hora: dateToString(date: mensagem.hora),
                        status: mensagem.status.rawValue,
                        isFirstOfGroup: previousMensagem == nil || mensagem.remetente.id != previousMensagem?.remetente.id,
                        isLastOfGroup: nextMensagem == nil || mensagem.remetente.id != nextMensagem?.remetente.id)
                }.onChange(of: self.mensagens.count) { count in
                    reader.scrollTo(count - 1)
                }
            }
           
        }
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh mm a"
        return formatter.string(from: date)
    }
}

struct MensagensContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MensagensContainerView( mensagens: [])
    }
}
