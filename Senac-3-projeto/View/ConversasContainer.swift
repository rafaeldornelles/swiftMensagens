//
//  ConversaContainer.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 11/6/21.
//

import SwiftUI

struct ConversasContainer: View {
    
    @ObservedObject var viewModel: MensagensViewModel = MensagensViewModel()
    
    @ObservedObject var usuariosViewModel = UsuariosViewModel()
    
    @State var isShowingConfiguration = false
    
    @State var nomeConfiguracao = ""
    @State var telefoneConfiguracao = ""
    

    
    var body: some View{
        List(self.viewModel.conversas){ conversa in
            NavigationLink(destination: TelaMensagens(
                            mensagensViewModel: viewModel, usuarios: getTodosUsuariosConversa(conversa: conversa), remetente: getUserDefaultsInfo()!)
            ){
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
                    showConfigAlert()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing){
                NavigationLink("Nova Conversa", destination: NovaConversaListaUsuariosView(mensagensViewModel: viewModel))
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
    
    func showConfigAlert(){
        var nomeTextField: UITextField? = nil
        var numeroTextField: UITextField? = nil
        let alert = UIAlertController(title: "Configuração", message: "Insira as suas informações", preferredStyle: .alert)
        alert.addTextField{ nome in
            nome.placeholder = "Nome"
            nome.text = nomeConfiguracao
            nomeTextField = nome
        }
        alert.addTextField{ numero in
            numero.placeholder = "Numero"
            numero.text = telefoneConfiguracao
            numero.keyboardType = .phonePad
            numeroTextField = numero
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel){ (_) in
            nomeConfiguracao = ""
            telefoneConfiguracao = ""
        }
        
        let save = UIAlertAction(title: "Salvar", style: .default){ (_) in
            usuariosViewModel.addUsuario(nome: nomeTextField!.text ?? "", numero: numeroTextField!.text ?? "", callback: {viewModel.updateUsuario()})
        }
        
        alert.addAction(cancel)
        alert.addAction(save)
        
        UIApplication.shared.windows.first!.rootViewController!.present(alert, animated: true, completion: nil)
    }
    
    func getTodosUsuariosConversa(conversa: Conversa) -> [Usuario]{
        var todosUsuarios = conversa.usuarios
        todosUsuarios.append(getUserDefaultsInfo()!)
        return todosUsuarios
    }

}


struct ConversasContainer_Preview: PreviewProvider {
    static var previews: some View{
        ConversasContainer()
    }
}
