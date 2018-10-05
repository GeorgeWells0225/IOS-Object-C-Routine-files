

import WatchKit
import Foundation


class MinionDetailsInterfaceController: WKInterfaceController {

  @IBOutlet weak var nameLabel: WKInterfaceLabel!
  @IBOutlet weak var image: WKInterfaceImage!
  
  override func awakeWithContext(context: AnyObject!) {
    if let context = context as? String {
      nameLabel.setText(context)
      image.setImageNamed(context)
    }
  }
}
