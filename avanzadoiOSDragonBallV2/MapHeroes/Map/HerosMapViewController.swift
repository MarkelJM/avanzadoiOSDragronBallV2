//
//  HerosMapViewController.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 9/4/23.
//

import UIKit
import MapKit
import CoreData
import CoreLocation




class MapViewController: UIViewController {
    /* tengo implementado el MapView, pero de moemnto uso el del sistema*/
    var mapView: MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .light
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    var locationManager: CLLocationManager?
    
    var viewModel = MapViewModel()
    
    var selectedHero: HeroModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
        
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Set the map view to show Europe
        let europeCenter = CLLocationCoordinate2D(latitude: 54.5260, longitude: 15.2551)
        let europeSpan = MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 40)
        let europeRegion = MKCoordinateRegion(center: europeCenter, span: europeSpan)
        mapView.setRegion(europeRegion, animated: true)
        
        mapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }

    private func fetchData() {
        let heroesFromCoreData = viewModel.getHeroesFromCoreData()
        if !heroesFromCoreData.isEmpty {
            updateMap(heroes: heroesFromCoreData)
        }
    }

    private func updateMap(heroes: [HeroModel]) {
        let annotations = heroes.map { Annotation(place: $0) }
        mapView.showAnnotations(annotations, animated: true)
    }
}

/*
class MapViewController: UIViewController {
    
    // Define mapView como una propiedad computada para acceder fácilmente a MapView
        var mapView: MKMapView = {
            let map = MKMapView()
            map.overrideUserInterfaceStyle = .light
            map.translatesAutoresizingMaskIntoConstraints = false
            return map
        }()

        // CLLocationManager para manejar la ubicación del usuario
        var locationManager: CLLocationManager?

        // ViewModel para interactuar con datos y la API
        var viewModel = MapViewModel()

        // HeroModel seleccionado en la pantalla anterior
        var selectedHero: HeroModel!

        // Método viewDidLoad que se llama cuando se carga la vista
        override func viewDidLoad() {
            super.viewDidLoad()

            // Configuración del CLLocationManager
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.startUpdatingLocation()

            // Configuración de la vista del mapa
            view.addSubview(mapView)
            NSLayoutConstraint.activate([
                mapView.topAnchor.constraint(equalTo: view.topAnchor),
                mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

            // Registramos la vista de anotación personalizada
            mapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)

            // Obtener los datos de los héroes
            fetchData()
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            fetchData()
        }

        // Función para recuperar los datos de los héroes de CoreData o de la API
        private func fetchData() {
            if let hero = selectedHero {
                let heroesFromCoreData = viewModel.getHeroesFromCoreData()
                if !heroesFromCoreData.isEmpty {
                    updateMap(heroes: heroesFromCoreData)
                } else {
                    viewModel.fetchHeroLocations(hero: hero) { [weak self] heroMapModels in
                        let heroModels = self?.mapHeroModels(heroMapModels) ?? []
                        self?.updateMap(heroes: heroModels)
                    }
                }
            }
        }

        // Función para actualizar el mapa con los datos de los héroes
        private func updateMap(heroes: [HeroModel]) {
            let annotations = heroes.map { Annotation(place: $0) }
            mapView.showAnnotations(annotations, animated: true)
        }

    
    // Función para mapear los datos de los héroes de tipo HeroMapModel a HeroModel
    private func mapHeroModels(_ heroMapModels: [HeroMapModel]) -> [HeroModel] {
        var heroModels: [HeroModel] = []
        
        for heroMapModel in heroMapModels {
            let heroModel = HeroModel(
                photo: "",
                id: "",
                favorite: false,
                name: heroMapModel.name,
                description: "",
                latitude: heroMapModel.latitude,
                longitude: heroMapModel.longitude
            )
            
            heroModels.append(heroModel)
        }
        
        return heroModels
    }
}
*/
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let id = MKMapViewDefaultClusterAnnotationViewReuseIdentifier

        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: id)

        if let annotation = annotation as? Annotation {
            annotationView?.canShowCallout = true
            let calloutView = CallOut()
            calloutView.configure(with: annotation)
            
            let heroId = annotation.id
            
            calloutView.onDetailButtonTapped = { [weak self] in
                let detailViewModel = DetailViewModel(heroId: heroId)
                
                DispatchQueue.main.async {
                    let detailViewController = DetailViewController(viewModel: detailViewModel)
                    self?.navigationController?.pushViewController(detailViewController, animated: true)
                }
            }
            
            annotationView?.detailCalloutAccessoryView = calloutView

            return annotationView
        }
        return nil
    }
}








extension MapViewController: CLLocationManagerDelegate{
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if  #available(iOS 14.0, *){
            switch manager.authorizationStatus{
            case .notDetermined:
                debugPrint("not determined")
            case .restricted:
                debugPrint("restricted")
            case .denied:
                debugPrint("denied")
            case . authorizedAlways:
                debugPrint("authorized always")
            case .authorizedWhenInUse:
                debugPrint("authorized when in use")
            @unknown default:
                debugPrint("unkwon status")
            }


        }
    }
    //iOS 13 y anteriores
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        switch manager.authorizationStatus{
        case .notDetermined:
            debugPrint("not determined")
        case .restricted:
            debugPrint("restricted")
        case .denied:
            debugPrint("denied")
        case . authorizedAlways:
            debugPrint("authorized always")
        case .authorizedWhenInUse:
            debugPrint("authorized when in use")
        @unknown default:
            debugPrint("unkwon status")
        }
    }
}








