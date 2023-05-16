//
//  HeroDetailViewController.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 7/4/23.
//


import UIKit

class DetailViewController: UIViewController {
    private var detailView: DetailView { view as! DetailView }
    private var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = DetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getHeroDetails { [weak self] hero in
            if let hero = hero {
                DispatchQueue.main.async {
                    self?.configureView(with: hero)
                }
            } else {
                self?.showErrorAlert(message: "Error fetching hero details")
            }
        }
    }
    
    private func configureView(with hero: HeroModel) {
        title = hero.name
        detailView.configure(with: hero)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}



/*
///ULTIMA VERSION- NO MUESTRA DETALLES
class DetailViewController: UIViewController {
    private var detailView: DetailView { view as! DetailView }
    private var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = DetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.updateUI = { [weak self] hero, error in
            if !error.isEmpty {
                // Handle API error
                self?.showErrorAlert(message: error)
            } else if let hero = hero {
                DispatchQueue.main.async {
                    self?.configureView(with: hero)
                }
            }
        }
        /*
        viewModel.getHeroDetails { [weak self] hero in
            if let hero = hero {
                DispatchQueue.main.async {
                    self?.configureView(with: hero)
                }
            } else {
                // If hero not found in CoreData, try to fetch from API
                self?.viewModel.getHeroDetailsFromAPI(name: self?.viewModel.heroId ?? "")
            }
        }
         */
    }
    
    private func configureView(with hero: HeroModel) {
        title = hero.name
        detailView.configure(with: hero)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}


*/


