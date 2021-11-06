//
//  Conversa.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 11/6/21.
//

import Foundation

struct Conversa: Identifiable {
    var id = UUID()
    var usuarios: [Usuario]
    var ultimaMensagem: Mensagem?
    var countMensagensNaoLidas: Int = 0
}
