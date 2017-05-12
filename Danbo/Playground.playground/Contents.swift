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

extension UIView {
	
	func rotateOnGround(by angle: CGFloat, stretching yScale: CGFloat) {
		
		let oldHeight = self.bounds.height
		let newHeight = oldHeight * yScale
		let translationX = newHeight * sin(angle) / 2
		let translationY = (oldHeight - (newHeight * cos(angle))) / 2
		
		self.danbo.transform { $0
			.reset()
			.scale(by: CGVector(dx: 1, dy: yScale))
			.rotate(by: angle)
			.translate(by: CGVector(dx: translationX, dy: translationY))
			.commit()
		}
		
	}
	
}

let angle: CGFloat = .pi / 12
let yStretching: CGFloat = 1 / cos(angle)
let yZoom: CGFloat = 1
let duration: TimeInterval = 0.6

func animate() {
	
	UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { 
		imageView.rotateOnGround(by: -angle, stretching: yStretching)
	}) { (_) in
		loop()
	}
	
}

func loop() {
	
	UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.calculationModePaced, .autoreverse, .repeat], animations: {
		
		UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
			imageView.rotateOnGround(by: 0, stretching: yZoom)
		})
		
		UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
			imageView.rotateOnGround(by: angle, stretching: yStretching)
		})
		
	}, completion: nil)
	
}

animate()
