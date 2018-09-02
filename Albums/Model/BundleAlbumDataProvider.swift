//
//  AlbumDataProvider.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 01/09/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation

struct BundleAlbumDataProvider {
    
    private var decoder = JSONDecoder()
    
    // MARK:- API
    func getData(for request: AlbumData) -> [Codable]? {
        switch request {
        case .albums: return getAlbums()
        case .stickers: return getStickers()
        case .stickersInfo: return getStickersInfo()
        }
    }
    
    // MARK:- Privates from API
    
    private func getAlbums() -> [Album]? {
        guard let data = getDataFromBundle(for: .albums) else {
            return nil
        }
        guard let result = try? decoder.decode(Albums.self, from: data) else {
            return nil
        }
//        guard let albums = result.albums["albums"] else {
//            return nil
//        }
        //return albums
        return result.albums
    }
    
    private func getStickers() -> [Sticker]? {
        guard let data = getDataFromBundle(for: .stickers) else {return nil}
        guard let result = try? decoder.decode(Stickers.self, from: data) else {return nil}
        guard let stickers = result.stickers["stickers"] else {return nil}
        return stickers
    }
    
    private func getStickersInfo() -> [StickerInfo]? {
        guard let data = getDataFromBundle(for: .stickersInfo) else {return nil}
        guard let result = try? decoder.decode(StickerInfos.self, from: data) else {return nil}
        guard let infos = result.stickersInfo["stickersInfo"] else {return nil}
        return infos
    }
    
    // MARK:- Privates calculate...
    
    private func getDataFromBundle(for request: AlbumData) -> Data? {
        
        var filename: String?
        
        switch request {
        case .albums: filename = Constants.LocalFilenames.albums
        case .stickers: filename = Constants.LocalFilenames.stickers
        case .stickersInfo: filename = Constants.LocalFilenames.stickersInfo
        }
        
        guard let name = filename,
            let readUrl = Bundle.main.url(forResource: name, withExtension: "json") else {
                return nil
        }
        
        return try? Data.init(contentsOf: readUrl)
        
    }
    
    
}
