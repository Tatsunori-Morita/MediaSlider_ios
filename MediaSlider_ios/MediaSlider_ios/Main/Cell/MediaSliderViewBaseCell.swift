//
//  MediaSliderViewBaseCell.swift
//  AvplayerTestApp
//
//  Created by Tatsunori on 2023/03/31.
//

import UIKit

class MediaSliderViewBaseCell: UICollectionViewCell {
    public var didFinishPlaying: (() -> Void)?
    public func configure(viewModel: MediaSliderCellViewModel) {}
    public func play() {}
}
