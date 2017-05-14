//: Playground - noun: a place where people can play

import PlaygroundSupport
import Danbo

let view = UIView(frame: CGRect(x: 0, y: 0, width: 480, height: 720))
view.backgroundColor = .white
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = view

let image = #imageLiteral(resourceName: "girl.png")
let imageView = UIImageView(image: image)

imageView.danbo.anchor { $0.put(y: 1) }
imageView.center = CGPoint(x: 240, y: 720)
view.addSubview(imageView)


let rotation: Rotation = .degree(15)
let duration: TimeInterval = 0.5

func rotate(_ view: UIView, onGroundBy rotation: Rotation) {
	
	let yScale: CGFloat = 1 / cos(rotation)
	
	view.danbo.transform { $0
		.reset()
		.scaleBy(dy: yScale)
		.rotate(by: rotation)
		.commit()
	}
	
}

func reset(_ view: UIView) {
	
	view.danbo.transform { $0
		.reset()
		.commit()
	}
	
}

func loop() {
	
	UIView.animateKeyframes(withDuration: duration * 2, delay: 0, options: [.calculationModeLinear, .autoreverse, .repeat], animations: {
		
		UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
			reset(imageView)
		})
		
		UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
			rotate(imageView, onGroundBy: rotation)
		})
		
	}, completion: nil)
	
}

func animate() {
	
	UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
		rotate(imageView, onGroundBy: -rotation)
	}) { (_) in
		loop()
	}
	
}


animate()
