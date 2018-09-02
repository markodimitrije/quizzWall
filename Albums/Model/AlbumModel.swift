//
//  AlbumModel.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 01/09/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation

struct Albums: Codable {
    var albums: [Album]
}

struct Album: Codable {
    var aid: Int
    var name: String
    var sids: [Int] = []
    init(aid: Int, name: String, sids: [Int] = [ ]) {
        self.aid = aid
        self.name = name
        self.sids = sids
    }
}

struct Stickers: Codable {
    var stickers: [Sticker]
}

struct Sticker: Codable {
    var sid: Int
    var aid: Int
    var name: String = ""
    init(sid: Int, aid: Int, name: String?) {
        self.sid = sid
        self.aid = aid
        self.name = name ?? ""
    }
}

struct StickerInfos: Codable {
    var stickersInfo: [StickerInfo]
}

struct StickerInfo: Codable {
    var sid: Int
    var desc: String
}

enum AlbumData {
    case stickers, albums, stickersInfo
}
