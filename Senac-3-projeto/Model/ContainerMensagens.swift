//
//  ContainerMensagens.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 10/30/21.
//

import Foundation

struct ContainerMensagens {
    var mensagens = [
        Mensagem(conteudo: "oi", destinatario: ContainerUsuarios.usuarios.first!, remetente: ContainerUsuarios.usuarios.last!, hora: Date(), status: .lido),
        Mensagem(conteudo: "oi, tudo bem?", destinatario: ContainerUsuarios.usuarios.last!, remetente: ContainerUsuarios.usuarios.first!, hora: Date().addingTimeInterval(120), status: .lido),
        Mensagem(conteudo: "Vai vir para a aula de hoje?", destinatario: ContainerUsuarios.usuarios.first!, remetente: ContainerUsuarios.usuarios.last!, hora: Date().addingTimeInterval(120 * 2), status: .lido),
        Mensagem(conteudo: "Estou meio doente, dai não sei se vou", destinatario: ContainerUsuarios.usuarios.first!, remetente: ContainerUsuarios.usuarios.last!, hora: Date().addingTimeInterval(120 * 3), status: .recebido),
        Mensagem(conteudo: "O que voce acha?", destinatario: ContainerUsuarios.usuarios.first!, remetente: ContainerUsuarios.usuarios.last!, hora: Date().addingTimeInterval(120 * 4), status: .recebido),
    ]
}
