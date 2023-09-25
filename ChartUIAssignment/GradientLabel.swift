import UIKit

@IBDesignable
class GradientLabel: UILabel {
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let image = UIGraphicsImageRenderer(bounds: bounds).image { context in
      let topColor = UIColor(red: 111.0 / 255.0, green: 212.0 / 255.0, blue: 1, alpha: 1)
      let bottomColor = UIColor(red: 0, green: 117.0 / 255.0, blue: 1, alpha: 1)
      
      let colors = [topColor.cgColor, bottomColor.cgColor]
      guard let gradient = CGGradient(colorsSpace: nil, colors: colors as CFArray, locations: nil) else { return }
      context.cgContext.drawLinearGradient(gradient,
                                           start: CGPoint(x: bounds.midX, y: bounds.minY),
                                           end: CGPoint(x: bounds.midX, y: bounds.maxY),
                                           options: [])
    }
    
    textColor = UIColor(patternImage: image)
  }
  
}
