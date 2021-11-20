//
//  UsuariosViewModel.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 11/20/21.
//

import Foundation
import FirebaseFirestore

class UsuariosViewModel: ObservableObject {
    @Published var containerUsuarios = ContainerUsuarios()
    
    init() {
        fetchUsuarios()
    }
    
    private var db = Firestore.firestore()
    func fetchUsuarios(){
        db.collection("usuarios").addSnapshotListener{ querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.containerUsuarios.usuarios = documents.map{ (queryDocumentSnapshot) -> Usuario in
                let data = queryDocumentSnapshot.data()
                return Usuario(data: data)
    
            }
        }
    }
    
    func addUsuario(nome: String, numero: String, callback: @escaping () -> Void){
        db.collection("usuarios").whereField("numero", isEqualTo: numero).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Erro ao buscar usuario: \(error)")
                return
            }
            if let q = querySnapshot, !q.isEmpty {
                let data = q.documents[0].data()
                var usuarioEncontrado = Usuario(data: data)
                usuarioEncontrado.nome = nome
                self.db.collection("usuarios").document(usuarioEncontrado.id.uuidString).setData(usuarioEncontrado.toDict())
                setUserDefaultsInfo(id: usuarioEncontrado.id.uuidString, nome: usuarioEncontrado.nome, numero: usuarioEncontrado.numero)
                callback()
            } else {
                let novoUsuario = Usuario(nome: nome, numero: numero)
                self.db.collection("usuarios").document(novoUsuario.id.uuidString).setData(novoUsuario.toDict())
                setUserDefaultsInfo(id: novoUsuario.id.uuidString, nome: novoUsuario.nome, numero: novoUsuario.numero)
                callback()
            }
        }
    }
}
