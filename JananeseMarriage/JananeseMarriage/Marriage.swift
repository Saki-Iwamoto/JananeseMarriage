//
//  Marriage.swift
//  JananeseMarriage
//
//  Created by saki iwamoto on 2020/10/21.
//

import Foundation

/// 結婚する人
class MarriagePartner: Japanese {
    
    /// 配偶者
    private (set) var partner: Japanese?
    
    /// 相手と結婚します
    ///
    /// - Parameters:
    ///   - spouse: 結婚相手
    ///   - changeName: 苗字変更をするか
    func marriage(spouse: Japanese, changeName: Bool) throws {
        // 既婚であればエラー
        guard partner == nil else { throw MarriageError.bigamy }
        
        // 性別・年齢チェック
        switch gender {
        case .Notknown, .NotApplicable:
            throw MarriageError.UnknownGender
        case .Male:
            if age < 18 {
                throw MarriageError.Underage
            }
        case .Female:
            if age < 16 {
                throw MarriageError.Underage
            }
        }
        if gender == spouse.gender {
            throw MarriageError.sameSexMarriage
        }
        
        // 苗字を変更します
        if changeName {
            maidenName = familyName
            familyName = spouse.familyName
        }
        
        partner = spouse
    }
}

/// 夫婦
/// important: 愛し合っている二人以外で生成しないでください
class Couple {
    let coupleOfMember: [(person:MarriagePartner, changeName: Bool)]
    
    init(member: [(MarriagePartner, changeName: Bool)]) {
        coupleOfMember = member
    }
    
    /// 結婚記念日
    private (set) var weddingAnniversary: Date?
    
    /// 結婚します
    func marriage() {
        do {
            if coupleOfMember.count != 2 {
                throw MarriageError.bigamy
            }
            
            // 名字変更チェック
            switch (coupleOfMember[0].changeName, coupleOfMember[1].changeName) {
            case (true, true):
                throw MarriageError.doubleChangeName
            case (false, false):
                throw MarriageError.UnchangeName
            default:
                break
            }
            
            // どっちが花嫁でも花婿でもいいので名義上定義する
            let groom: MarriagePartner = coupleOfMember[0].person
            let bride: MarriagePartner = coupleOfMember[1].person
            
            try groom.marriage(spouse: bride, changeName: false)
            try bride.marriage(spouse: groom, changeName: true)
            
            let groomName = try groom.fullName()
            let brideName = try bride.fullName(previous: true)
            
            weddingAnniversary = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: Locale(identifier: "ja_JP"))
            print(formatter.string(from: weddingAnniversary!) + "、\(groomName)と\(brideName)は入籍いたしました。")
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
