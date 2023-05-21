//
//  MediaSliderViewMovieCell.swift
//  AvplayerTestApp
//
//  Created by Tatsunori on 2023/03/29.
//

import UIKit
import AVKit

class MediaSliderViewMovieCell: MediaSliderViewBaseCell {
    @IBOutlet private weak var playerView: PlayerView!

    public static let identifier = String(describing: MediaSliderViewMovieCell.self)

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

    private func initializeLayout() {}

    override func prepareForReuse() {
        super.prepareForReuse()
        playerView.player?.removeObserver(
            self,
            forKeyPath: #keyPath(AVPlayerItem.status),
            context: nil)
    }

    public override func configure(viewModel: MediaSliderCellViewModel) {
        _viewModel = viewModel
        guard
            let url = Bundle.main.url(forResource: viewModel.fileName, withExtension: nil)
        else {
            return
        }

        let item = AVPlayerItem(url: url)
        playerView.player = AVPlayer(playerItem: item)
        playerView.playerLayer.videoGravity = .resizeAspectFill
        
        playerView.player?.addObserver(
            self,
            forKeyPath: #keyPath(AVPlayerItem.status),
            options: .new,
            context: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(_didFinishPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: item)
    }

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(AVPlayerItem.status) {
            if let statusNumber = change?[.newKey] as? NSNumber {
                let status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
                switch status {
                case .readyToPlay:
                    print("readyToPlay \(printLog)")
                    break
                case .failed:
                    print("failed \(printLog)")
                    break
                case .unknown:
                    print("unknown \(printLog)")
                    break
                @unknown default:
                    print("default \(printLog)")
                }
            }
        }
    }

    public override func play() {
        print("play \(printLog)")
        playerView.player?.play()
    }

    public func pause() {
        print("pause \(printLog)")
        playerView.player?.pause()
    }

    @objc private func _didFinishPlaying() {
        print("didFinishPlaying \(printLog)")
        didFinishPlaying?()
    }
}
