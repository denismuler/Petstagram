//  Petstagram
//
//  Created by Denys Melnyk on 03.02.2022.
//

import UIKit

extension UIImage {
  func filteredImages(filters: [CIFilter], includeOriginal: Bool = true) -> [UIImage] {
    var images: [UIImage] = []
    if includeOriginal {
      images.append(self)
    }
    let filteredImages = filters.compactMap({ filter in self.applying(filter: filter) })
    images.append(contentsOf: filteredImages)
    return images
  }

  func applying(filter: CIFilter) -> UIImage? {
    guard let ciImage = CIImage(image: self) else { return nil }
    filter.setValue(ciImage, forKey: kCIInputImageKey)
    guard let outputCIImage = filter.outputImage else { return nil }
    // When we create a UIImage from a CIImage, it treats the image differently. But, if we make the CIImage into a CGImage, and create the UIImage from that, it behaves as expected.
    let context = CIContext(options: nil)
    guard let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else { return nil }
    return UIImage(cgImage: cgImage)
  }

  /// UIImage can use metadata to rotate an image, but some apparent UIKit bugs cause the image to render incorrectly, so we physically rotate the image to normalize.
  func fixedOrientation() -> UIImage? {
    // When UIImage.draw(in:) renders the image, it uses the orientation metadata to do it. Then UIGraphicsGetImageFromCurrentImageContext gets the rotated image with the orientation already applied.
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    draw(in: CGRect(origin: .zero, size: size))
    let processedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return processedImage
  }
}
