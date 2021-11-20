//
//  UserDefaultsHelper.swift
//  Senac-3-projeto
//
//  Created by IOS SENAC on 11/20/21.
//

import Foundation

private let ud = UserDefaults.standard

func setUserDefaultsInfo(id: String, nome: String, numero: String){
    ud.setValue(id, forKey: "id")
    ud.setValue(nome, forKey: "nome")
    ud.setValue(numero, forKey: "numero")
}

func getUserDefaultsInfo() -> Usuario? {
    if let idString = ud.string(forKey: "id"), let id = UUID(uuidString: idString), let nome = ud.string(forKey: "nome"), let numero = ud.string(forKey: "numero"){
        return Usuario(id: id, nome: nome, numero: numero)
    }else{
        return nil
    }
}
