//
//  MarriageError.swift
//  JananeseMarriage
//
//  Created by saki iwamoto on 2020/10/21.
//

import Foundation

/// 結婚にまつわるエラー
internal enum MarriageError: Error {
    /// 未婚
    case Unmarried
    /// 旧姓がない
    case UnPreviousName
    /// 法定年齢に満たない
    case Underage
    /// 既婚、重婚
    case bigamy
    /// 性別不明
    case UnknownGender
    /// 夫婦別姓
    case UnchangeName
    /// 夫婦ともに苗字の変更はできない
    case doubleChangeName
    /// 同性結婚
    case sameSexMarriage
}

/// MarriageErrorの解説
extension MarriageError:LocalizedError{
    var errorDescription:String?{
        switch self {
        case .Unmarried:
            return "結婚してへんやろ"
        case .UnPreviousName:
            return "あんたは苗字変えてへんやろ"
        case .Underage:
            return "今の日本の制度では、結婚するには若すぎるらしいわ。ついでに男女で年齢差あるん意味わからんよね"
        case .bigamy:
            return "重婚はあかん"
        case .UnknownGender:
            return "今の日本の制度では男か女でやないとあかんらしいわ"
        case .UnchangeName:
            return "今の日本の制度では夫婦別姓はあかんらしいわ"
        case .doubleChangeName:
            return "夫の氏か、妻の氏のどちらか選んでな"
        case .sameSexMarriage:
            return "今の日本の制度では同性で結婚させてくれへんらしいわ"
        }
    }
}
