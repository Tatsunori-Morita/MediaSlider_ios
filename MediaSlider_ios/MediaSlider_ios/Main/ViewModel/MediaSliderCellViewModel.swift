//
//  MediaSliderCellViewModel.swift
//  AvplayerTestApp
//
//  Created by Tatsunori on 2023/03/29.
//

struct MediaSliderCellViewModel {
    private let _index: Int
    private let _medium: Medium

    init(index: Int, medium: Medium) {
        _index = index
        _medium = medium
    }

    public var index: Int {
        _index
    }

    public var fileName: String {
        return _medium.name
    }
}
