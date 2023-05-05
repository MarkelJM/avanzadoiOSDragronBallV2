//
//  MapView.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 14/4/23.
//

import Foundation
import UIKit
import MapKit


class MapView: UIView {
    
    let map: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.overrideUserInterfaceStyle = .light
        map.showsUserLocation = true
        map.mapType = .standard
                
        return map
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        
        addSubview(map)
        
        NSLayoutConstraint.activate([
        
            map.topAnchor.constraint(equalTo: topAnchor),
            map.bottomAnchor.constraint(equalTo: bottomAnchor),
            map.leadingAnchor.constraint(equalTo: leadingAnchor),
            map.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
