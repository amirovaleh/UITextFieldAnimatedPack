//
//  PaddingLabel.swift
//
//
//  Created by Valeh Amirov on 10.05.24.
//

import UIKit

internal final class PaddingLabel: UILabel {

    private let topInset: CGFloat = 0
    private let bottomInset: CGFloat = 0
    private let leftInset: CGFloat = 4.0
    private let rightInset: CGFloat = 4.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}
