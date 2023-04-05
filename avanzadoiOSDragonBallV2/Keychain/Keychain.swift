//
//  Keychain.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 5/4/23.
//

import Foundation
import Security

import UIKit

class KeychainManager {

    /*partiendo de lo trabajamos en clase adaptamos a nuestras necesidades*/
    
    func deleteData(){
        //definimos un usuario
        //let username = "markel"
        
        //preparamos la consulta
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "token"
        ]
        //ejecutamos la consulta para eliminar
        if (SecItemDelete(query as CFDictionary)) == noErr {
            debugPrint("informacion usuario eliminada con éxito")
        } else {
            debugPrint("erro al eliminar información usuario")
        }
        
    }
    
    func updateData(_ token: String) -> Bool{
        //let username = "markel"
        //let password = "789123".data(using: .utf8)!
        
        //preparamos la consulta
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "token"
        ]
        
        let attributes: [String: Any] = [
            kSecValueData as String : token.data(using: .utf8)!
        ]
        
        if(SecItemUpdate(query as CFDictionary, attributes as CFDictionary)) == noErr {
            debugPrint("informacion del usuario actualizada con éxito")
            return true
        } else {
            debugPrint("error al actualizar la informacion de usuario")
            return false
        }
        
    }
    
    func readData()-> String {
        ///Establece el usuario que queremos usarr
        //let username = "markel"
        
        //preparamos consulta
        let query : [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "token",
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        
        
        
        
        var item: CFTypeRef?
        
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr{
            
            //extraemos informacion
            if let existingItem = item as? [String: Any],
               let userTokenKey = existingItem[kSecAttrAccount as String] as? String,
               let passwordData = existingItem[kSecValueData as  String] as? Data,
               let token = String(data: passwordData, encoding: .utf8){
                
                debugPrint("la infor es : \(userTokenKey) - \(token)")
                return token
            }
            
            
            debugPrint("va bien")
        }
        debugPrint("error ")
        return "error readindKC data"
    }
    
    func saveData(_ token: String) {
        ///definimos usuario
        //let username = "markel"
        //let password = "123456".data(using: .utf8)!
        
        //preparamos los atributos necesarios
        let attributes: [String: Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String :  "token",
            kSecValueData as String : token.data(using: .utf8)!
        ]
        
        
        
        ///Guardar el usuario
        if  SecItemAdd(attributes as CFDictionary, nil) == noErr{
            debugPrint("información usuario guardada con éxito")
        } else {
            debugPrint("error al guardar información")
        }
    }


}
