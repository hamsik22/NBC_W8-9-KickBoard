//
//  Quick_KickTests.swift
//  Quick-KickTests
//
//  Created by 반성준 on 12/19/24.
//

import XCTest
@testable import Quick_Kick

final class UserDefaultsManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // UserDefaults 초기화
        let defaults = UserDefaults.standard
        defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }

    override func tearDownWithError() throws {
        // 테스트 후 UserDefaults 데이터 초기화
        let defaults = UserDefaults.standard
        defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    func testAutoLoginOption() throws {
        // Given: 초기 상태 확인
        XCTAssertFalse(UserDefaultsManager.shared.autoLoginOption, "초기 autoLoginOption 값은 false여야 합니다.")

        // When: autoLoginOption을 true로 설정
        UserDefaultsManager.shared.autoLoginOption = true

        // Then: UserDefaults에 값이 저장되었는지 확인
        XCTAssertTrue(UserDefaults.standard.bool(forKey: UserDefaultsKeys.autoLoginOption), "UserDefaults에 autoLoginOption이 true로 저장되어야 합니다.")
        XCTAssertTrue(UserDefaultsManager.shared.autoLoginOption, "autoLoginOption 프로퍼티에서 true를 반환해야 합니다.")

        // When: autoLoginOption을 false로 설정
        UserDefaultsManager.shared.autoLoginOption = false

        // Then: UserDefaults에 값이 업데이트되었는지 확인
        XCTAssertFalse(UserDefaults.standard.bool(forKey: UserDefaultsKeys.autoLoginOption), "UserDefaults에 autoLoginOption이 false로 저장되어야 합니다.")
        XCTAssertFalse(UserDefaultsManager.shared.autoLoginOption, "autoLoginOption 프로퍼티에서 false를 반환해야 합니다.")
    }
}
