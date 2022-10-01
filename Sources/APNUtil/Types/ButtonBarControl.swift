//
//  ButtonBarControl.swift
//  APNUtil
//
//  Created by Aaron Nance on 1/23/21.
//  Copyright © 2021 Aaron Nance. All rights reserved.
//

import UIKit


/// `ButtonBarControl` action defintion
public struct BBCA {
    
    private(set) var text: String
    private(set) var closure: VoidHandler
 
    public init(_ text: String, _ closure: @escaping VoidHandler) {
        
        self.text       = text
        self.closure    = closure
        
    }
    
}

public class ButtonBarControl: UIView {
    
    // MARK: - Properties
    var initialized = false
    
    private weak var container: UIView!
    private var buttons             = [UIButton]()
    private var actions             = [BBCA]()
    private var buttonTitleColor    = UIColor.black
    private var buttonBGColor       = UIColor.white
    private var stack: UIStackView!
    
    
    // MARK: - Overrides
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        initUI()
        
    }
    
    /// Creates a bar of buttons then adds itself to `container`'s subviews array.
    /// - parameter container: the `UIView` into which the `ButtonBarControl` should be rendered.
    /// - parameter axis: the `NSLayoutConstraint` specifying the button orientation.
    /// - parameter buttonTitleColor: the `UIColor` for the button title text.
    /// - parameter buttonBGColor: the control's background color.
    /// - parameter buttonSpacing: the distance between buttons.1111
    /// - parameter actions: a dictionary with keys that specify the resulting buttons' labels and
    /// values specifying the action to take in response to the button's touchUpInside event.
    public convenience init(container: UIView,
                            axis: NSLayoutConstraint.Axis,
                            buttonTitleColor: UIColor,
                            buttonBGColor: UIColor,
                            buttonSpacing: CGFloat,
                            actions: [BBCA]) {

        self.init(frame: container.frame)
        
        self.container = container
        translatesAutoresizingMaskIntoConstraints = false
        
        stack                   = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.axis              = axis
        stack.spacing           = buttonSpacing
        stack.distribution      = .fillEqually
        
        stack.alignment         = .center
        
        stack.contentMode       = .scaleToFill
        self.buttonTitleColor   = buttonTitleColor
        self.buttonBGColor      = buttonBGColor
        self.actions            = actions
                
        addSubview(stack)
        
        container.addSubview(self)
        
    }
    
    
    // MARK: - Custom Methods
    private func initUI() {

        if initialized { return /*EXIT*/ }
        
        buildButtons()
        addConstraints()
        
        initialized = true
        
    }
    
    private func buildButtons() {
        
        for action in actions {
            
            let button = UIButton()
            
            buttons.append(button)
            
            button.setTitle(action.text, for: .normal)
            button.addTarget(nil,
                             action: #selector(didTap),
                             for: .touchUpInside)
            
            button.backgroundColor = buttonBGColor
            button.setTitleColor(buttonTitleColor,
                                 for: .normal)
            button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            
            stack.addArrangedSubview(button)
            
        }
        
    }
    
    private func addConstraints() {
        
        topAnchor.constraint(equalTo: container.topAnchor).isActive             = true
        bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive       = true
        leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive     = true
        trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive   = true
        
        stack.topAnchor.constraint(equalTo: topAnchor).isActive                 = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive           = true
        stack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive         = true
        stack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive       = true
        
        buttons.forEach{
            
            if stack.axis == .horizontal {
            
                $0.topAnchor.constraint(equalTo: stack.topAnchor).isActive          = true
                $0.bottomAnchor.constraint(equalTo: stack.bottomAnchor).isActive    = true
                
            } else {
                
                $0.leftAnchor.constraint(equalTo: stack.leftAnchor).isActive          = true
                $0.rightAnchor.constraint(equalTo: stack.rightAnchor).isActive    = true
                
            }
            
        }
        
    }
    
    @objc private func didTap(_ sender: UIButton) {
        
        for action in actions {
            
            if sender.title(for: .normal) == action.text {
                
                action.closure()
                
                return /*EXIT*/
                
            }
            
        }
        
    }
    
}
