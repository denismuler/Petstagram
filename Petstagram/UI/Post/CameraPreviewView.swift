//  Petstagram
//
//  Created by Denys Melnyk on 03.02.2022.
//

import UIKit
import AVFoundation

class CameraPreviewView: UIView {
  override class var layerClass: AnyClass {
    return AVCaptureVideoPreviewLayer.self
  }

  // convenience property to cast layer as AVCaptureVideoPreviewLayer
  var videoPreviewLayer: AVCaptureVideoPreviewLayer {
    guard let layer = layer as? AVCaptureVideoPreviewLayer else {
      fatalError("Expected `AVCaptureVideoPreviewLayer` type for layer.")
    }
    return layer
  }

  var session: AVCaptureSession? {
    get {
      return videoPreviewLayer.session
    }
    set {
      videoPreviewLayer.videoGravity = .resizeAspectFill
      videoPreviewLayer.session = newValue
    }
  }
}
