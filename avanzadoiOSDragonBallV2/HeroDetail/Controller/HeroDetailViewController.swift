//
//  HeroDetailViewController.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 7/4/23.
//
/*
import Foundation
import UIKit

class HeroDetailViewController: UIViewController {
    var mainView: HeroDetailView { self.view as! HeroDetailView }
    
    private var heroName: String
    private var heroDetailViewModel: HeroDetailViewModel
    
    init(heroName: String) {
        self.heroName = heroName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = HeroDetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.heroDetailViewModel = HeroDetailViewModel()

        heroDetailViewModel.updateUI = { [weak self] hero, error in
            if let error = error {
                print("Error: \(error)")
                // Manejar el error (mostrar una alerta, etc.)
                return
            }
            
            if let hero = hero {
                DispatchQueue.main.async {
                    self?.mainView.configure(hero)
                }
            }
        }
        
        heroDetailViewModel.getHeroDetail(name: heroName)
    }
}

*/











/*
class HeroDetailViewController: UIViewController {
    private var viewModel: HeroDetailViewModel
    var mainView: HeroDetailView { self.view as! HeroDetailView }
    
    init(viewModel: HeroDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = HeroDetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.configure(viewModel.hero)
    }
}

*/
/*
class HeroDetailViewController: UIViewController {
    var mainView: HeroDetailView { self.view as! HeroDetailView}
    
    init(heroDetailModel: HeroModel){
        super.init(nibName: nil, bundle: nil)
        mainView.configure(heroDetailModel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = HeroDetailView()
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    func getDetail() {
        guard let hero = self.hero else { return }
        DispatchQueue.main.async {
            self.mainView.configure(hero)
        }
    }
}
*/
