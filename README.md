# NSKUIShapeLayer
Various customizable UI Elements with easy implementations directly from Xcode's Utility Area

## Installation
Drop the ‘NSKUIShapeLayer.swift’ file in your Xcode Project Navigator.

## Usage

### SquareCheckBox
Just drop an UIButton in the storyboard and make it an instance of “SquareCheckBox” class.
All of the necessary properties of this class are available in the Utility Area in Attributes Inspector.



### CircularCheckBtn
Just drop an UIButton in the storyboard and make it an instance of “SquareCheckBox” class.
All of the necessary properties of this class are available in the Utility Area in Attributes Inspector.



### SwitchCheckBtn
Just drop an UIButton in the storyboard and make it an instance of “SquareCheckBox” class.
All of the necessary properties of this class are available in the Utility Area in Attributes Inspector.



### SegmentedControlView
Just drop an UIView in the storyboard and make it an instance of “SquareCheckBox” class.
All of the necessary properties of this class are available in the Utility Area in Attributes Inspector.

#### Implementation


In Attributes Inspector write the name of segments as one string.
Originally each segment is one string stored in one variable i.e. **segments**, added in interface builder and it is divided into segments by putting '_' in-between. Following examples will explain more

if the string is "USCANADAUK"
this will create one segment with text "USCANADAUK"

if the string goes like "US_CANADA_UK"
this will create three segments each with following text respectively "US","CANADA" & “UK"

we need the property ‘selectedSegment’, which is an Int, it tells which segment is selected.
It needs to be observed using KVO.

i.e. we need to use following code
```
//create an outlet of this view

	@IBOutlet weak var seg : SegmentedControlView!

//add an observer for the ‘selectedSegment’ property
	self.seg.addObserver(self, forKeyPath: "selectedSegment", options: .new, context: nil)
      
//whenever the selectedSegment value changes make changes according to your requirement in the following code by overriding the “observeValue method” of the controller
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "selectedSegment"{
            //DO SOMETHING...
        }
    }
	deinit {
		self.seg.removeObserver(self, forKeyPath: “selectedSegment”)
	}
  ```
