//
//  MensagensViewModel.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 11/6/21.
//

import Foundation
import FirebaseFirestore

class MensagensViewModel: ObservableObject {
        
    private var db = Firestore.firestore()
    
    @Published private var containerMensagens = ContainerMensagens()
    
    var mensagens: [Mensagem] {
        return containerMensagens.mensagens
    }
    
    var conversas: [Conversa] {
        return containerMensagens.conversas
    }
    
    init() {
        fetchUserMessages()
    }
    
    func mensagensByUsuarios(usuarios: [Usuario]) -> [Mensagem]{
        let mensagensUsuario: [Mensagem] = self.containerMensagens.mensagens
        let usuariosOrdenados = usuarios.sorted(by: { $0.nome < $1.nome})

        return mensagensUsuario.filter{ mensagem in
            let usuariosMensagem = mensagem.usuarios.sorted(by: {$0.nome < $1.nome})
            return usuariosOrdenados == usuariosMensagem
        }
    }
    
    func updateUsuario(){
        containerMensagens.mensagens = []
        fetchUserMessages()
    }
    
    func fetchUserMessages(){
        guard let usuario = getUserDefaultsInfo() else {
            print("Nenhum usuario setado")
            return
        }
        print(usuario.toDict())
        
        db.collection("mensagens").addSnapshotListener{ querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.containerMensagens.mensagens = documents.map{ (queryDocumentSnapshot) -> Mensagem in
                let data = queryDocumentSnapshot.data()
                return Mensagem(data: data)
            }.filter{ mensagem in
                mensagem.usuarios.contains(usuario)
            }.sorted(by: {$0.hora < $1.hora})
        }
    }
    
    func sendMensagem(mensagem: Mensagem) {
        print(mensagem.toDict())
        db.collection("mensagens").document(mensagem.id.uuidString).setData(mensagem.toDict()){ err in
            if let err = err {
                print("Erro ao inserir mensagem: \(err)")
            } else {
                print("Mensagem enviada com sucesso")
            }
        }
    }
    
}

extension Mensagem{
    init(data: [String: Any]) {
        self.id = UUID(uuidString: data["id"] as! String) ?? UUID()
        self.conteudo = data["conteudo"] as? String ?? ""
        
        let remetenteData = data["remetente"] as! [String: Any]
        let usuariosData = data["usuarios"] as! [String: [String: Any]]
        
        self.remetente = Usuario(data: remetenteData)
        self.usuarios = []

        let horaTimeStamp = data["hora"] as! Double
        self.hora = Date(timeIntervalSince1970: horaTimeStamp)
        self.status = Status(rawValue: data["status"] as! String)!  //TODO: Remover cast forçado
        usuariosData.values.forEach{ usuarioData in
            self.usuarios.append(Usuario(data: usuarioData))
        }
    }
    
    func toDict() -> [String: Any]{
        var mapUsuarios: [String: Any] = [:]
        self.usuarios.forEach{ usuario in
            mapUsuarios[usuario.id.uuidString] = usuario.toDict()
        }
        return [
            "id" : self.id.uuidString,
            "conteudo" : self.conteudo,
            "hora": self.hora.timeIntervalSince1970,
            "status": self.status.rawValue,
            "remetente": self.remetente.toDict(),
            "usuarios": mapUsuarios
        ]
    }
}

extension Usuario{
    init(data: [String: Any]) {
        self.id = UUID(uuidString: data["id"] as! String) ?? UUID() //TODO: Remover cast forçado
        self.nome = data["nome"] as? String ?? ""
        self.numero = data["numero"] as? String ?? ""
    }
    
    func toDict() -> [String: Any]{
        return [
            "id": self.id.uuidString,
            "nome": self.nome,
            "numero": self.numero
        ]
    }
}
