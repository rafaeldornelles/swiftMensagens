//
//  MensagensViewModel.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 11/6/21.
//

import Foundation
import FirebaseFirestore

class MensagensViewModel: ObservableObject {
    
    static var usuario: Usuario?
    
    private var db = Firestore.firestore()
    
    var containerMensagens = ContainerMensagens()
    
    var conversas: [Conversa] {
        guard let usuarioLogado = MensagensViewModel.usuario else {
            return []
        }
        let conversasDict = Dictionary(grouping: self.containerMensagens.mensagens, by: {$0.usuarios})
        return conversasDict.map{ key, value in
            return Conversa(
                usuarios: key.filter{ usuario in usuario != usuarioLogado },
                ultimaMensagem: value.sorted(by: { fist, second in
                    return fist.hora > second.hora
                }).last,
                countMensagensNaoLidas: value.filter{ mensagem in mensagem.status != .lido}.count
            )
        }
    }
    
    func fetchUserMessages(){
        guard let usuario = MensagensViewModel.usuario else {
            print("Nenhum usuario setado")
            return
        }
        
        db.collection("mensagens").whereField("usuarios", arrayContains: usuario).addSnapshotListener{ querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.containerMensagens.mensagens = documents.map{ (queryDocumentSnapshot) -> Mensagem in
                let data = queryDocumentSnapshot.data()
                return Mensagem(data: data)
            }
        }
    }
    
    func addMessage(mensagem: Mensagem) {
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
        self.id = data["id"] as? UUID ?? UUID()
        self.conteudo = data["conteudo"] as? String ?? ""
        
        let remetenteData = data["remetente"] as! [String: Any]
        let usuariosData = data["usuarios"] as! [[String: Any]]
        
        self.remetente = Usuario(data: remetenteData)
        self.usuarios = usuariosData.map{ usuarioData in
            return Usuario(data: usuarioData)
        }
        self.hora = data["hora"] as! Date //TODO: Remover cast forçado
        self.status = data["status"] as! Status //TODO: Remover cast forçado
    }
    
    func toDict() -> [String: Any]{
        return [
            "id" : self.id.uuidString,
            "conteudo" : self.conteudo,
            "hora": self.hora,
            "status": self.status,
            "remetente": self.remetente.toDict(),
            "usuarios": [
                self.usuarios.map{ usuario in
                    return usuario.toDict
                }
            
            ]
        ]
    }
}

extension Usuario{
    init(data: [String: Any]) {
        self.id = data["id"] as! UUID //TODO: Remover cast forçado
        self.nome = data["nome"] as? String ?? ""
        self.numero = data["numero"] as? String ?? ""
    }
    
    func toDict() -> [String: Any]{
        return [
            "id": self.id,
            "nome": self.nome,
            "numero": self.numero
        ]
    }
}
