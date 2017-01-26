//
//  LoadingView.swift
//
//  Code generated using QuartzCode 1.55.0 on 2017/01/25.
//  www.quartzcodeapp.com
//

import UIKit

@IBDesignable
class LoadingView: UIView, CAAnimationDelegate {
	
	var layers : Dictionary<String, AnyObject> = [:]
	var completionBlocks : Dictionary<CAAnimation, (Bool) -> Void> = [:]
	var updateLayerValueForCompletedAnimation : Bool = false
	
	
	
	//MARK: - Life Cycle
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupProperties()
		setupLayers()
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		setupProperties()
		setupLayers()
	}
	
	
	
	func setupProperties(){
		
	}
	
	func setupLayers(){
		let replicator = CAReplicatorLayer()
		replicator.frame = CGRect(x: 18.44, y: 18.44, width: 63.11, height: 63.11)
		self.layer.addSublayer(replicator)
		layers["replicator"] = replicator
		let oval = CAShapeLayer()
		oval.frame = CGRect(x: 27.56, y: 12.06, width: 8, height: 8)
		oval.path = ovalPath().cgPath
		replicator.addSublayer(oval)
		layers["oval"] = oval
		
		resetLayerProperties(forLayerIdentifiers: nil)
	}
	
	func resetLayerProperties(forLayerIdentifiers layerIds: [String]!){
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		
		if layerIds == nil || layerIds.contains("replicator"){
			let replicator = layers["replicator"] as! CAReplicatorLayer
			replicator.instanceCount     = 10
			replicator.instanceDelay     = 0.1
			replicator.instanceColor     = UIColor.white.cgColor
			replicator.instanceTransform = CATransform3DMakeRotation(36 * CGFloat(M_PI/180), 0, 0, -1)
		}
		if layerIds == nil || layerIds.contains("oval"){
			let oval = layers["oval"] as! CAShapeLayer
			oval.fillColor   = UIColor(red:0.922, green: 0.225, blue:0.302, alpha:1).cgColor
			oval.strokeColor = UIColor.white.cgColor
		}
		
		CATransaction.commit()
	}
	
	//MARK: - Animation Setup
	
	func addLoadingAnimation(){
		let fillMode : String = kCAFillModeForwards
		
		////An infinity animation
		
		////Oval animation
		let ovalOpacityAnim      = CAKeyframeAnimation(keyPath:"opacity")
		ovalOpacityAnim.values   = [1, 0]
		ovalOpacityAnim.keyTimes = [0, 1]
		ovalOpacityAnim.duration = 1
		
		let ovalTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
		ovalTransformAnim.values   = [NSValue(caTransform3D: CATransform3DIdentity), 
			 NSValue(caTransform3D: CATransform3DMakeScale(0.2, 0.2, 1))]
		ovalTransformAnim.keyTimes = [0, 1]
		ovalTransformAnim.duration = 1
		
		let ovalLoadingAnim : CAAnimationGroup = QCMethod.group(animations: [ovalOpacityAnim, ovalTransformAnim], fillMode:fillMode)
		ovalLoadingAnim.repeatCount = Float.infinity
		layers["oval"]?.add(ovalLoadingAnim, forKey:"ovalLoadingAnim")
	}
	
	//MARK: - Animation Cleanup
	
	func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
		if let completionBlock = completionBlocks[anim]{
			completionBlocks.removeValue(forKey: anim)
			if (flag && updateLayerValueForCompletedAnimation) || anim.value(forKey: "needEndAnim") as! Bool{
				updateLayerValues(forAnimationId: anim.value(forKey: "animId") as! String)
				removeAnimations(forAnimationId: anim.value(forKey: "animId") as! String)
			}
			completionBlock(flag)
		}
	}
	
	func updateLayerValues(forAnimationId identifier: String){
		if identifier == "Loading"{
			QCMethod.updateValueFromPresentationLayer(forAnimation: (layers["oval"] as! CALayer).animation(forKey: "ovalLoadingAnim"), theLayer:(layers["oval"] as! CALayer))
		}
	}
	
	func removeAnimations(forAnimationId identifier: String){
		if identifier == "Loading"{
			(layers["oval"] as! CALayer).removeAnimation(forKey: "ovalLoadingAnim")
		}
	}
	
	func removeAllAnimations(){
		for layer in layers.values{
			(layer as! CALayer).removeAllAnimations()
		}
	}
	
	//MARK: - Bezier Path
	
	func ovalPath() -> UIBezierPath{
		let ovalPath = UIBezierPath(ovalIn:CGRect(x: 0, y: 0, width: 8, height: 8))
		return ovalPath
	}
	
	
}
