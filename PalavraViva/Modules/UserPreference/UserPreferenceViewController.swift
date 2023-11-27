//
//  UserPreferenceViewController.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 26/11/23.
//

import UIKit

class UserPreferenceViewController: UIViewController {

    @IBOutlet weak var fontSizeDescriptionLabel: UILabel!
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var sliderComponent: UISlider!
    
    private var minimumSize = 10
    private var maximumSize = 48
    
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
        sliderComponent.minimumValue = Float(minimumSize)
        sliderComponent.maximumValue = Float(maximumSize)
        sliderComponent.value = Float(UserPreferences.getFontSize())
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
        if(value != UserPreferences.getFontSize()) {
            UserPreferences.updateUserDefaults(value, .fontSize)
        }
    }
    
    
}
