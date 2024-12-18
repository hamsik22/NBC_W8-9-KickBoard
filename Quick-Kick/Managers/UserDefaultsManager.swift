//
//  UserDefaultsManager.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/18/24.
//

import Foundation

struct User: Codable {
    var email: String
    var password: String
    var nickName: String = "User1"
}

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() {}

    private enum Keys {
        static let user = "user"
        static let loginStatus = "LoginStatus"
        static let autoLogin = "AutoLoginOption"
        static let rememberID = "RememberIDOption"
    }

    // User 저장 및 불러오기
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
        if let data = UserDefaults.standard.data(forKey: Keys.user),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            return user
        }
        return nil
    }

    // 로그인 상태
    var isLoggedIn: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.loginStatus) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.loginStatus) }
    }

    // 자동 로그인 옵션
    var autoLoginOption: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.autoLogin) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.autoLogin) }
    }

    // ID 기억 옵션
    var rememberIDOption: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.rememberID) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.rememberID) }
    }
}
