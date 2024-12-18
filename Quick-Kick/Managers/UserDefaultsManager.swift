//
//  UserDefaultsManager.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/18/24.
//

// UserDefaultsManager.swift
import Foundation

// MARK: - Protocol
protocol UserDataManageable {
    func saveUser(_ user: User)
    func getUser() -> User?
    var isLoggedIn: Bool { get set }
    var autoLoginOption: Bool { get set }
    var rememberIDOption: Bool { get set }
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

    private enum Keys {
        static let user = "user"
        static let loginStatus = "LoginStatus"
        static let autoLogin = "AutoLoginOption"
        static let rememberID = "RememberIDOption"
    }

    // MARK: - UserDataManageable
    func saveUser(_ user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: Keys.user)
        }
    }

    func getUser() -> User? {
        if let data = UserDefaults.standard.data(forKey: Keys.user),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            return user
        }
        return nil
    }

    var isLoggedIn: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.loginStatus) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.loginStatus) }
    }

    var autoLoginOption: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.autoLogin) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.autoLogin) }
    }

    var rememberIDOption: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.rememberID) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.rememberID) }
    }
}
