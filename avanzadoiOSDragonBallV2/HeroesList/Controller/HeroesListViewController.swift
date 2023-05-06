//
//  HeroesListTableViewController.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 5/4/23.
//

import Foundation
import UIKit
import CoreData

class HeroesListViewController: UIViewController {

    let keychainManager = KeychainManager()

        var mainView: HeroesListView {self.view as! HeroesListView}

        private var tableViewDataSource: HeroesListTableViewDataSource?
        private var tableViewDelegate: HeroesListTableViewDelegate?

        private var heroListViewModel = HeroesListViewModel()
        private var loginViewModel = LoginViewModel()

        private var loginViewController: LoginViewController?
        private var detailViewController: DetailViewController?

        override func loadView() {
            view = HeroesListView()
            mainView.logoutButton.addTarget(self, action: #selector(logoutButtonActivated), for: .touchUpInside)
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            setupTableView()

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

            fetchHeroesData()
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.navigationBar.isHidden = true
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.navigationBar.isHidden = false
        }

        @objc func logoutButtonActivated(_ sender: Any) {
            NotificationCenter.default.post(Notification(name: Notification.Name("Logout")))
        }

        @objc func logoutApp() {
            keychainManager.deleteData()
            CoreDataUtils.deleteStoredHeroes()

            DispatchQueue.main.async {
                if let navigationController = self.navigationController {
                    navigationController.popToRootViewController(animated: true)
                } else {
                    self.dismiss(animated: true, completion: {
                        // presentar la vista de Login
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true, completion: nil)
                    })
                }
            }
        }

        private func setupTableView() {
            tableViewDataSource = HeroesListTableViewDataSource(tableView: mainView.heroesTableView)
            tableViewDelegate = HeroesListTableViewDelegate()

            mainView.heroesTableView.dataSource = tableViewDataSource
            mainView.heroesTableView.delegate = tableViewDelegate

            tableViewDelegate?.didTapOnCell = { [weak self] index in
                if let hero = self?.tableViewDataSource?.heroes[index] {
                    self?.showHeroDetail(hero)
                }
            }


            mainView.heroesTableView.register(HeroeListViewCell.self, forCellReuseIdentifier: "HeroeListViewCell")
        }

    private func fetchHeroesData() {
        // Primero, intentamos obtener los datos de CoreData
        let storedHeroes = CoreDataUtils.getStoredHeroes()

        if storedHeroes.isEmpty {
            // Si no hay datos almacenados en CoreData, los obtenemos desde la API
            heroListViewModel.getHeroesFromAPI { [weak self] heroes in
                self?.tableViewDataSource?.set(heroes: heroes)
            }
        } else {
            // Si hay datos almacenados en CoreData, los utilizamos
            let heroes = storedHeroes.map { hero in
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
        }
    }

    private func showHeroDetail(_ hero: HeroModel) {
        let detailViewModel = DetailViewModel(heroId: hero.id)
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
    }


}



/*
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
            
        mainView.logoutButton.addTarget(self, action: #selector(logoutButtonActivated), for: .touchUpInside)
        
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
        CoreDataUtils.deleteStoredHeroes()
        
        /* esta línea de código se utiliza para actualizar la fuente de datos de la tabla con los héroes almacenados más recientes
         convertimos de HeroModel a Hero*/
        let heroes = CoreDataUtils.getStoredHeroes().map { hero in
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
        DispatchQueue.main.async {
            if let navigationController = self.navigationController {
                navigationController.popToRootViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: {
                    // presentar la vista de Login
                    let loginVC = LoginViewController()
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC, animated: true, completion: nil)
                })
            }
        }
    }
    

    
    private func getHeroesData() {
        viewModel?.getHeroesData { [weak self] (heroes: [HeroModel]) in
            debugPrint("prueba 6")

            // Update the dataSource and the tableView
            self?.tableViewDataSource?.set(heroes: heroes)
            self?.mainView.heroesTableView.reloadData()
            debugPrint("prueba 7")

        }
    }

    func fetchData(){
        /* traer los datos: CALL API TO GET HERO LIST*/
        debugPrint("prueba 8")

        viewModel?.getData()
        debugPrint("prueba 1")

        
    }

    




}
*/
