//
//  AnnotationView.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 7/4/23.
//

import MapKit
import UIKit


class AnnotationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let value = newValue as? Annotation else { return }
            
            let calloutView = CallOut()
            calloutView.configure(with: value)
            detailCalloutAccessoryView = calloutView
            
            let pinImage = UIImage(named: "marker-blue")
            let size = CGSize(width: 40, height: 40)
            UIGraphicsBeginImageContext(size)
            pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            
            // Añadimos la imagen
            self.image = resizedImage
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
}



/*
class AnnotationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let value = newValue as? Annotation else { return }
            detailCalloutAccessoryView = CallOut(annotation: value)
            
            let pinImage = UIImage(named: "marker-blue")
            let size = CGSize(width: 40, height: 40)
            UIGraphicsBeginImageContext(size)
            pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            
            // Añadimos la imagen
            self.image = resizedImage
        }

    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
}
*/
