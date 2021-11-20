//
//  NovaConversaListaUsuariosView.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 11/20/21.
//

import SwiftUI

struct NovaConversaListaUsuariosView: View {
    
    @ObservedObject var usuariosViewModel = UsuariosViewModel()
    @ObservedObject var mensagensViewModel: MensagensViewModel
    var body: some View {
        List(usuariosViewModel.containerUsuarios.usuarios){ usuario in
            NavigationLink(destination: TelaMensagens(
                mensagensViewModel: mensagensViewModel, usuarios: [getUserDefaultsInfo()!, usuario], remetente: getUserDefaultsInfo()!
            )){
                VStack(alignment: .leading){
                    Text(usuario.nome)
                    Text(usuario.numero)
                }
            }
        }.navigationTitle("Usuários")
    }

}

struct NovaConversaListaUsuariosView_Previews: PreviewProvider {
    static var previews: some View {
        NovaConversaListaUsuariosView( mensagensViewModel: MensagensViewModel())
    }
}
