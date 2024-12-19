//
//  UserDefaultsManager.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/16/24.
//

import Foundation

// MARK: - Key 관리 열거형
enum UserDefaultsKeys {
    static let user = "user"
    static let loginStatus = "LoginStatus"
    static let autoLoginOption = "AutoLoginOption"
    static let rememberIDOption = "RememberIDOption"
}

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
            UserDefaults.standard.set(encoded, forKey: UserDefaultsKeys.user)
            print("저장 성공")
        }
    }

    func getUser() -> User? {
        if let data = UserDefaults.standard.data(forKey: UserDefaultsKeys.user),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            print("getUser: \(user.email), \(user.password), \(user.nickName)")
            return user
        }
        return nil
    }

    func setLoggedOut() {
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.loginStatus)
    }

    var isLoggedIn: Bool {
        get { UserDefaults.standard.bool(forKey: UserDefaultsKeys.loginStatus) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.loginStatus) }
    }

    var autoLoginOption: Bool {
        get { UserDefaults.standard.bool(forKey: UserDefaultsKeys.autoLoginOption) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.autoLoginOption) }
    }

    var rememberIDOption: Bool {
        get { UserDefaults.standard.bool(forKey: UserDefaultsKeys.rememberIDOption) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.rememberIDOption) }
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
    var isLoggedIn: Bool {
        get { UserDefaults.standard.bool(forKey: UserDefaultsKeys.loginStatus) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.loginStatus) }
    }

    var autoLoginOption: Bool {
        get { UserDefaults.standard.bool(forKey: UserDefaultsKeys.autoLoginOption) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.autoLoginOption) }
    }

    var rememberIDOption: Bool {
        get { UserDefaults.standard.bool(forKey: UserDefaultsKeys.rememberIDOption) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.rememberIDOption) }
    }
 }
