//
//  Usuario.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 10/30/21.
//

import Foundation

struct Usuario: Identifiable, Hashable{
    var id = UUID()
    var nome: String
    var numero: String
}
