//
//  UserService.swift
//  AppTopCar
//
//  Created by Idwall Go Dev 008 on 31/03/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserService: UserServiceProtocol {
    
    static var shared: UserService {
        let instance = UserService()
        return instance
    }
    
    func signIn(user: User, completion: @escaping completion) {
        
        Auth.auth().signIn(withEmail: user.email, password: user.password) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completion(.failure(.error("Error ao Fazer Login, e-mail ou senha incorreto")))
            } else {
                let db = Firestore.firestore()
                db.collection("users").document(result!.user.uid).getDocument { result, error in
                    if error != nil {
                        print("erro ao logar")
                    } else {
                        completion(.success(User(id: "", fullname: result!.get("fullname") as! String, email: user.email, password: "")))
                    }
                }
                
            }
        }
    }
    
    func signUp(user: User, completion: @escaping completion) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                let db = Firestore.firestore()
                db.collection("users").document(result!.user.uid).setData([
                    "fullname": user.fullname, "uid": result!.user.uid
                ]) { error in
                    if error != nil {
                        completion(.failure(.error("Error ao conectar o servidor")))
                    }
                }
                //self.infoUser = User(id: "", fullname: user.fullname, email: user.email, password: "")
                completion(.success(User(id: "", fullname: user.fullname, email: user.email, password: "")))
            }
        }
    }
    
    func forgot(email: String, completion: @escaping completion) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                completion(.failure(.error("E-mail não existe")))
            } else {
                completion(.success(User(id: "", fullname: "", email: email, password: "")))
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "keyUserEmail")
            UserDefaults.standard.removeObject(forKey: "keyUserName")
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}
