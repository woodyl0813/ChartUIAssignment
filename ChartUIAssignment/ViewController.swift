import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var closeButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var chartView: UIView!
  @IBOutlet weak var logoImageView: UIImageView!
  @IBOutlet weak var topDescriptionLabel: UILabel!
  @IBOutlet weak var bottomDescriptionLabel: GradientLabel!
  @IBOutlet weak var registerButton: UIButton!
  
  @IBAction func onCloseButtonPressed() {
    
  }
  
  @IBAction func onRegisterButtonPressed() {
    
  }
  
  let chartLabelText = ["現在", "3ヶ月", "1年", "2年"]
  let chartLabelTextHeightRatio = 0.5
  let chartGapWidth = 24
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setBackgroundGradient()
    setupCloseButton()
    setupTitleLabel()
    setupLogoImageView()
    setupTopDescriptionLabel()
    setupBottomDescriptionLabel()
    setupRegisterButton()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    closeButton.layer.cornerRadius = closeButton.frame.height / 2
    registerButton.layer.cornerRadius = registerButton.frame.height / 2
    
    setupChartView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    startChartAnimation()
  }
  
  func setBackgroundGradient() {
    let topColor = UIColor(red: 213.0 / 255.0, green: 210.0 / 255.0, blue: 1, alpha: 1)
    let bottomColor = UIColor(white: 1, alpha: 0)
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    gradientLayer.locations = [0.0, 1.0]
    gradientLayer.frame = view.bounds
    
    view.layer.insertSublayer(gradientLayer, at: 0)
  }
  
  func setupCloseButton() {
    let padding = 12.0
    let closeButtonText = "×"
    let closeButtonFont = UIFont.systemFont(ofSize: 20, weight: .heavy)
    
    closeButton.titleLabel?.textAlignment = .center
    closeButton.titleLabel?.baselineAdjustment = .alignCenters
    closeButton.setTitle(closeButtonText, for: .normal)
    closeButton.setTitle(closeButtonText, for: .highlighted)
    closeButton.setTitleColor(.monoblack, for: .normal)
    closeButton.setTitleColor(.monoblack.withAlphaComponent(0.5), for: .highlighted)
    if #available(iOS 15.0, *) {
      closeButton.configuration?.titlePadding = padding
      closeButton.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ container in
        var container = container
        container.font = closeButtonFont
        return container
      })
    } else {
      closeButton.contentEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
      closeButton.titleLabel?.font = closeButtonFont
    }
    
    closeButton.backgroundColor = .white
    
    setupShadowFor(closeButton)
  }
  
  func setupTitleLabel() {
    titleLabel.font = .systemFont(ofSize: 36, weight: .bold)
    titleLabel.textColor  = .monoblack
    titleLabel.numberOfLines = 0
    
    let attributedString = NSMutableAttributedString(string: "Hello\nSpeakBUDDY")
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = (46.8 - 36) / UIScreen.main.scale
    paragraphStyle.alignment = .center
    attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
    
    titleLabel.attributedText = attributedString
  }
  
  func setupChartView() {
    chartView.backgroundColor = .clear
    
    let chartWidth = (Int(chartView.frame.width) - chartGapWidth * (chartLabelText.count - 1)) / chartLabelText.count
    let chartLabelTextHeight = Int(Double(chartWidth) * chartLabelTextHeightRatio)
    
    let topColor = UIColor(red: 111.0 / 255.0, green: 212.0 / 255.0, blue: 1, alpha: 1)
    let bottomColor = UIColor(red: 0, green: 117.0 / 255.0, blue: 1, alpha: 1)
    
    for i in 0 ..< chartLabelText.count {
      let x = (chartWidth + chartGapWidth) * i
      let y = Int(chartView.frame.size.height) - chartLabelTextHeight
      
      let label = UILabel(frame: CGRect(x: x, y: y, width: chartWidth, height: chartLabelTextHeight))
      label.font = .systemFont(ofSize: 48, weight: .heavy)
      label.adjustsFontSizeToFitWidth = true
      label.textAlignment = .center
      label.textColor = .monoblack
      label.text = chartLabelText[i]
      
      chartView.addSubview(label)
      
      let chart = UIView(frame: CGRect(x: x, y: y, width: chartWidth, height: 0))
      chart.clipsToBounds = true
      chart.accessibilityIdentifier = "chart_\(i)"
      
      let chartHeight = Int(chartView.frame.height) / (chartLabelText.count - i) - chartLabelTextHeight
      
      let gradientLayer = CAGradientLayer()
      gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
      gradientLayer.locations = [0.0, 1.0]
      gradientLayer.frame = CGRect(x: 0, y: 0, width: chartWidth, height: chartHeight)
      chart.layer.insertSublayer(gradientLayer, at: 0)
      
      chartView.addSubview(chart)
    }
  }
  
  func setupLogoImageView() {
    logoImageView.image = UIImage(named: "protty")
  }
  
  func setupTopDescriptionLabel() {
    topDescriptionLabel.font = .systemFont(ofSize: 20, weight: .bold)
    topDescriptionLabel.textColor  = .monoblack
    
    let attributedString = NSMutableAttributedString(string: "スピークバディで")
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = (30 - 20) / UIScreen.main.scale
    paragraphStyle.alignment = .center
    attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
    topDescriptionLabel.attributedText = attributedString
  }
  
  func setupBottomDescriptionLabel() {
    bottomDescriptionLabel.font = .systemFont(ofSize: 30, weight: .bold)
    
    let attributedString = NSMutableAttributedString(string: "レベルアップ")
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = (45 - 30) / UIScreen.main.scale
    paragraphStyle.alignment = .center
    attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
    bottomDescriptionLabel.attributedText = attributedString
  }
  
  func setupRegisterButton() {
    let padding = 16.0
    let registerButtonText = "プランに登録する"
    let registerButtonFont = UIFont.systemFont(ofSize: 16, weight: .bold)
    
    registerButton.setTitle(registerButtonText, for: .normal)
    registerButton.setTitle(registerButtonText, for: .highlighted)
    registerButton.titleLabel?.textAlignment = .center
    registerButton.titleLabel?.baselineAdjustment = .alignCenters
    registerButton.setTitleColor(.white, for: .normal)
    registerButton.setTitleColor(UIColor(white: 1, alpha: 0.5), for: .highlighted)
    if #available(iOS 15.0, *) {
      registerButton.configuration?.contentInsets = .init(top: padding, leading: padding, bottom: padding, trailing: padding)
      registerButton.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ container in
        var container = container
        container.font = registerButtonFont
        return container
      })
    } else {
      registerButton.contentEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
      registerButton.titleLabel?.font = registerButtonFont
    }
    
    registerButton.backgroundColor = UIColor(red: 59.0 / 255.0, green: 167.0 / 255.5, blue: 1, alpha: 1)
    
    registerButton.layer.borderWidth = 1
    registerButton.layer.borderColor = UIColor.white.cgColor
    
    setupShadowFor(registerButton)
  }
  
  func setupShadowFor(_ button: UIButton) {
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    button.layer.shadowOpacity = 0.15
    button.layer.shadowRadius = 10 / UIScreen.main.scale
    button.layer.masksToBounds = false
  }
  
  func startChartAnimation() {
    for subview in chartView.subviews where subview.accessibilityIdentifier != nil {
      let idArray = subview.accessibilityIdentifier!.components(separatedBy: "_")
      if idArray.count == 2 && idArray[0] == "chart" {
        guard let i = Int(idArray[1]) else {
          continue
        }
        
        let chartWidth = (Int(chartView.frame.width) - chartGapWidth * (chartLabelText.count - 1)) / chartLabelText.count
        let chartLabelTextHeight = Int(Double(chartWidth) * chartLabelTextHeightRatio)
        let chartHeight = Int(chartView.frame.height) / (chartLabelText.count - i) - chartLabelTextHeight
        
        let x = (chartWidth + chartGapWidth) * i
        let y = Int(chartView.frame.size.height) - chartLabelTextHeight
        
        UIView.animate(withDuration: 0.5, delay: 0.25 * Double(i)) {
          subview.frame = CGRect(x: x, y: y - chartHeight, width: chartWidth, height: chartHeight)
        } completion: { _ in
          let path = UIBezierPath(roundedRect: subview.bounds,
                                  byRoundingCorners: [.topLeft, .topRight],
                                  cornerRadii: CGSize(width: 5, height: 5))
          let maskLayer = CAShapeLayer()
          maskLayer.path = path.cgPath
          subview.layer.mask = maskLayer
        }
      }
    }
  }

}

