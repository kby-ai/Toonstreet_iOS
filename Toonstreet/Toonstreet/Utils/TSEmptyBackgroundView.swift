//
//  TSEmptyBackgroundView.swift
//  Toonstreet
//
//  Created by Kavin Soni on 20/11/21.
//

import UIKit
import PureLayout

class TSEmptyBackgroundView: UIView {
    
    private var topSpace: UIView!
    private var bottomSpace: UIView!
    private var imageView: UIImageView!
    private var topLabel: UILabel!
    private var bottomLabel: UILabel!
    
    private let topColor = UIColor.darkGray
    private let topFont = UIFont.appFont_Bold(Size: 22.0)
    private let bottomColor = UIColor.lightGray
    private let bottomFont = UIFont.appFont_FontRegular(Size: 16.0)
    
    private let spacing: CGFloat = 10
    private let imageViewHeight: CGFloat = 100
    private let bottomLabelWidth: CGFloat = 300
    
    private let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(infoTextClick))
    private var didTapHandler:(()->Void)?
    var didSetupConstraints = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    init(image: UIImage, top: String, bottom: String) {
        super.init(frame: CGRect.zero)
        setupViews()
        setupImageView(image: image)
        setupLabels(top: top, bottom: bottom)
    }
    @objc func infoTextClick(){
        if let handler = self.didTapHandler{
            handler()
        }
    }
    func didSetTapHandler(withHandler handler:(()->Void)?){
        if handler != nil {
            self.didTapHandler = handler
        }
    }
    
    func setupViews() {
        topSpace = UIView.newAutoLayout()
        bottomSpace = UIView.newAutoLayout()
        imageView = UIImageView.newAutoLayout()
        topLabel = UILabel.newAutoLayout()
        bottomLabel = UILabel.newAutoLayout()
        
        addSubview(topSpace)
        addSubview(bottomSpace)
        addSubview(imageView)
        addSubview(topLabel)
        addSubview(bottomLabel)
        
        topLabel.isUserInteractionEnabled = true
        bottomLabel.isUserInteractionEnabled = true
        
        topLabel.addGestureRecognizer(self.tapGesture)
        bottomLabel.addGestureRecognizer(self.tapGesture)
        
    }
    
    func setupImageView(image: UIImage) {
        imageView.image = image
        imageView.tintColor = topColor
    }
    
    func setupLabels(top: String, bottom: String) {
        topLabel.text = top
        topLabel.textColor = topColor
        topLabel.font = topFont
        
        bottomLabel.text = bottom
        bottomLabel.textColor = bottomColor
        bottomLabel.font = bottomFont
        bottomLabel.numberOfLines = 0
        bottomLabel.textAlignment = .center
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            topSpace.autoAlignAxis(toSuperviewAxis: .vertical)
            topSpace.autoPinEdge(toSuperviewEdge: .top)
            bottomSpace.autoAlignAxis(toSuperviewAxis: .vertical)
            bottomSpace.autoPinEdge(toSuperviewEdge: .bottom)
            topSpace.autoSetDimension(.height, toSize: spacing, relation: .greaterThanOrEqual)
            topSpace.autoMatch(.height, to: .height, of: bottomSpace)
            
            imageView.autoPinEdge(.top, to: .bottom, of: topSpace)
            imageView.autoAlignAxis(toSuperviewAxis: .vertical)
            imageView.autoSetDimension(.height, toSize: imageViewHeight, relation: .lessThanOrEqual)
            
            topLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            topLabel.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: spacing)
            
            bottomLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            bottomLabel.autoPinEdge(.top, to: .bottom, of: topLabel, withOffset: spacing)
            bottomLabel.autoPinEdge(.bottom, to: .top, of: bottomSpace)
            bottomLabel.autoSetDimension(.width, toSize: bottomLabelWidth)
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }

}
