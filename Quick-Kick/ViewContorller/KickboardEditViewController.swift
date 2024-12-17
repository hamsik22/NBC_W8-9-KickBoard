//
//  KickboardEditViewController.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/16/24.
//

import UIKit

class KickboardEditViewController: UIViewController {
    
    // MARK: - Properties
    private let kickboardEditView = KickboardEditView()
    var kickboard: Kickboard?
    
    // MARK: - Lifecycle
    override func loadView() {
        self.view = kickboardEditView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        setupActions()
    }
    
    // MARK: - Configure Data
    private func configureData() {
        guard let kickboard = kickboard else { return }
        kickboardEditView.nameField.text = kickboard.name
        kickboardEditView.addressField.text = kickboard.address
        kickboardEditView.typeSegmentedControl.selectedSegmentIndex = kickboard.type == "일반형" ? 0 : 1
    }
    
    // MARK: - Setup Actions
    private func setupActions() {
        kickboardEditView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        kickboardEditView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func saveButtonTapped() {
        guard let updatedName = kickboardEditView.nameField.text,
              let updatedAddress = kickboardEditView.addressField.text else { return }
        
        let updatedType = kickboardEditView.typeSegmentedControl.selectedSegmentIndex == 0 ? "일반형" : "안장형"
        print("수정된 킥보드 정보:")
        print("이름: \(updatedName), 주소: \(updatedAddress), 타입: \(updatedType)")
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func deleteButtonTapped() {
        let alert = UIAlertController(title: "삭제", message: "킥보드를 삭제하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            print("킥보드 삭제됨")
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
}
