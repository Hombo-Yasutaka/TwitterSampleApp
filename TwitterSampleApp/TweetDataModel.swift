//
//  TweetDataModel.swift
//  TwitterSampleApp
//
//  Created by 本坊康孝 on 2024/11/18.
//

import Foundation
import RealmSwift

class TweetDataModel: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var content: String = ""
}
