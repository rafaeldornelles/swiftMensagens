//
//  ContainerMensagens.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 10/30/21.
//

import Foundation

struct ContainerMensagens {
    var mensagens: [Mensagem] = []
    
    var conversas : [Conversa] {
        guard let usuarioLogado = getUserDefaultsInfo() else {
            return []
        }
        let conversasDict = Dictionary(grouping: self.mensagens, by: {$0.usuarios.sorted(by: { $0.nome > $1.nome })})
        return conversasDict.map{ key, value in
            return Conversa(
                usuarios: key.filter{ usuario in usuario != usuarioLogado },
                ultimaMensagem: value.sorted(by: { fist, second in
                    return fist.hora < second.hora
                }).last,
                countMensagensNaoLidas: value.filter{ mensagem in mensagem.status != .lido}.count
            )
        }
    }
}
