//
//  HeroesListTableViewController.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 5/4/23.
//

import Foundation
import UIKit



class HeroesListViewController : UIViewController {
    
    var mainView: HeroesListView {self.view as! HeroesListView}
    var heroesList: [HeroModel] = []
    var viewModel: HeroesListViewModel?
    
    private var tableViewDataSource: HeroesListTableViewDataSource?
    private var tableVideDelegate: HeroesListTableViewDelegate?
    
    private var heroeListViewModel = HeroesListViewModel()
    private var loginViewModel = LoginViewModel()
    
    private var loginViewController: LoginViewController?
    
    override func loadView() {
        view = HeroesListView()
    }
}
