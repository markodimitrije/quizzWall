//
//  CT_Model.swift
//  StickersApp
//
//  Created by Marko Dimitrijevic on 01/03/2018.
//  Copyright © 2018 Dragan Krtalic. All rights reserved.
//

import Foundation

struct Totem: Codable {
    var sid: Int!
    var name: String = ""
    var o: Int = 0
    var t: Int = 0
    var claimed = false
    var sort: Int = 0
}

struct CrackTotemStructure: Codable {
    var tmplId: Int
    var version: Int
    var numOfStk: Int
    var userId: String
    var created: Date
    var updated: Date
    var val: [Int]
    
    var stickers: [CrackTotemSticker]
}

struct Cell: Codable {
    var cId: Int
    var w: Int
    var o: Int
    var p: Int
    var b: Int
    var t: Int
    var txt: String
}

struct Row: Codable {
    var rowId: Int
    var numOfElements: Int
    var cells: [Cell]
    var cells_sort: [Cell] {
        return cells.sorted {$0.cId < $1.cId}
    }
}

struct CrackTotemSticker: Codable {
    var sort: Int
    var sid: Int
    var numOfRows: Int
    var ver: Int
    var name: String
    var rows: [Row]
    var count4Cripto: Int
    var claimed: Bool
    var rows_sort: [Row] {
        return rows.sorted {$0.rowId < $1.rowId}
    }
    
    mutating func updateCell(withCellId cellId: Int?, newTaps: Int?) -> Cell? {
        
//        print("cellId = \(String(describing: cellId))")
        
        guard let cid = cellId, let newTaps = newTaps else {
//            print("updateCell.err.line. guard let cid = cellId, let newTaps = newTaps ")
            return nil
        }
        
        // nadji row koji sadrzi tvoj cell (1), a onda u njemu cellId koji trazis (2)
        
        let selectedRowIndex = rows.filter { (r) -> Bool in
            
            let cellIds = r.cells.map { $0.cId } // (1)
            
            return cellIds.contains(cid) // (2)
        }
        
        guard let rowInd = selectedRowIndex.first?.rowId else {
//            print("updateCell.err. line. let rowInd = selectedRowIndex.first?.rowId ")
            return nil
        }
        
        let cellIds = rows[rowInd].cells.map {$0.cId} // nadji selectedCell
        
        guard let index = cellIds.index(of: cid) else {
//            print("updateCell.err. line. let index = cellIds.index(of: \(cid) ")
            return nil
        }
        
        // update-uj nove otkucaje, ali tako da ne premase MAX, a to je .p:
        
        let toAcomplish = rows[rowInd].cells[index].p - rows[rowInd].cells[index].o
        
        rows[rowInd].cells[index].o += min(toAcomplish, newTaps)
        
        return rows[rowInd].cells[index]
        
    }
    
    // prodji kroz sve cells i vrati koliko uk. ima otkucanih taps:
    
    func getTotal_O() -> Int {
        
        var taps = 0
        
        for r in rows {
            for c in r.cells {
                taps += c.o
            }
        }
        
        return taps
        
    }
    
    func getTotal_P() -> Int {
        
        var taps = 0
        
        for r in rows {
            for c in r.cells {
                taps += c.p
            }
        }
        
        return taps
        
    }
    
    func getScore() -> Int {
        return getTotal_P() - getTotal_O()
    }
    
    func get_O(rowId: Int, cellId: Int) -> Int? {
        
        guard let row = (self.rows.filter {$0.rowId == rowId }).first else { return nil }
        
        guard let cell = (row.cells.filter {$0.cId == cellId }).first else { return nil }
        
        return cell.o
    }
    
    
    
    
    var jsonRepresentation: [String: Any]? {
        
        var data: Data?
        do {
            data = try JSONEncoder().encode(self)
        } catch {
            print("jsonRepresentation.catch: Encoding is failed")
        }
        
        guard let encodedData = data else { return nil } // prosao si ENCODER
        
        var jsonDict: [String: Any]?
        do {
            jsonDict = try JSONSerialization.jsonObject(with: encodedData, options: .mutableContainers) as? [String: Any]
        } catch {
            print("jsonRepresentation.catch: JSONSerialization is failed")
        }
        
        return jsonDict
    }
    
    func getRowsForWebReporting() -> [[String: Any]] { // depricated ??? - mislim da
        
        guard let ctModelAsJson = self.jsonRepresentation else { return [] }
//        print("CT_Model.getRowsForWebReporting.ctModelAsJson = \(ctModelAsJson)")
        return []
        
    }
    
}

enum BW_BrickPattern {
    case b
    case t
    case i
}

