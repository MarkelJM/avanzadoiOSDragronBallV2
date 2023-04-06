//
//  HeroesListTableViewController.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 5/4/23.
//

import Foundation
import UIKit



class HeroesListViewController : UIViewController {
    
    let keychainManager = KeychainManager()

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1 paso logout
        mainView.logoutButton.addTarget(self, action: #selector(logoutButtonActivated), for: .touchUpInside)
        
        //setTableElements()
        //setDidTapOnCell()
        /*RECORDATORIO: NotificantionCenter es Objective C, por ence @objc*/
        NotificationCenter.default.addObserver(self, selector: #selector(logoutApp),name: Notification.Name("Logout"),object: nil)
        
        if !keychainManager.hasToken() {
            // cerrar la vista de Heroes
                self.dismiss(animated: true) {
                    // presentar la vista de Login
                    let loginVC = LoginViewController()
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC, animated: true, completion: nil)
            }
            
            return
        }
        getHeroesData()
        
        //2 paso coredata
        
        //3 paso api
    }
    
    @objc func logoutButtonActivated(_ sender: Any) {
        NotificationCenter.default.post(Notification(name: Notification.Name("Logout")))
    }
    @objc func logoutApp() {
        /* eliminar token*/
        keychainManager.deleteData()

        /* cuando se marcha de la ap de forma directa eliminamos coredata, despues actualizamos datos con DataSource. Proxima entrada llamada API*/
        CoreDataManager.deleteStoredHeroes()
        
        /* esta línea de código se utiliza para actualizar la fuente de datos de la tabla con los héroes almacenados más recientes
         convertimos de HeroModel a Hero*/
        let heroes = CoreDataManager.getStoredHeroes().map { hero in
            return HeroModel(
                photo: hero.photo ?? "",
                id: hero.id,
                favorite: hero.favorite,
                name: hero.name,
                description: hero.details,
                latitude: hero.latitude,
                longitude: hero.longitude
            )
        }
        tableViewDataSource?.set(heroes: heroes)

        // cerrar la vista de Heroes
            self.dismiss(animated: true) {
                // presentar la vista de Login
                let loginVC = LoginViewController()
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true, completion: nil)
            }
    }
    
    private func getHeroesData() {
        let storedHeroes = CoreDataManager.getStoredHeroes()

        if storedHeroes.isEmpty {
            // Si no hay héroes almacenados, llamar al viewModel para obtener los héroes desde la API
            viewModel?.getHeroesData { [weak self] (heroes: [HeroModel]) in
                // Actualizar el dataSource y la tableView
                self?.tableViewDataSource?.set(heroes: heroes)
                self?.mainView.tableView.reloadData()
            }
        } else {
            // Si hay héroes almacenados, actualizar el dataSource y la tableView
            let heroes = storedHeroes.map { hero in
                return HeroModel(
                    photo: hero.photo ?? "",
                    id: hero.id,
                    favorite: hero.favorite,
                    name: hero.name,
                    description: hero.details,
                    latitude: 0,
                    longitude: 0
                )
            }
            tableViewDataSource?.set(heroes: heroes)
            mainView.tableView.reloadData()
        }
    }
    func fetchData(){
        /* traer los datos: CALL API TO GET HERO LIST*/
        viewModel?.getData()
        
    }




}
