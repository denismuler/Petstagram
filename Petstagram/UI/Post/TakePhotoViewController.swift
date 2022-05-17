//  Petstagram
//
//  Created by Denys Melnyk on 03.02.2022.
//

import UIKit
import SwiftUI

class TakePhotoViewController: UIViewController {
  @IBOutlet var previewView: CameraPreviewView!
  var captureController: PhotoCaptureController!
  let completionHandler: (UIImage) -> Void

  init?(coder: NSCoder, completionHandler: @escaping (UIImage) -> Void) {
    self.completionHandler = completionHandler
    super.init(coder: coder)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    captureController = PhotoCaptureController(previewView: previewView, alertPresenter: self, captureCompletionHandler: completionHandler)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    captureController.startSession()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    captureController.stopSession()
  }

  @IBAction func shutterButtonTapped() {
    captureController.capturePhoto()
  }

  @IBAction func libraryButtonTapped() {
    let picker = UIImagePickerController()
    picker.sourceType = .photoLibrary
    picker.modalTransitionStyle = .crossDissolve
    picker.delegate = self
    present(picker, animated: true)
  }
}

extension TakePhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      completionHandler(image)
      dismiss(animated: true)
    }
  }
}

struct TakePhotoView: UIViewControllerRepresentable {
  let onPhotoCapture: (UIImage) -> Void

  func makeUIViewController(context: Context) -> TakePhotoViewController {
    let storyboard = UIStoryboard(name: "TakePhotoStoryboard", bundle: nil)
    let controller = storyboard.instantiateInitialViewController { coder in
      TakePhotoViewController(coder: coder, completionHandler: onPhotoCapture)
    }
    return controller!
  }

  func updateUIViewController(_ uiViewController: TakePhotoViewController, context: Context) {
    // Nothing to do in an update with this view controller
  }
}

struct TakePhotoView_Previews: PreviewProvider {
  static var previews: some View {
    return TakePhotoView(onPhotoCapture: {_ in})
  }
}
