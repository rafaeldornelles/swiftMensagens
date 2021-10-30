//
//  Mensagem.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 10/30/21.
//

import Foundation

struct Mensagem: Identifiable {
    var id = UUID()
    var conteudo: String
    var destinatario: Usuario
    var remetente: Usuario
    var hora: Date
    enum Status: String{
        case criado = "CRIADO"
        case enviado = "ENVIADO"
        case recebido = "RECEBIDO"
        case lido = "LIDO"
    }
    var status: Status
}
