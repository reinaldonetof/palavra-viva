//
//  TabBarController.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 13/11/23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addControllers()
        configLayout()
    }
    
    func addControllers() {
        let firstVC: UINavigationController = {
            let vcString = String(describing: HomeViewController.self)
            let vc = UIStoryboard(name: vcString, bundle: nil).instantiateViewController(withIdentifier: vcString) as? HomeViewController
            let nav = UINavigationController(rootViewController: vc ?? UIViewController())
            nav.tabBarItem = UITabBarItem(title: "Bíblia", image: UIImage(named: "holy-bible"), tag: 0)
            return nav
        }()
        let secondVC: UINavigationController = {
            let vcString = String(describing: DailyDevotionalViewController.self)
            let vc = UIStoryboard(name: vcString, bundle: nil).instantiateViewController(withIdentifier: vcString) as? DailyDevotionalViewController
            let nav = UINavigationController(rootViewController: vc ?? UIViewController())
            nav.tabBarItem = UITabBarItem(title: "Devocional Diário", image: UIImage(named: "pray"), tag: 0)
            return nav
        }()
        let thirdVC: UINavigationController = {
            let vcString = String(describing: NearChurchsViewController.self)
            let vc = UIStoryboard(name: vcString, bundle: nil).instantiateViewController(withIdentifier: vcString) as? NearChurchsViewController
            let nav = UINavigationController(rootViewController: vc ?? UIViewController())
            nav.tabBarItem = UITabBarItem(title: "Igrejas Próximas", image: UIImage(named: "church"), tag: 0)
            return nav
        }()
        let fourthVC: UINavigationController = {
            let vcString = String(describing: PraiseSongsViewController.self)
            let vc = UIStoryboard(name: vcString, bundle: nil).instantiateViewController(withIdentifier: vcString) as? PraiseSongsViewController
            let nav = UINavigationController(rootViewController: vc ?? UIViewController())
            nav.tabBarItem = UITabBarItem(title: "Louvores", image: UIImage(named: "musical-notes"), tag: 0)
            return nav
        }()
        let fifthVC: UINavigationController = {
            let vcString = String(describing: UserPreferenceViewController.self)
            let vc = UIStoryboard(name: vcString, bundle: nil).instantiateViewController(withIdentifier: vcString) as? UserPreferenceViewController
            let nav = UINavigationController(rootViewController: vc ?? UIViewController())
            nav.tabBarItem = UITabBarItem(title: "Perfil", image: UIImage(named: "user"), tag: 0)
            return nav
        }()
        viewControllers = [firstVC, secondVC, thirdVC, fourthVC, fifthVC]
    }
    
    func configLayout() {
        tabBar.layer.borderWidth = 0.2
        tabBar.layer.borderColor = UIColor.black.cgColor
        tabBar.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
