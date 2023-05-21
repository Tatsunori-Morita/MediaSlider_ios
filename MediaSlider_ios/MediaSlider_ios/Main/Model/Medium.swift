//
//  Media.swift
//  AvplayerTestApp
//
//  Created by Tatsunori on 2023/03/12.
//

import Foundation

struct Medium {
    private let _name: String
    private let _type: MediumType

    public enum MediumType {
        case movie
        case image
    }

    public var name: String {
        _name
    }

    public var type: MediumType {
        _type
    }

    init(name: String, type: MediumType) {
        _name = name
        _type = type
    }
}
