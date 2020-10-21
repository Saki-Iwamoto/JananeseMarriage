//
//  Japanese.swift
//  JananeseMarriage
//
//  Created by saki iwamoto on 2020/10/21.
//

import Foundation

/// 日本人
class Japanese {
    /// 名
    let firstName: String
    /// 姓
    var familyName: String
    /// 生年月日
    let birthdate: DateComponents
    
    init(firstName given: String, familyName last: String, birthday: DateComponents) {
        firstName = given
        familyName = last
        birthdate = birthday
    }
    
    /// 年齢
    var age: Int {
        // 生年月日から算出
        let calendar = Calendar.current
        let now = calendar.dateComponents([.year, .month, .day], from: Date())
        let ageComponents = calendar.dateComponents([.year], from: birthdate, to: now)
        return ageComponents.year!
    }
    /// 性別
    var gender = Gender.Notknown
    /// 旧姓
    var maidenName: String?
    
    /// フルネームを返します
    ///
    /// - Parameter previous: 旧姓を返したい場合はtrue
    /// - Returns: 旧姓がない場合エラー返します
    func fullName(previous: Bool = false) throws -> String{
        if previous {
            guard let name = maidenName else { throw MarriageError.UnchangeName}
            return (name + " " + firstName)
        }
        return(familyName + " " + firstName)
    }
}
