

import Foundation
import WatchKit

class MapInterfaceController: WKInterfaceController {
  @IBOutlet weak var mapView: WKInterfaceMap!
  
  override func awakeWithContext(context: AnyObject!) {
    let location = CLLocationCoordinate2D(latitude: 37, longitude: -122)
    let coordinateSpan = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    mapView.addAnnotation(location, withPinColor: .Purple)
    mapView.setRegion(MKCoordinateRegion(center: location, span: coordinateSpan))
  }
  
}

