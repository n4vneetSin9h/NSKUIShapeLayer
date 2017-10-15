//
//  SquareChecBox.swift
//  Test
//
//  Created by Navneet Singh Kandara on 9/4/17.
//  Copyright © 2017 Cogniter. All rights reserved.
//

import UIKit
//most of the class are functional enough but still needs lots of improvement

//MARK: Rectangle Shaped Button
@IBDesignable class SquareCheckBox: UIButton {
    //MARK: - Properties
    @IBInspectable var isOn:Bool = false{
        didSet{
            self.setNeedsDisplay()
        }
    }
    //gives the actual functionality of the button
    
    
    @IBInspectable var tickWidth: CGFloat = 2.0
    //decides the width of the tick
    /*
     THIS VALUE CANNOT EXCEED THE HALF OF THE BUTTON'S HEIGHT OR GO BELOW ZERO. IT WILL RESET TO 3.0 IN ANY SUCH CASE.
     */
    
    
    @IBInspectable var borderWidth: CGFloat = 3.0
    //decides the width of the border of button
    /*
     THIS VALUE WILL BE RESET TO 3.0 IF THE DEVELOPER EXCEEDS THE 1/4TH OF THE BUTTON'S HEIGHT OR BELOW ZERO.
     */
    
    
    @IBInspectable var borderRadius: CGFloat = 3.0
    //decides the corner radius of the button
    /*
     THIS VALUE CANNOT EXCEED THE HALF OF THE BUTTON'S HEIGHT OR GO BELOW ZERO. IT WILL RESET TO 3.0 IN ANY SUCH CASE.
     */
    
    
    @IBInspectable public var borderColor: UIColor = UIColor(red: 255/255, green: 0, blue: 0, alpha: 1)
    //decides the color of the border of the button
    
    
    @IBInspectable public var BGColorOn: UIColor = UIColor(red: 255/255, green: 0, blue: 0, alpha: 1)
    //decides the color of button's background when it is checked
    
    
    @IBInspectable public var BGColorOff: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    //decides the color of button's background when it is checked
    
    
    @IBInspectable public var tickColor: UIColor = UIColor.white
    //decides the color of the tick
    
    //MARK: - Overriden Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    // Xcode uses this to render the button in the storyboard.
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // The storyboard loader uses this at runtime.
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        //setting target for button for animation on tap
        
        self.setTitle(nil, for: .normal)
        //removing any title as it doesn't allow the layers in button to form and crashes the App
    }
    
    override func draw(_ rect: CGRect) {
        let boxDim = min(bounds.height, bounds.width)
        self.clipsToBounds = true
        self.layer.borderColor = self.borderColor.cgColor
        
        
        //NOTE: we cannot set the value for the radius more than half of width if width is smaller than height OR we cannot set the value for the radius more than half of width if height is smaller than width
        if borderRadius < 0 || borderRadius > boxDim/2 {
            self.layer.cornerRadius = 3.0
        } else {
            self.layer.cornerRadius = self.borderRadius
        }
        
        //creating box
        let path = UIBezierPath(roundedRect: rect, cornerRadius: self.borderRadius)
        //creating tick
        let tickPath = UIBezierPath()
        
        tickPath.lineWidth = 2.0
        
        //tick's path
        if bounds.width > bounds.height{
            //when width is greater than height
            tickPath.move(to: CGPoint(x: bounds.width/2 - boxDim/3, y: boxDim/2))
            tickPath.addLine(to: CGPoint(x: bounds.width/2 - boxDim/6, y: ((boxDim)*3)/4))
            tickPath.addLine(to: CGPoint(x: bounds.width/2 + boxDim/3, y: boxDim/4))
        } else if bounds.width < bounds.height{
            //when height is greater than width
            tickPath.move(to: CGPoint(x: boxDim/6, y: bounds.height/2))
            tickPath.addLine(to: CGPoint(x: ((boxDim)*2)/6, y: (((boxDim)*3)/4) - boxDim/2 + bounds.height/2))
            tickPath.addLine(to: CGPoint(x: ((boxDim)*5)/6, y: bounds.height/2 - (boxDim/4)))
        } else {
            //when it's a square
            tickPath.move(to: CGPoint(x: boxDim/6, y: boxDim/2))
            tickPath.addLine(to: CGPoint(x: ((boxDim)*2)/6, y: ((boxDim)*3)/4))
            tickPath.addLine(to: CGPoint(x: ((boxDim)*5)/6, y: boxDim/4))
        }
        
        
        
        if isOn{
            self.layer.borderWidth = 0.0
            BGColorOn.setFill()//setting background color for when box is on
            path.fill()
            
            //creating sublayer
            let pathLayer = CAShapeLayer()
            pathLayer.frame = self.bounds
            pathLayer.path = tickPath.cgPath
            pathLayer.strokeColor = tickColor.cgColor//setting tick color
            pathLayer.fillColor = nil
            //NOTE: we cannot set the value for the width of tick more than one-fourth of width if width is smaller than height OR we cannot set the value for the width of tick more than one-fourth of width if height is smaller than width
            //we cannot set the value for the width of tick less than one
            if tickWidth < 1 || tickWidth > boxDim/4 {
                pathLayer.lineWidth = 2
            }else {
                pathLayer.lineWidth = tickWidth
            }
            
            pathLayer.lineJoin = kCALineJoinBevel
            
            //adding sublayer
            self.layer.addSublayer(pathLayer)
            
            //animating
            let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
            pathAnimation.duration = 0.5
            pathAnimation.fromValue = 0.0
            pathAnimation.toValue = 1.0
            pathLayer.add(pathAnimation, forKey: "strokeEnd")
        } else {
            if borderWidth < 0 || borderWidth > boxDim/4 {
                self.layer.borderWidth = 3.0
            } else {
                self.layer.borderWidth = self.borderWidth
            }
            BGColorOff.setFill()
            path.fill()
            self.layer.sublayers?.removeAll()
            //removing all sublayers
        }
    }
    //MARK: - Custom Functions
    //function called for changing values
    @objc func buttonTapped(){
        self.isOn = !self.isOn
    }
}

//....................................................
//MARK: -
//MARK: -
//MARK: Circle Shaped Button
//this button should always be a square
@IBDesignable class CircularCheckBtn: UIButton {
    //MARK: - Properties
    @IBInspectable var isOn:Bool = false{
        didSet{
            self.setNeedsDisplay()
        }
    }
    //gives the actual functionality of the button
    
    @IBInspectable public var borderColorOn: UIColor = UIColor(red: 255/255, green: 0, blue: 0, alpha: 1)
    //decides the border color of the button ON
    
    @IBInspectable public var borderColorOff: UIColor = UIColor.darkGray
    //decides the border color of the button when OFF
    
    @IBInspectable public var fillingColor: UIColor = UIColor(red: 255/255, green: 0, blue: 0, alpha: 0.65)
    //decides the color to be filled on selection
    
    @IBInspectable public var centerColor: UIColor = UIColor(red: 255/255, green: 0, blue: 0, alpha: 1)
    //decides the color for central circle on selection
    
    //MARK: - Overriden Funcitons
    // Xcode uses this to render the button in the storyboard.
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // The storyboard loader uses this at runtime.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        self.setTitle(nil, for: .normal)
        //removing any title as it doesn't allow the layers in button to form and crashes the App
        
        self.addTarget(self, action: #selector(isTapped), for: .touchUpInside)
    }
    
    override func draw(_ rect: CGRect) {
        //initial functinalities
        self.clipsToBounds = true
        self.layer.borderWidth = 1.0
        let CDim = min(bounds.width, bounds.height)
        
        
        self.layer.cornerRadius = bounds.width/2
        let path = UIBezierPath(ovalIn: rect)
        UIColor.white.setFill()
        path.fill()
        //handling the ON/OFF state of the button
        if isOn{
            
            self.layer.borderColor = borderColorOn.cgColor
            
            let onPath = UIBezierPath(
                arcCenter: CGPoint(x: CDim/2, y: CDim/2) ,
                radius: (CDim/2 - ((CDim)*3)/20)/2 + ((CDim)*3)/20 + 1,
                startAngle: 0.0,
                endAngle: CGFloat(2*Double.pi),
                clockwise: false)
            onPath.lineWidth = (CDim/2 - ((CDim)*3)/20)
            self.fillingColor.setStroke()
            onPath.stroke()
            
            let innerPath = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: CDim/2 - ((CDim)*3)/20 - 1, y: CDim/2 - ((CDim)*3)/20 - 1), size: CGSize(width: ((CDim)*3)/10 + 2, height: ((CDim)*3)/10 + 2)))
            self.centerColor.setFill()
            innerPath.fill()
        }else {
            self.layer.borderColor = borderColorOff.cgColor
        }
    }
    
    //MARK: - Custom Functions
    //function called for changing values
    @objc func isTapped(){
        isOn = !isOn
    }
    
}

//....................................................
//MARK: -
//MARK: -
//MARK: UISwitch Style Button
//this button is recommended to always have height half of its width
@IBDesignable class SwitchCheckBtn: UIButton {
    //MARK: - Properties
    @IBInspectable var isOn: Bool = false{
        didSet{
            self.setNeedsDisplay()
        }
    }
    //give the basic functionality to the button
    
    fileprivate var removableLayer = CAShapeLayer()
    fileprivate var x: CGFloat = 0
    fileprivate var y: CGFloat = 0
    //these variable will store the width and height of the button
    
    //this decides the button border color
    @IBInspectable public var btnBorderColor: UIColor = UIColor.darkGray
    
    //decides button corner radius
    @IBInspectable public var btnCornerRadius: CGFloat = 5.0
    
    //decides button background color when OFF
    @IBInspectable public var btnOffBGColor: UIColor = UIColor.lightGray
    
    //decides button background when ON
    @IBInspectable public var btnOnBGColor: UIColor = UIColor(red: 0, green: 2.5/3, blue: 0, alpha: 1)
    
    //decides color of inner button
    @IBInspectable public var btnHandleColor: UIColor = UIColor.white
    
    //decides the color of tick
    @IBInspectable public var tickColor: UIColor = UIColor.white
    
    //decides the color of cross
    @IBInspectable public var crossColor: UIColor = UIColor.white
    
    
    //MARK: - Overriden Functions
    // Xcode uses this to render the button in the storyboard.
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    // The storyboard loader uses this at runtime.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        self.setTitle(nil, for: .normal)
        //removing any title as it doesn't allow the layers in button to form and crashes the App
        self.addTarget(self, action: #selector(isTapped), for: .touchUpInside)
    }
    
    override func draw(_ rect: CGRect) {
        x = bounds.width
        y = bounds.height
        //btn layer
        self.clipsToBounds = true
        
        if btnCornerRadius < 0 || btnCornerRadius > self.bounds.height/2 {
            self.layer.cornerRadius = 5.0
        } else {
            self.layer.cornerRadius = btnCornerRadius
        }
        self.layer.borderWidth = 0.5
        self.layer.borderColor = btnBorderColor.cgColor
        
        //background layer
        let backgroundView = UIView(frame: rect)
        backgroundView.backgroundColor = btnOffBGColor
        backgroundView.isUserInteractionEnabled = false
        backgroundView.isExclusiveTouch = false
        
        // handling ON/OFF state
        if !isOn{
            //image for OFF situation
            //button background
            backgroundView.backgroundColor = btnOffBGColor
            self.addSubview(backgroundView)
            //btnHandle
            let btnHandle = UIButton(frame: CGRect(x: bounds.width/2 + 1, y: 1, width: bounds.width/2 - 2 , height: bounds.height - 2.5))
            btnHandle.backgroundColor = btnHandleColor
            btnHandle.layer.cornerRadius = self.layer.cornerRadius
            btnHandle.isUserInteractionEnabled = false
            btnHandle.isExclusiveTouch = false
            self.addSubview(btnHandle)
            
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: { () in
                            btnHandle.transform = CGAffineTransform(translationX: -(self.x/2), y: 0)
            }
            )
            
            //cross path
            let cross = UIBezierPath()
            cross.move(to: CGPoint(x: ((bounds.width - 2)*5)/8 + 1, y: (bounds.height - 2)/4 + 1))
            cross.addLine(to: CGPoint(x: ((bounds.width - 2)*7)/8, y: ((bounds.height - 2)*3)/4 + 1))
            cross.move(to: CGPoint(x: ((bounds.width - 2)*5)/8 + 1, y: ((bounds.height - 2)*3)/4 + 1))
            cross.addLine(to: CGPoint(x: ((bounds.width - 2)*7)/8, y: (bounds.height - 2)/4 + 1))
            
            //path sublayer
            let pathLayer = CAShapeLayer()
            pathLayer.frame = self.bounds
            pathLayer.lineCap = kCALineCapRound
            pathLayer.path = cross.cgPath
            pathLayer.strokeColor = crossColor.cgColor//setting tick color
            pathLayer.fillColor = nil
            pathLayer.lineWidth = 2.0
            pathLayer.lineJoin = kCALineJoinRound
            
            //adding sublayer
            self.layer.addSublayer(pathLayer)
            removableLayer = pathLayer
            //animating sublayer
            let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
            pathAnimation.duration = 0.5
            pathAnimation.fromValue = 0.0
            pathAnimation.toValue = 1.0
            pathLayer.add(pathAnimation, forKey: "strokeEnd")
        } else {
            //image for ON situation
            //button background
            backgroundView.backgroundColor = btnOnBGColor
            
            self.addSubview(backgroundView)
            //btnHandle
            let btnHandle = UIButton(frame: CGRect(x: 1, y: 1, width: bounds.width/2 - 2 , height: bounds.height - 2.5))
            btnHandle.backgroundColor = btnHandleColor
            btnHandle.layer.cornerRadius = self.layer.cornerRadius
            btnHandle.isUserInteractionEnabled = false
            btnHandle.isExclusiveTouch = false
            self.addSubview(btnHandle)
            
            //animation
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: { () in
                            btnHandle.transform = CGAffineTransform(translationX: self.x/2, y: 0)
            })
            //tick path
            let tick = UIBezierPath()
            tick.move(to: CGPoint(x: (bounds.width - 4)/12 + 1, y: bounds.height/2))
            tick.addLine(to: CGPoint(x: (bounds.width - 4)*2/12 + 1, y: (bounds.height*3)/4))
            tick.addLine(to: CGPoint(x: (bounds.width - 4)*5/12 + 1, y: bounds.height/4))
            
            //path sublayer
            let pathLayer = CAShapeLayer()
            pathLayer.frame = self.bounds
            pathLayer.lineCap = kCALineCapRound
            pathLayer.path = tick.cgPath
            pathLayer.strokeColor = tickColor.cgColor//setting tick color
            pathLayer.fillColor = nil
            pathLayer.lineWidth = 2.0
            pathLayer.lineJoin = kCALineJoinRound
            
            //adding sublayer
            self.layer.addSublayer(pathLayer)
            removableLayer = pathLayer
            //animating sublayer
            let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
            pathAnimation.duration = 0.5
            pathAnimation.fromValue = 0.0
            pathAnimation.toValue = 1.0
            pathLayer.add(pathAnimation, forKey: "strokeEnd")
        }
    }
    
    //MARK: - Custom Functions
    //function called for changing values
    @objc func isTapped(){
        self.isOn = !self.isOn
        //self.layer.sublayers?.removeAll()
        removableLayer.removeFromSuperlayer()
        for subview in self.subviews{
            subview.removeFromSuperview()
        }
    }
}

//....................................................
//MARK: -
//MARK: -
//MARK: Segments

@IBDesignable class SegmentedControlView: UIView{
    
    //declaring the string value to be used as segments
    @IBInspectable var segments: String = ""
    
    //this decides the segments tint color
    @IBInspectable public var segmentTintColor: UIColor = UIColor.white
    
    //this decides the color of text of selected segment that's selected
    @IBInspectable public var titlesOnColor: UIColor = UIColor.black
    
    //this decides the color of text of selected segment that's not selected
    @IBInspectable public var titlesOffColor: UIColor = UIColor.white
    
    //decides the color of selected segment background
    @IBInspectable public var selectedSegementBGColor: UIColor = UIColor.white
    
    //decides the color of non-selected segment background
    @IBInspectable public var segmentControlBGColor: UIColor = UIColor.clear
    
    //decides the corner radius of the segment
    @IBInspectable public var segmentCornerRadius: CGFloat = 5.0
    
    //this is the view's location on horizontal axis where it will move to with animation
    fileprivate var dragableViewX: CGFloat = 1
    
    //this is the current location of view on horizontal axis where we leave it
    fileprivate var presentLocationX: CGFloat = 1
    
    //this is the list of each segments location on horizontal axis
    fileprivate var btnBoundaryPoints = [CGFloat]()
    
    //this variable store x location of the variable
    fileprivate var max: CGFloat = 0
    
    // this is array of texts in each segment
    var segmentTextArray = [String]()
    
    //this variable stores the cardinality of segments
    var numberOfSegments = 0
    
    //stores each segment as UIButton. It's public to allow the programmer make desirable changes to it.
    var segmentButtons = [UIButton]()
    
    //this is the actual variable desiding which element is selected
    @objc dynamic var selectedSegment: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    // The storyboard loader uses this at runtime.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        //originally each segment is one string stored in one variable i.e. segments, added in interface builder and it is divided into segments by puttind '_' in-between following examples will explain
        /*
         if the string is "USCANADAUK"
         this will create one segment with text "USCANADAUK"
         
         if the string goes like "US_CANADA_UK"
         this will create three segments each with following text respectively "US","CANADA" & "UK"
         */
        segmentTextArray = segments.components(separatedBy: "_")
        self.backgroundColor = segmentControlBGColor
        numberOfSegments = segmentTextArray.count
        for segment in 0 ..< numberOfSegments {
            btnBoundaryPoints.append((self.frame.width) * (CGFloat(segment)/CGFloat(numberOfSegments)) + 1)
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true
        
        //limitaion is applied to the corner radius of the button one cannot go below 0 or above the frames height half
        if segmentCornerRadius >= 0 && segmentCornerRadius <= self.frame.height/2{
            self.layer.cornerRadius = segmentCornerRadius
        } else {
            self.layer.cornerRadius = 3.0
        }
        
        self.layer.borderWidth = 2.0
        self.layer.borderColor = segmentTintColor.cgColor
        let numbersOfSegmentations: Int = segmentTextArray.count
        
        let dragableView = UIView(frame: CGRect(x: presentLocationX, y: 1, width: self.frame.width/CGFloat(numbersOfSegmentations) - 2, height: self.frame.height - 2))
        
        //limitaion is applied to the corner radius of the button one cannot go below 0 or above the frames height half
        if segmentCornerRadius >= 0 && segmentCornerRadius <= self.frame.height/2{
            dragableView.layer.cornerRadius = segmentCornerRadius
        } else {
            dragableView.layer.cornerRadius = 3.0
        }
        dragableView.backgroundColor = selectedSegementBGColor
        
        var index = 0
        //iterating over each segment when being drawn
        for segment in 0 ..< numbersOfSegmentations {
            //making the segment buttons
            let segmentBtn = UIButton(frame: CGRect(x: (self.frame.width) * (CGFloat(segment)/CGFloat(numbersOfSegmentations)) + 1, y: 1, width: self.frame.width/CGFloat(numbersOfSegmentations) - 2, height: self.frame.height - 2))
            segmentBtn.setTitle(segmentTextArray[segment], for: .normal)
            segmentBtn.backgroundColor = UIColor.clear
            segmentBtn.clipsToBounds = true
            segmentBtn.layer.cornerRadius = segmentBtn.frame.height/2
            segmentBtn.titleLabel?.textAlignment = NSTextAlignment.center
            segmentBtn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 13.0)!
            if Int(segmentBtn.frame.minX) == Int(dragableViewX){
                segmentBtn.setTitleColor(titlesOnColor, for: .normal)
                
                UIView.animate(withDuration: 0.25,
                       delay: 0,
                       usingSpringWithDamping: 0.95,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {() in
                        dragableView.transform = CGAffineTransform(translationX: self.dragableViewX - self.presentLocationX, y: 0)
                       }
                )
                createPanGestureRecognizer(targetView: dragableView)
                self.addSubview(dragableView)
                segmentBtn.isUserInteractionEnabled = false
                segmentBtn.isExclusiveTouch = false
                selectedSegment = index
            } else {
                segmentBtn.setTitleColor(titlesOffColor, for: .normal)
                segmentBtn.isUserInteractionEnabled = true
                segmentBtn.isExclusiveTouch = true
            }
            index += 1
            segmentBtn.addTarget(self, action: #selector(segmentTapped(sender:)), for: .touchUpInside)
            segmentButtons.append(segmentBtn)
            self.addSubview(segmentBtn)
        }
    }
    
    //MARK: - Custom Functions
    //this function redraws the segment after someinteraction has been made with it by user
    @objc func segmentTapped(sender: UIButton!){
        
        dragableViewX = sender.frame.minX
        for subViews in self.subviews as [UIView] {
            subViews.removeFromSuperview()
        }

        self.setNeedsDisplay()
        
        perform(#selector(setPresentLocation), with: nil, afterDelay: 0)
    }
    
    //this function reassign the values of location variables
    @objc func setPresentLocation(){
        presentLocationX = dragableViewX
    }
    
    //this function create the pangesture variable to handle the dragging of segment selection view
    func createPanGestureRecognizer(targetView: UIView){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handle(panGesture:)))
        targetView.addGestureRecognizer(panGesture)
    }
    
    //this handles the actions of pan gesture of the view
    @objc func handle(panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: self)
        panGesture.setTranslation(CGPoint.zero, in: self)
        
        let label = panGesture.view!
        label.center = CGPoint(x: label.center.x + translation.x, y: label.center.y + 0)
        label.isUserInteractionEnabled = true
        
        
        
        if panGesture.state == UIGestureRecognizerState.began {
            // add something you want to happen when the Label Panning has started
            for buttons in segmentButtons{
                self.bringSubview(toFront: buttons)
            }
        }
        
        if panGesture.state == UIGestureRecognizerState.ended {
            // add something you want to happen when the Label Panning has ended
            
            var index: CGFloat = 0
            for nums in btnBoundaryPoints{
                if nums < label.frame.midX{
                    index = CGFloat(btnBoundaryPoints.index(of: nums)!)
                }
            }
            
            dragableViewX = btnBoundaryPoints[Int(index)]
            for subViews in self.subviews as [UIView] {
                subViews.removeFromSuperview()
            }
            
            self.setNeedsDisplay()
            perform(#selector(setPresentLocation), with: nil, afterDelay: 0)
        }
        
        if panGesture.state == UIGestureRecognizerState.changed {
            // add something you want to happen when the Label Panning has been change ( during the moving/panning )
            presentLocationX = label.frame.minX
            max = label.frame.maxX
            for buttons in segmentButtons{
                buttons.titleLabel?.textColor = titlesOffColor
                if buttons.frame.midX >= presentLocationX && buttons.frame.midX < max{
                    buttons.titleLabel?.textColor = titlesOnColor
                }
            }
        } else {  
            // or something when its not moving
            
        }
        
    }
}

//....................................................
//all class below this point are still in the need of lots of improvements. it's functional for now but very static featured.
//MARK: -
//MARK: -
//MARK: - Progress Bar

//it presently work only in horizontal direction
//checkpoints should be limited 6 or 7
@IBDesignable class NSKProgressCheckBar: UIView{
    
    // this decides the no. of checkPoints that's needed in this view
    @IBInspectable var noOfCheckPoints: Int = 4
    
    //
    fileprivate var initialState = 0
    fileprivate var circleRadius: CGFloat = 0.0
    fileprivate var tickY = CGFloat()
    fileprivate var activationState = 0{
        didSet{
            setNeedsDisplay()
        }
    }
    fileprivate var boxDim: CGFloat = 0
    
    
    fileprivate var allPoints = [CGPoint]()
    fileprivate var lineComboPoint = [(CGPoint, CGPoint)]()
    let linePath = {(startPoint:CGPoint,endPoint:CGPoint) -> (UIBezierPath) in
        let linePath = UIBezierPath()
        linePath.move(to: startPoint)
        linePath.addLine(to: endPoint)
        return linePath
    }
    
    fileprivate var circlePoint = [CGPoint]()
    let circlePath = {(center:CGPoint, radius:CGFloat, startAngle:CGFloat, endAngle: CGFloat) -> (UIBezierPath) in
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        return circlePath
    }
    
    
    let animatePath = { (path: UIBezierPath, frame: CGRect, fillColor: UIColor?, layer: CALayer, lineWidth: CGFloat, duration: CFTimeInterval) -> () in
        let pathLayer = CAShapeLayer()
        pathLayer.frame = frame
        pathLayer.path = path.cgPath
        pathLayer.lineWidth = lineWidth
        pathLayer.strokeColor = UIColor.black.cgColor
        pathLayer.fillColor = fillColor?.cgColor
        layer.addSublayer(pathLayer)
        
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = duration
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = 1.0
        pathLayer.add(pathAnimation, forKey: "strokeEnd")
        
    }
    
    let animatePathRemoval = { (path: UIBezierPath, frame: CGRect, fillColor: UIColor?,layer: CALayer, lineWidth: CGFloat, duration: CFTimeInterval) -> () in
        let pathLayer = CAShapeLayer()
        pathLayer.frame = frame
        pathLayer.path = path.cgPath
        pathLayer.lineWidth = lineWidth
        pathLayer.strokeColor = UIColor.black.cgColor
        pathLayer.fillColor = fillColor?.cgColor
        layer.addSublayer(pathLayer)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    // The storyboard loader uses this at runtime.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        
        allPoints.append(CGPoint(x: 0.0, y: self.bounds.height - self.frame.height/2))
        for points in 0..<((noOfCheckPoints * 2) - 1){
            let val = (self.bounds.width/CGFloat((noOfCheckPoints * 2) - 1)) * CGFloat(points+1)
            let string = String(describing: val)
            var newString = ""
            let array = Array(string)
            let charIndex = array.index(where: { (char) -> Bool in
                char == "."
            })! + 2
            
            for index in 0..<charIndex{
                newString.append(array[index])
            }
            
            let cgFloat = CGFloat(Float(newString)!)
            
            allPoints.append(CGPoint(x: cgFloat, y: self.bounds.height - self.frame.height/2))
            
        }
        for points in allPoints{
            if allPoints.index(where: { (point) -> Bool in
                point == points
            })!%2 != 0{
                circlePoint.append(points)
                let index = allPoints.index(where: { (point) -> Bool in
                    point == points
                })
                let lastIndex = allPoints.endIndex - 1
                if index != lastIndex{
                    lineComboPoint.append((points, allPoints[index! + 1]))
                }
                
            }
        }
        
        self.circleRadius =  (self.bounds.width/CGFloat((noOfCheckPoints * 2) - 1))/2
        boxDim = 2 * circleRadius
        tickY = (self.frame.height / 2) + circleRadius + 3
    }
    
    
    
    override func draw(_ rect: CGRect) {
        if activationState != 0{
            if initialState < activationState{
                if activationState == 1{
                    
                    let center = CGPoint(x: circlePoint[activationState - 1].x - circleRadius, y: circlePoint[activationState - 1].y)
                    let path = circlePath(center, circleRadius, 0, CGFloat(2 * Double.pi))
                    
                    animatePath(path, rect, UIColor.white, self.layer, 2.0, 0.5)
                    let diffX = allPoints[(activationState * 2) - 2].x
                    
                    let tickPath = UIBezierPath()
                    tickPath.move(to: CGPoint(x: diffX + boxDim/6, y: tickY/2))
                    tickPath.addLine(to: CGPoint(x: diffX + ((boxDim)*2)/6 + 2, y: ((tickY)*3)/4 - 2))
                    tickPath.addLine(to: CGPoint(x: diffX + ((boxDim)*5)/6 , y: tickY/4 + 4))
                    
                    animatePath(tickPath, rect, nil, self.layer, 2.0, 0.5)
                }else{
                    let firstPath = linePath(lineComboPoint[activationState - 2].0, lineComboPoint[activationState - 2].1)
                    
                    let center = CGPoint(x: circlePoint[activationState - 1].x - circleRadius, y: circlePoint[activationState - 1].y)
                    let secondPath = circlePath(center, circleRadius, CGFloat(Double.pi), CGFloat(2 * Double.pi + Double.pi))
                    
                    let diffX = allPoints[(activationState * 2) - 2].x
                    let tickPath = UIBezierPath()
                    tickPath.move(to: CGPoint(x: diffX + boxDim/6, y: tickY/2))
                    tickPath.addLine(to: CGPoint(x: diffX + ((boxDim)*2)/6 + 2, y: ((tickY)*3)/4))
                    tickPath.addLine(to: CGPoint(x: diffX + ((boxDim)*5)/6, y: tickY/4 + 4))
                    firstPath.append(secondPath)
                    animatePath(firstPath, rect, UIColor.white, self.layer, 2.0, 1.0)
                    animatePath(tickPath, rect, nil, self.layer, 2.0, 0.25)
                }
            } else {
                //... decreement case
                self.layer.sublayers?.removeAll()
                for state in 1...activationState{
                    if state == 1{
                        let center = CGPoint(x: circlePoint[state - 1].x - circleRadius, y: circlePoint[state - 1].y)
                        let path = circlePath(center, circleRadius, 0, CGFloat(2 * Double.pi))
                        let diffX = allPoints[(state * 2) - 2].x
                        let tickPath = UIBezierPath()
                        tickPath.move(to: CGPoint(x: diffX + boxDim/6, y: tickY/2))
                        tickPath.addLine(to: CGPoint(x: diffX + ((boxDim)*2)/6 + 2, y: ((tickY)*3)/4 - 2))
                        tickPath.addLine(to: CGPoint(x: diffX + ((boxDim)*5)/6, y: tickY/4 + 4))
                        
                        
                        animatePathRemoval(path, rect, UIColor.white, self.layer, 2.0, 0.0)
                        animatePathRemoval(tickPath, rect, nil, self.layer, 2.0, 0.0)
                    }else{
                        let firstPath = linePath(lineComboPoint[state - 2].0, lineComboPoint[state - 2].1)
                        animatePathRemoval(firstPath, rect, UIColor.white, self.layer, 2.0, 0.0)
                        
                        let center = CGPoint(x: circlePoint[state - 1].x - circleRadius, y: circlePoint[state - 1].y)
                        let secondPath = circlePath(center, circleRadius, CGFloat(Double.pi), CGFloat(2 * Double.pi + Double.pi))
                        animatePathRemoval(secondPath, rect, UIColor.white, self.layer, 2.0, 0.0)
                        
                        let diffX = allPoints[(state * 2) - 2].x
                        let tickPath = UIBezierPath()
                        tickPath.move(to: CGPoint(x: diffX + boxDim/6, y: tickY/2))
                        tickPath.addLine(to: CGPoint(x: diffX + ((boxDim)*2)/6 + 2, y: ((tickY)*3)/4 - 2))
                        tickPath.addLine(to: CGPoint(x: diffX  + ((boxDim)*5)/6, y: tickY/4 + 4))
                        animatePathRemoval(tickPath, rect, nil, self.layer, 2.0, 0.0)
                    }
                }
            }
        } else {
            self.layer.sublayers?.removeAll()
        }
    }
    
    //MARK:- Custom Funtions
    //this moves us to next checkpoint
    var nextStep: () -> () { return
    { () in
            self.initialState = self.activationState
        if self.activationState >= 0 && self.activationState < self.noOfCheckPoints{
            self.activationState += 1
        }
        }
    }
    
    //this brings us back to previous check point
    var previousStep: () -> () { return
    { () in
            self.initialState = self.activationState
        if self.activationState > 0 && self.activationState <= self.noOfCheckPoints{
            self.activationState -= 1
        }
        }
    }
}

@IBDesignable class BorderView: UIView {
    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        let path = UIBezierPath(roundedRect: CGRect(x: 4, y: 4, width: self.frame.width - 8, height: self.frame.height - 8), cornerRadius: 12)
        path.lineWidth = 2.0
        path.lineCapStyle = .round
        path.setLineDash([6.0,4.0], count: 2, phase: 0.0)
        UIColor.white.setStroke()
        path.stroke()
    }
}


