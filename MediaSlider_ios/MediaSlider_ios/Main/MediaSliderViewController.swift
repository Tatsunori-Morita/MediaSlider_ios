//
//  MediaSliderViewController.swift
//  AvplayerTestApp
//
//  Created by Tatsunori on 2023/03/12.
//

import UIKit

class MediaSliderViewController: UIViewController {
    private var collectionView: UICollectionView!
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()

    public var readyToPlay: (() -> Void)?

    private var mediaCells: [Medium] = []
    private var currentIndex = 0
    private var timer: Timer?
    private var currentIndexPath: IndexPath {
        IndexPath(row: currentIndex, section: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        readyToPlay?()
        layout.itemSize = CGSize(width: view.bounds.width, height: view.bounds.width)
    }

    private func initialize() {
        view.backgroundColor = .white

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UINib(nibName: MediaSliderViewMovieCell.identifier, bundle: nil), forCellWithReuseIdentifier: MediaSliderViewMovieCell.identifier)
        collectionView.register(UINib(nibName: MediaSliderViewImageCell.identifier, bundle: nil), forCellWithReuseIdentifier: MediaSliderViewImageCell.identifier)
        collectionView.backgroundColor = .lightGray
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)

        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    public func configure(media: [Medium]) {
        mediaCells = media
    }

    public func play() {
        if mediaCells.isEmpty {
            print("Not Found play media.")
            return
        }
        let medium = mediaCells[currentIndexPath.row]
        if medium.type == .movie {
            if let cell = collectionView.cellForItem(at: currentIndexPath) as? MediaSliderViewMovieCell {
                cell.play()
            }
        } else {
            if let cell = collectionView.cellForItem(at: currentIndexPath) as? MediaSliderViewImageCell {
                cell.play()
            }
        }
    }

    private func next(){
        if currentIndex < mediaCells.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        collectionView.scrollToItem(
            at: currentIndexPath,
            at: .centeredHorizontally,
            animated: true)
    }
}

extension MediaSliderViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mediaCells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let medium = mediaCells[indexPath.row]
        if medium.type == .movie {
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaSliderViewMovieCell.identifier, for: indexPath) as? MediaSliderViewMovieCell
            else {
                return UICollectionViewCell()
            }
            cell.configure(viewModel: MediaSliderCellViewModel(index: indexPath.row, medium: medium))
            cell.didFinishPlaying = {
                print("didFinishPlaying in MediaSliderViewMovieCell: \(medium.name)")
                self.next()
            }
            return cell
        } else {
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaSliderViewImageCell.identifier, for: indexPath) as? MediaSliderViewImageCell
            else {
                return UICollectionViewCell()
            }
            cell.configure(viewModel: MediaSliderCellViewModel(index: indexPath.row, medium: medium))
            cell.didFinishPlaying = {
                print("didFinishPlaying in MediaSliderViewImageCell: \(medium.name)")
                self.next()
            }
            return cell
        }
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        play()
    }
}
