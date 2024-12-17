//
//  KickboardEditView.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/16/24.
//

import UIKit

class KickboardEditView: UIView {
    
    // MARK: - UI Components
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "킥보드 수정"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let nameField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.placeholder = "킥보드 이름"
        return textField
    }()
    
    let addressField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.placeholder = "주소"
        return textField
    }()
    
    let typeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["일반형", "안장형"])
        return segmentedControl
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("수정하기", for: .normal)
        button.backgroundColor = .systemPurple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("삭제하기", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        backgroundColor = .white
        
        let components = [titleLabel, nameField, addressField, typeSegmentedControl, saveButton, deleteButton]
        components.forEach { component in
            addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            nameField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            nameField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            addressField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 15),
            addressField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            addressField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            typeSegmentedControl.topAnchor.constraint(equalTo: addressField.bottomAnchor, constant: 20),
            typeSegmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            saveButton.topAnchor.constraint(equalTo: typeSegmentedControl.bottomAnchor, constant: 30),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 200),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            
            deleteButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            deleteButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
