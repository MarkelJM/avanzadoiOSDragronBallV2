//
//  HeroesListTableViewDataSource.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 4/4/23.
//

import Foundation
import UIKit

final class HeroesListTableViewDataSource: NSObject, UITableViewDataSource {

    private let tableView: UITableView

    // Cada vez que la lista de héroes cambie, se actualizará la tabla
    private(set) var heroes: [HeroModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    var didTapOnCell: ((HeroModel) -> Void)?

    init(tableView: UITableView, heroes: [HeroModel] = []) {
        self.tableView = tableView
        self.heroes = heroes
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroeListViewCell", for: indexPath) as! HeroeListViewCell

        let hero = heroes[indexPath.row]
        cell.configure(hero)

        return cell
    }

    func set(heroes: [HeroModel]) {
        self.heroes = heroes
    }

}

