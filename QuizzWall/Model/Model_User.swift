//
//  Model_User.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 31/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation

// vazno je da User-a init-ujes samo jednom, da mu posle ne bi ubio var questions
struct User: Codable {
    
    var sids: [Int: Bool] // ovo su slicice u albumu
    var questions: [Int: Bool] // da li je odgovarao na pitanje ili nije
    
    var sidsEarned = [Int]()
    var sidsNew = [Int]()
    
    var hammer: Int // points
    var gems: Int // points
    var points: Int // points
    var level: Int // racunska....
    
    var questionsNew = Set<Int>() // ovde su inicijalno svi
    var questionsSeen = Set<Int>() // ovaj ces puniti oduzimajuci iz prethodnog...
    
    init?() { // ako ga init-ujes bez params, setuj mu sva questions na false
        // zovi fajl iz filesys, prodji kroz sve questions, i za svaki id pridruzi mu False
        
        let phoneLanguage = PhoneLanguage().getPrefferedLanguage() ?? Language.en.rawValue
        
        guard let fileName = language_LocalFilenameQuestions_Info[phoneLanguage],
            let data = FileManagerPersister().readData(fromFilename: fileName),
            let questionStructure = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any],
            let dict = questionStructure else {return nil}
        
        let keys = Array(dict.keys)
        print("keys = \(keys)")
//        questions = keys.map({ (key) -> [Int: Bool] in
//            return Int(key)! : false
//        })
        sids = [Int: Bool]() // hard-coded
        questions = [Int: Bool]() // hard-coded
        hammer = 100
        gems = 6
        points = 0
        level = 1
    }
    
}

struct Albums: Codable {
    var dict: [String: [Album]]
}

struct Album: Codable {
    var aid: Int
    var name: String
}

struct Stickers: Codable {
    var dict: [String: [Sticker]]
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
    var dict: [String: [StickerInfo]]
}

struct StickerInfo: Codable {
    var sid: Int
    var desc: String
}

struct Game {
    static var cost_50_50 = 1
    static var costDoubleChoise = 1
    static var timeToPrepare: TimeInterval = 2
    static var timeToAnswer: TimeInterval = 15
    static var earnForAdMobMust = 2
    static var earnForAdMobAsked = 3
}

enum QuestionLelel {
    case easy, medium, hard
}

enum AlbumData {
    case stickers, albums, stickersInfo
}

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
        guard let data = getDataFromBundle(for: .albums) else {return nil}
        guard let result = try? decoder.decode(Albums.self, from: data) else {return nil}
        guard let albums = result.dict["albums"] else {return nil}
        return albums
    }
    
    private func getStickers() -> [Sticker]? {
        guard let data = getDataFromBundle(for: .stickers) else {return nil}
        guard let result = try? decoder.decode(Stickers.self, from: data) else {return nil}
        guard let stickers = result.dict["stickers"] else {return nil}
        return stickers
    }
    
    private func getStickersInfo() -> [StickerInfo]? {
        guard let data = getDataFromBundle(for: .stickersInfo) else {return nil}
        guard let result = try? decoder.decode(StickerInfos.self, from: data) else {return nil}
        guard let infos = result.dict["stickersInfo"] else {return nil}
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
