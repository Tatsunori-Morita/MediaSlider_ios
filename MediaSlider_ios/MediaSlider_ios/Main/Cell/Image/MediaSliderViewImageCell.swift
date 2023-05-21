//
//  MediaSliderViewImageCell.swift
//  AvplayerTestApp
//
//  Created by Tatsunori on 2023/03/29.
//

import UIKit

class MediaSliderViewImageCell: MediaSliderViewBaseCell {
    @IBOutlet private weak var imageView: UIImageView!

    public static let identifier = String(describing: MediaSliderViewImageCell.self)

    private var timer: Timer?
    private var _viewModel: MediaSliderCellViewModel!
    private var printLog: String {
        "index: \(_viewModel.index) fileName: \(_viewModel.fileName)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }

    private func initialize() {
        initializeLayout()
    }

    private func initializeLayout() {
        imageView.image = nil
    }

    public override func configure(viewModel: MediaSliderCellViewModel) {
        _viewModel = viewModel
        imageView.image = UIImage(named: viewModel.fileName)
    }

    private func startTimer() {
       timer = Timer.scheduledTimer(
        timeInterval: 5.0,
        target: self,
        selector: #selector(_didFinishPlaying),
        userInfo: nil,
        repeats: true)
     }

    public override func play() {
        print("play \(printLog)")
        startTimer()
    }

    @objc private func _didFinishPlaying() {
        print("didFinishPlaying \(printLog)")
        timer?.invalidate()
        didFinishPlaying?()
    }
}
