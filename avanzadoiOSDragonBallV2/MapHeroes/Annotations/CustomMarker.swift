//
//  CustomMarker.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 7/4/23.
//

import UIKit
import MapKit
/* Lo implementamos en Annotation View, por lo que ya no necesitamos es class*/
class CustomMarker: MKAnnotationView{
    override var annotation: MKAnnotation?{
        willSet{
            let pinImage = UIImage(named: "marker-blue")
            let size = CGSize(width: 40, height: 40)
            UIGraphicsBeginImageContext(size)
            pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            
            let reseizedImage = UIGraphicsGetImageFromCurrentImageContext()
            
            //añadimos la imagen
            self.image = reseizedImage
        }
    }
}
