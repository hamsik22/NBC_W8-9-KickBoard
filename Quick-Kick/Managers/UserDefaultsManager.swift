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
            UserDefaults.standard.set(encoded, forKey: Keys.user)
            if let user = getUser() {
                print("저장완료-> 이메일:\(user.email), 비밀번호:\(user.password), 닉네임:\(user.nickName)")
            } else {
                print("저장 실패")
            }
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
        get { UserDefaults.standard.bool(forKey: Keys.loginStatus) }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.loginStatus)
            print("로그인 상태 : \(newValue)")
        }
    }

    var autoLoginOption: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.autoLogin) }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.autoLogin)
            print("자동 로그인 옵션 : \(newValue)")
        }
    }

    var rememberIDOption: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.rememberID) }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.rememberID)
            print("아이디 저장 옵션 : \(newValue)")
        }
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
