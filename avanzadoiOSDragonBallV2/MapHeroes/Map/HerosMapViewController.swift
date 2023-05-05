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
    
    // Define mapView como una propiedad computada para acceder fácilmente a MapView
    var mapView: MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .light
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
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Obtener los datos de los héroes
        fetchData()
        
        // Define la región inicial de visualización del mapa en Europa
        let initialLocation = CLLocation(latitude: 48.8566, longitude: 2.3522) // Paris, France
            let regionRadius: CLLocationDistance = 10000000 // 10,000 km
            let region = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(region, animated: true)
    }
    
    // Función para recuperar los datos de los héroes de CoreData o de la API
    private func fetchData() {
        if let hero = selectedHero {
            let heroesFromCoreData = viewModel.getHeroesFromCoreData()
            if !heroesFromCoreData.isEmpty {
                updateMap(heroes: heroesFromCoreData)
            } else {
                viewModel.fetchHeroLocations(hero: hero) { [weak self] locations in
                    DispatchQueue.main.async {
                        self?.addLocationsToMapView(locations: locations)
                    }
                }
            }
        }
    }
    
    // Función para actualizar el mapa con los datos de los héroes
    private func updateMap(heroes: [HeroModel]) {
        let locations = heroes.map { HeroMapModel(name: $0.name, latitude: $0.latitude ?? 0, longitude: $0.longitude ?? 0) }
        addLocationsToMapView(locations: locations)
    }
    
    // Función para agregar ubicaciones al mapa
    private func addLocationsToMapView(locations: [HeroMapModel]) {
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            mapView.addAnnotation(annotation)
        }
    }
    
    // Función para manejar la actualización de la ubicación del usuario
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.setCenter(location.coordinate, animated: true)
            locationManager?.stopUpdatingLocation()
        }
    }
    
    // Función para manejar cambios en la autorización de ubicación
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            showAlert()
        }
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Location Access Disabled",
                                                message: "Please open Settings and set location access for this app to 'While Using the App'.",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}


extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let id = MKMapViewDefaultClusterAnnotationViewReuseIdentifier
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: id)
        
        if let annotation = annotation as? Annotation{
            
            // hace que se visualice al tocar ------clase dia 2 21:59
            annotationView?.canShowCallout = true
            annotationView?.detailCalloutAccessoryView = CallOut(annotation: annotation)
            
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







/*

class MapViewController: UIViewController {
    
    // Define mapView como una propiedad computada para acceder fácilmente a MapView
    var mapView: MapView { self.view as! MapView }
    /*var mapView : MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .light
        return map
    }()*/
    
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
        
        // Obtener los datos de los héroes
        fetchData()
    }
    
    // Función para recuperar los datos de los héroes de CoreData o de la API
    private func fetchData() {
        if let hero = selectedHero {
            let heroesFromCoreData = viewModel.getHeroesFromCoreData()
            if !heroesFromCoreData.isEmpty {
                updateMap(heroes: heroesFromCoreData)
            } else {
                viewModel.fetchHeroLocations(hero: hero) { [weak self] locations in
                    DispatchQueue.main.async {
                        self?.addLocationsToMapView(locations: locations)
                    }
                }
            }
        }
    }

    
    // Función para actualizar el mapa con los datos de los héroes
    private func updateMap(heroes: [HeroModel]) {
        let locations = heroes.map { HeroMapModel(name: $0.name, latitude: $0.latitude ?? 0, longitude: $0.longitude ?? 0) }
        addLocationsToMapView(locations: locations)
    }
    
    // Función para agregar ubicaciones al mapa
    private func addLocationsToMapView(locations: [HeroMapModel]) {
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            mapView.map.addAnnotation(annotation)
        }
    }
        
    // Función para manejar la actualización de la ubicación del usuario
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.map.setCenter(location.coordinate, animated: true)
            locationManager?.stopUpdatingLocation()
        }
    }
    
    // Función para manejar cambios en la autorización de ubicación
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            showAlert()
        }
    }
    
    // Función para mostrar una alerta cuando el acceso a la ubicación está deshabilitado
    private func showAlert() {
        let alertController = UIAlertController(title: "Location Access Disabled",
                                                message: "Please open Settings and set location access for this app to 'While Using the App'.",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
*/


/*
class MapViewController: UIViewController {

    var mapView: MapView {self.view as! MapView}
    var locationManager: CLLocationManager?

    var viewModel: MapViewModel?
    private(set) var heroesMapList: [HeroModel] = [] {
            didSet {
                DispatchQueue.main.async {
                    self.mapView.map.reloadInputViews()
            }
        }
    }
    /*
    let countries = [
        HeroMapModel(name: "España", latitude: 39.3260685, longitude: -4.8379791, image: "https://photo980x880.mnstatic.com/37f93c7924cb320de906a1f1b9f4e12a/la-gran-via-de-madrid-1072541.jpg"),
        HeroMapModel(name: "Francia", latitude: 46.603354, longitude: 1.8883335, image: "https://queverenelmundo.com/guias/wp-content/uploads/pexels-rosivan-morais-6053202.jpg"),
        HeroMapModel(name: "Italia", latitude: 42.6384261, longitude: 12.674297, image: "https://premiumincoming.com/wp-content/uploads/2018/07/viajar-italia.jpg"),
        HeroMapModel(name: "Alemania", latitude: 51.1638175, longitude: 10.4478313, image: "https://images.mnstatic.com/80/7b/807bafdaeed88061afc72505c7eb173f.jpg?quality=75&format=pjpg&fit=crop&width=980&height=880&aspect_ratio=980%3A880"),
        HeroMapModel(name: "Suiza", latitude: 46.7985624, longitude: 8.2319736, image: "https://cdn.britannica.com/65/162465-050-9CDA9BC9/Alps-Switzerland.jpg"),
        HeroMapModel(name: "Croacia", latitude: 45.5643442, longitude: 17.0118954, image: "https://statics.es.tui.com/staticFiles2/croacia-a-su-aire-new-box230e278ab2db485a86ec484fc3886a77.jpg"),
    ]
    
    */
    //Arrasate
    //let latitude = 43.0650304
    //let longitude = -2.494436
    
    //Europa
    let initialLatitude = 51.0
    let initialLongitude = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        
        mapView.map.delegate = self
        
        //para mostrar la ubicacion en el mapa
        mapView.map.showsUserLocation = true
        //cambiar formato mapa
        //mapView.mapType = .satellite
        
        moveToCoordinates(initialLatitude   ,initialLongitude)
        
        //createAnnotations(self.countries)
        
        //var annotation = [MKAnnotation]() // []
        
        //let annotation = Annotation(place: <#T##Place#>)
        /*
        for place in countries{
            let annotation = Annotation(place: place)
            annotation.append(annotation)
        }
         */
        
        mapView.map.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        
        //mapView.map.register(CustomMarker.self, forAnnotationViewWithReuseIdentifier: "id2")
       /*
        let annotations = heroesMapList.map { hero in
            return Annotation(place: hero)
        }
        mapView.map.showAnnotations(annotations, animated: true)
        */
        // Comprueba si tenemos datos de HeroMapModel en Core Data
        if let heroesFromCoreData = viewModel?.getHeroesFromCoreData(), !heroesFromCoreData.isEmpty {
                heroesMapList = heroesFromCoreData.map { heroMapModel in
                    return HeroModel(photo: heroMapModel.image, id: "", favorite: false, name: heroMapModel.name, description: "", latitude: heroMapModel.latitude, longitude: heroMapModel.longitude)
                }
            } else {
                // Pasar el objeto 'HeroModel' actual al método 'getData'
                var currentHero: HeroModel?
                let defaultHero = HeroModel(photo: "default_photo", id: "default_id", favorite: false, name: "default_name", description: "default_description", latitude: nil, longitude: nil)
                viewModel?.getData(heroe: currentHero ?? defaultHero) { [weak self] locations in
                    guard let self = self else { return }
                    self.heroesMapList = locations.map { heroMapModel in
                        return HeroModel(photo: heroMapModel.image, id: "", favorite: false, name: heroMapModel.name, description: "", latitude: heroMapModel.latitude, longitude: heroMapModel.longitude)
                    }
                    let annotations = self.heroesMapList.map { hero in
                        return Annotation(place: hero)
                    }
                    DispatchQueue.main.async {
                        self.mapView.map.showAnnotations(annotations, animated: true)
                    }
                }
            }
        
        
    }
    /*
    func createAnnotation(_ place: HeroMapModel){
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        annotation.title = place.name
        annotation.subtitle = "Estás viendo \(place.name)"
        
        mapView.addAnnotation(annotation)
    }
    */
    /*
    func createAnnotations(_ places: [HeroMapModel]){
        
        //places.forEach(createAnnotation) otra forma
        places.forEach{place in
            createAnnotation(place)
            
        }
    }
    */
    func moveToCoordinates(_ latitude : Double , _ longitude : Double){
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 50)
        
        let region = MKCoordinateRegion(center: center, span: span)
        
        mapView.map.setRegion(region, animated: true)
    }


}
*/

