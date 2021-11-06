//
//  ConversaView.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 11/6/21.
//

import SwiftUI

struct ConversasView: View {
    let nomeConversa: String
    let nomeUltimoRemetente: String
    let conteudo: String
    let hora: String
    let countMensagensNaoLidas: Int
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(nomeConversa)
                    .font(.title2)
                    .fontWeight(.medium)
                Text("\(nomeUltimoRemetente): \(conteudo)")
                    .font(.body)
                    .lineLimit(1)
            }
            Spacer()
            VStack(alignment: .trailing){
                Text(hora)
                    .font(.caption)
                if countMensagensNaoLidas > 0 {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 20, height: 20)
                        .overlay(Text(String(countMensagensNaoLidas))
                                    .font(.caption))
                }
                
            }
        }
    }
}

struct ConversasView_Previews: PreviewProvider {
    static var previews: some View {
        
        ConversasView(nomeConversa: "Pedro", nomeUltimoRemetente: "Me", conteudo: "oi", hora: "14:55", countMensagensNaoLidas: 1)
    }
}
