//
//  MensagemView.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 10/30/21.
//

import SwiftUI

struct MensagemView: View {
    var usuario: Usuario?
    var conteudo: String
    
    var hora: String
    var status: String
    
    var isFirstOfGroup: Bool
    var isLastOfGroup: Bool
    
    var body: some View {
        HStack{
            
            if usuario == nil {
                Spacer(minLength: 50)
            }
            
            VStack(alignment: .leading){
                if(usuario != nil && isFirstOfGroup){
                    HStack{
                        Text(usuario!.numero)
                            .foregroundColor(Color.secondary)
                        Text(usuario!.nome)
                            .foregroundColor(.white)
                            .opacity(0.4)
                    }.font(.system(size: 10))
                }
                
                Text(conteudo)

                
                HStack{
                    Text(hora)
                    Text(status)
                }
                .font(.system(size: 10))
            }
            .padding(8)
            .foregroundColor(.white)
            .background(usuario == nil ? Color.green : Color.gray)
            .cornerRadius(10)
            .overlay(isLastOfGroup ? TriangleTip()
                        .fill(usuario == nil ? Color.green: Color.gray)
                        .rotation3DEffect(
                            .degrees(usuario == nil ? 0 : 180),
                            axis: (x:0, y:1, z:0) ) : nil
            )
    
            
            if usuario != nil{
                Spacer(minLength: 50)
            }

            
        }
    }
}


struct MensagemView_Previews: PreviewProvider {
    static var previews: some View {
        MensagemView(usuario: Usuario(nome: "Daniel", numero: "41 99199-2307"), conteudo: "AAAA", hora: "12:00", status: "Lido", isFirstOfGroup: true, isLastOfGroup: true)
    }
}
