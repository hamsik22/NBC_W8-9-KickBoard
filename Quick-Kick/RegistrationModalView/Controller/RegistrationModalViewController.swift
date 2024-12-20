//
//  RefistrationModalViewController.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/17/24.
//

import UIKit
import SnapKit
import CoreData

// 킥보드 등록을 모달뷰 컨트롤러
final class RegistrationModalViewController: UIViewController {
    
    private var latitude: Double?
    private var longitude: Double?
    private var address: String?
    
    private var _typeSelected: Bool = false
    private var _haveNickNameText: Bool = false
    private var _sendNickName: String?
    private var _kickboardType: Bool?
    
    private var kickboardID: NSManagedObjectID?
    
    private let textField = RegistrationTextField()
    private let typeButton = KickboardTypeButton()
    private let addButton = RegistrationButton()
    
    var disappear: (() -> Void)?
    
    // MARK: - RegistrationModalViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupTypeButton()
        setupTextField()
        setupAddButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.disappear?()
    }
    
    // MARK: - RegistrationModalViewController UI Setting Method
    /// 텍스트필드를 세팅하는 메소드
    private func setupTextField() {
        self.textField.registrationDelegate = self
        view.addSubview(self.textField)
        
        self.textField.snp.makeConstraints {
            $0.top.equalTo(self.typeButton.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(320)
            $0.height.equalTo(120)
        }
    }
    
    /// 킥보드 타입 버튼을 세팅하는 메소드
    private func setupTypeButton() {
        self.typeButton.registrationDelegate = self
        view.addSubview(self.typeButton)
        
        self.typeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(170)
            $0.width.equalTo(320)
        }
    }
    
    /// 등록하기 버튼을 세팅하는 메소드
    private func setupAddButton() {
        self.addButton.registrationDelegate = self
        view.addSubview(self.addButton)
        
        self.addButton.snp.makeConstraints {
            $0.top.equalTo(self.textField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(60)
            $0.width.equalTo(320)
        }
    }
    
    private func completeRegistrationAlert(message: String, _ completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "등록 완료", message: "내 킥보드가 Quick하게\n\(message)되었습니다!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            completion()
        })
        
        self.present(alert, animated: true)
    }
    
    /// 킥보드 등록 탭에서 + 버튼 눌렀을 때 주소 정보 전달 받는 메소드
    func setAddressInfo(_ latitude: Double, _ longitude: Double, _ address: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
    }
    
    /// 내 킥보드 관리에서 cell을 탭했을 때 킥보드 유형과 별명을 전달 받는 메소드
    func editKickboardData(_ type: Bool, _ text: String, _ id: NSManagedObjectID) {
        self.kickboardID = id
        self._sendNickName = text
        self._kickboardType = type
        self._haveNickNameText = true
        self._typeSelected = true
        self.typeButton.updateData(type)
        self.textField.updateData(text)
        self.addButton.modalMode = .edit
        self.addButton.activateButton(true)
    }
}

// MARK: RegistrationViewDelegate Method
extension RegistrationModalViewController: RegistrationViewDelegate {
    func updateKickboardData() {
        guard let id = self.kickboardID, let sendNickName = self._sendNickName, let kickboardType = self._kickboardType else { return }
        
        do {
            try CoreDataManager.shared.update(id, sendNickName, kickboardType)
            
            completeRegistrationAlert(message: "수정") { [weak self] in
                guard let self else { return }
                self.dismiss(animated: true)
            }
        } catch {
            print(error)
        }
    }
    
    var sendNickName: String? {
        get { self._sendNickName }
        set { self._sendNickName = newValue }
    }
    
    var kickboardType: Bool? {
        get { self._kickboardType }
        set { self._kickboardType = newValue }
    }
    
    func savedKickboardData() {
        guard let latitude, let longitude, let address, let nickName = _sendNickName, let type = _kickboardType else { return }
        
        let kickboardData = KickboardDTO(nickName: nickName,
                                         isSaddled: type,
                                         isOccupied: true,
                                         startTime: nil,
                                         endTime: nil,
                                         latitude: latitude,
                                         longitude: longitude,
                                         address: address
        )
        
        CoreDataManager.shared.create(with: kickboardData)
        
        completeRegistrationAlert(message: "저장") { [weak self] in
            guard let self else { return }
            self.dismiss(animated: true)
        }
    }
    
    var typeSelected: Bool {
        get { return self._typeSelected }
        set { self._typeSelected = newValue }
    }
    
    var haveNickNameText: Bool {
        get { return self._haveNickNameText }
        set { self._haveNickNameText = newValue }
    }
    
    /// 등록하기 버튼을 활성화 하는 메소드
    func activateButton() {
        guard self.typeSelected, self.haveNickNameText else {
            self.addButton.activateButton(false)
            return
        }
        
        self.addButton.activateButton(true)
    }
}

