//: Playground - noun: a place where people can play

import PlaygroundSupport
import Danbo

let view = UIView(frame: CGRect(x: 0, y: 0, width: 480, height: 720))
view.backgroundColor = .white
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = view

let image = #imageLiteral(resourceName: "girl.png")

let imageView = UIImageView(image: image)
imageView.center = CGPoint(x: 240, y: 480)
view.addSubview(imageView)


let rotation: Rotation = .degree(15)
let yStretching: CGFloat = 1 / cos(rotation.radianValue)
let yZoom: CGFloat = 1
let duration: TimeInterval = 0.6

func rotate(_ view: UIView, onGroundBy rotation: Rotation, stretching yScale: CGFloat) {
	
	let oldHeight = view.bounds.height
	let newHeight = oldHeight * yScale
	let translationX = newHeight * sin(rotation) / 2
	let translationY = (oldHeight - (newHeight * cos(rotation))) / 2
	
	view.danbo.transform { $0
		.reset()
		.scaleBy(dy: yScale)
		.rotate(by: rotation)
		.translateBy(dx: translationX, dy: translationY)
		.commit()
	}
	
}

func loop() {
	
	UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.calculationModePaced, .autoreverse, .repeat], animations: {
		
		UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
			rotate(imageView, onGroundBy: 0, stretching: yZoom)
		})
		
		UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
			rotate(imageView, onGroundBy: rotation, stretching: yStretching)
		})
		
	}, completion: nil)
	
}

func animate() {
	
	UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
		rotate(imageView, onGroundBy: -rotation, stretching: yStretching)
	}) { (_) in
		loop()
	}
	
}


animate()
