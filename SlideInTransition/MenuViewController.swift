//
//  MenuViewController.swift
//  SlideInTransition
//
//  Created by Jair Moreno Gaspar on 2/12/19.
//

import UIKit

enum MenuType: Int {
    case home
    case camera
    case profile
}


class MenuViewController: UITableViewController {

    
    var didTapMenuType: ((MenuType) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else {
            return
        }
        
        dismiss(animated: true) { [weak self] in
            print(menuType)
            self?.didTapMenuType?(menuType)
        }
        
    }
    
}
