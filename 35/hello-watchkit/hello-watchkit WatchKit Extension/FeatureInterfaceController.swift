

import Foundation
import WatchKit

class FeatureInterfaceController: WKInterfaceController {
  
  @IBOutlet weak var featureLabel: WKInterfaceLabel!
  @IBOutlet weak var featureImage: WKInterfaceImage!
  
  override func awakeWithContext(context: AnyObject!) {
    if let context = context as? String {
      featureLabel.setText(context)
      featureImage.setImageNamed(context)
    }
  }
}
