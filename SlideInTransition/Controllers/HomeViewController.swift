//
//  ViewController.swift
//  SlideInTransition
//
//  Created by Jair Moreno Gaspar on 2/12/19.
//

import UIKit

class HomeViewController: UIViewController {

    let transition = SlideInTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .red
    }

    
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else {
            return
        }
        
        //cambiar el controller cuando presionas una opcion del menu
        menuViewController.didTapMenuType = { menuType in
            print("Selecciono \(menuType)")
            self.transitionToNew(menuType)
        }
        
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true, completion: nil)
        
    }
    
    func transitionToNew(_ menuType: MenuType){
        
        
        
        switch menuType {
        case .profile:
            

            let profileControlller = ProfileController()
            self.title = String(describing: menuType).capitalized
            //Agrega el controller
            switchController(profileControlller)
            
            //En este punton habrá un controller sobre otro, por eso quitamos todos excepto el que
            //se acaba de agregar
            self.navigationController?.children.forEach({ (controller) in
                if !(UIApplication.topViewController() is ProfileController){
                    controller.willMove(toParent: nil)
                    controller.view.removeFromSuperview()
                    controller.removeFromParent()
                }
                
            })
            
        case .camera:
            
            let cameraController = CameraController()
            self.title = String(describing: menuType).capitalized
            //Agrega el controller
            switchController(cameraController)
            
            //En este punton habrá un controller sobre otro, por eso quitamos todos excepto el que
            //se acaba de agregar
            self.navigationController?.children.forEach({ (controller) in
                if !(UIApplication.topViewController() is CameraController){
                    controller.willMove(toParent: nil)
                    controller.view.removeFromSuperview()
                    controller.removeFromParent()
                }
                
            })

            
        case .home:
            
            let homeViewController = HomeViewController()
            self.title = String(describing: menuType).capitalized
            //Agrega el controller
            switchController(homeViewController)
            
            //En este punton habrá un controller sobre otro, por eso quitamos todos excepto el que
            //se acaba de agregar
            self.navigationController?.children.forEach({ (controller) in
                if !(UIApplication.topViewController() is HomeViewController){
                    controller.willMove(toParent: nil)
                    controller.view.removeFromSuperview()
                    controller.removeFromParent()
                }
                
            })
            
            
        default:
            break
        }
    }
    
    
    func switchController(_ controller: UIViewController){
        
        self.navigationController?.addChild(controller)
        guard let navigationController = navigationController else {
            return
        }
        
        let navigationBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        
        controller.view.frame.origin.y = navigationBarHeight
        controller.view.frame.size.height = navigationController.view.frame.height - navigationBarHeight
        controller.view.frame.size.width = navigationController.view.frame.width
        controller.beginAppearanceTransition(true, animated: true)
        self.navigationController?.view.addSubview(controller.view)
        
    }
    
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
    
}


extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
