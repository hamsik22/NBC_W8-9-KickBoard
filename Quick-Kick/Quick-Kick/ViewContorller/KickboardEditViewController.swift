//
//  KickboardEditViewController.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/16/24.
//

import UIKit
import CoreData

class KickboardEditViewController: UIViewController {
    
    // MARK: - Properties
    private let kickboardEditView = KickboardEditView()
    var kickboard: Kickboard? // Core Data Kickboard

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
        kickboardEditView.nameField.text = kickboard.nickName
        kickboardEditView.addressField.text = kickboard.address
        kickboardEditView.saddledSwitch.isOn = kickboard.isSaddled
    }
    
    // MARK: - Setup Actions
    private func setupActions() {
        kickboardEditView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        kickboardEditView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func saveButtonTapped() {
        guard let updatedName = kickboardEditView.nameField.text,
              let updatedAddress = kickboardEditView.addressField.text,
              let kickboard = kickboard else { return }
        
        // Core Data 업데이트
        kickboard.setValue(updatedName, forKey: #keyPath(Kickboard.nickName))
        kickboard.setValue(updatedAddress, forKey: #keyPath(Kickboard.address))
        kickboard.setValue(kickboardEditView.saddledSwitch.isOn, forKey: #keyPath(Kickboard.isSaddled))

        do {
            try CoreDataManager.shared.saveContext()
            print("킥보드 수정됨: \(updatedName), \(updatedAddress), \(kickboard.isSaddled ? "안장형" : "일반형")")
            navigationController?.popViewController(animated: true)
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
    }
    
    @objc private func deleteButtonTapped() {
        guard let kickboard = kickboard else { return }
        
        let alert = UIAlertController(title: "삭제", message: "킥보드를 삭제하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            CoreDataManager.shared.delete(kickboard)
            print("킥보드 삭제됨")
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
}
