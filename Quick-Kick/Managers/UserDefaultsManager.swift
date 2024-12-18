//
//  UserDefaultsManager.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/18/24.
//

import Foundation

// MARK: - Protocol
protocol UserDataManageable {
    func saveUser(_ user: User)
    func getUser() -> User?
    var isLoggedIn: Bool { get set }
    var autoLoginOption: Bool { get set }
    var rememberIDOption: Bool { get set }
    func setLoggedOut()
}

// MARK: - Protocol Extension
extension UserDataManageable {
    func saveUser(_ user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: "user")
        }
    }

    func getUser() -> User? {
        if let data = UserDefaults.standard.data(forKey: "user"),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            return user
        }
        return nil
    }

    func setLoggedOut() {
        UserDefaults.standard.set(false, forKey: "LoginStatus")
    }

    var isLoggedIn: Bool {
        get { UserDefaults.standard.bool(forKey: "LoginStatus") }
        set { UserDefaults.standard.set(newValue, forKey: "LoginStatus") }
    }

    var autoLoginOption: Bool {
        get { UserDefaults.standard.bool(forKey: "AutoLoginOption") }
        set { UserDefaults.standard.set(newValue, forKey: "AutoLoginOption") }
    }

    var rememberIDOption: Bool {
        get { UserDefaults.standard.bool(forKey: "RememberIDOption") }
        set { UserDefaults.standard.set(newValue, forKey: "RememberIDOption") }
    }
}

// MARK: - User Struct
struct User: Codable {
    var email: String
    var password: String
    var nickName: String = "User1"
}

// MARK: - UserDefaultsManager
final class UserDefaultsManager: UserDataManageable {
    static let shared = UserDefaultsManager()
    private init() {}
}
