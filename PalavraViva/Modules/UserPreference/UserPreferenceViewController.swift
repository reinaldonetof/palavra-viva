//
//  UserPreferenceViewController.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 26/11/23.
//

import Firebase
import UIKit

enum MenuType {
    case primary
    case secondary
}

class UserPreferenceViewController: UIViewController {
    @IBOutlet var fontSizeDescriptionLabel: UILabel!
    @IBOutlet var fontSizeLabel: UILabel!
    @IBOutlet var sliderComponent: UISlider!
    @IBOutlet var logoutButton: UIButton!
    @IBOutlet var primaryVersionButton: UIButton!
    @IBOutlet var secondaryVersionButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configElements()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func configElements() {
        fontSizeDescriptionLabel.text = "Tamanho da Fonte"
        fontSizeLabel.text = String(UserPreferences.getFontSize())
        sliderComponent.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
        sliderComponent.minimumValue = 10
        sliderComponent.maximumValue = 48
        sliderComponent.value = Float(UserPreferences.getFontSize())
        configPrimaryMenu()
        configSecondaryMenu()
        logoutButton.tintColor = .red
    }

    func handleElementMenuPrimary(version: Versions) {
        if version.rawValue != UserPreferences.getPrimaryVersion() {
            UserPreferences.updateUserDefaults(version.rawValue, .primaryVersion)
            NotificationCenter.default.post(name: .changePrimaryVersion, object: nil)
        }
    }
    
    func handleElementMenuSecondary(version: Versions) {
        if version.rawValue != UserPreferences.getSecondaryVersion() {
            UserPreferences.updateUserDefaults(version.rawValue, .secondaryVersion)
            NotificationCenter.default.post(name: .changeSecondaryVersion, object: nil)
        }
    }

    func configMenuAndElements(title: String, versionSelected: String,_ type: MenuType) -> UIMenu {
        var elements: [UIAction] = []
        Versions.allCases.forEach({ version in
            let el = UIAction(title: UserPreferences.versionName(version), state: version.rawValue == versionSelected ? .on : .off) { _ in
                type == .primary ? self.handleElementMenuPrimary(version: version) : self.handleElementMenuSecondary(version: version)
            }
            elements.append(el)
        })
        return UIMenu(title: title, children: elements)
    }

    func configPrimaryMenu() {
        let versionSelected = UserPreferences.getPrimaryVersion()
        let menu = configMenuAndElements(title: "Versão principal", versionSelected: versionSelected, .primary)
        primaryVersionButton.showsMenuAsPrimaryAction = true
        primaryVersionButton.menu = menu
    }

    func configSecondaryMenu() {
        let versionSelected = UserPreferences.getSecondaryVersion()
        let menu = configMenuAndElements(title: "Versão de consulta", versionSelected: versionSelected, .secondary)
        secondaryVersionButton.showsMenuAsPrimaryAction = true
        secondaryVersionButton.menu = menu
    }

    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .moved:
                fontSizeLabel.text = "\(Int(slider.value))"
            case .ended:
                changeFontSizeUserPreference(Int(slider.value))
            default:
                break
            }
        }
    }

    func changeFontSizeUserPreference(_ value: Int) {
        if value != UserPreferences.getFontSize() {
            UserPreferences.updateUserDefaults(value, .fontSize)
            NotificationCenter.default.post(name: .changeFontSize, object: nil)
        }
    }

    @IBAction func tappedLogout(_ sender: UIButton) {
        let okAction = UIAlertAction(title: "OK", style: .destructive) { [weak self] _ in
            guard let self else { return }
            self.handleLogout()
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        Alert.setNewAlert(target: self, title: "Alerta", message: "Você realmente deseja fazer o logout do app?", actions: [cancelAction, okAction])
    }

    func handleLogout() {
        do {
            try Auth.auth().signOut()
            UserAuth.removeSavedToken()
            RootNavigationController.shared.navigationController()?.popToRootViewController(animated: true)
        } catch {
            Alert.setNewAlert(target: self, title: "Error", message: "Erro ao realizar o logout: \(error.localizedDescription)")
        }
    }
}
