//
//  Result.swift
//  19_Project14_BucketList
//
//  Created by Jacob Zhang on 2020/5/6.
//  Copyright © 2020 Jacob Zhang. All rights reserved.
//

import Foundation

struct Result: Codable {
    let pois: [Poi]
}

struct Poi: Codable,Identifiable {
    let id: String
    let name: String
    let address: String
    private var tel: TelEnum
    public var _tel: String {
      switch tel {
       case .string(let value):
        return value
      case .array( _):
        return "未知"
      }
    }
    let photos: [Photo]
    let distance: String
    
}

struct Photo: Codable {
    let url: String
}


enum TelEnum: Codable {
    case string(String)
    case array(Array<String>)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(Array<String>.self) {
            self = .array(x)
            return
        }
        throw DecodingError.typeMismatch(TelEnum.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for MyValue"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .array(let x):
            try container.encode(x)
        }
    }
}

//Struct poi {
// private var _tel: TelEnum
// public var tel {
//  switch _tel {
//   case .string(let value):
//    return value
//   case .array(let arr):
//    return “未知”
//  }
// }
//}
//
//Enum TelEnum {
// case string(String)
// case array([String])
//}



