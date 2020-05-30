//
//  CustomSegue.swift
//  vea
//
//  Created by sid on 5/30/20.
//  Copyright © 2020 ritvik. All rights reserved.
//

import UIKit


class CustomSegue: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination

        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        src.modalPresentationStyle = .fullScreen
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width*2, y: 0)

        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            dst.view.transform = CGAffineTransform(translationX: 0, y: 0) }, completion: { finished in src.present(dst, animated: false, completion: nil) })
        src.modalPresentationStyle = .fullScreen
        dst.modalPresentationStyle = .fullScreen


    }
}
