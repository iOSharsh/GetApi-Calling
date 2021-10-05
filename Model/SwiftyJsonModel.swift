//
//  SwiftyJsonModel.swift
//  JsonDemoUsingSwiftyJson
//
//  Created by mac on 29/01/21.
//

import Foundation
import SwiftyJSON

struct Feed {
    var feed:[String:Any]?
    var result:[Result]?
    init() {
            }
    init(json:JSON)
    {
        feed = json["feed"].dictionary
        
        
        if let resultt = json["results"].array
        {
            self.result = resultt.compactMap({ (JsonResultObj) -> Result? in
                return Result.init(json:JSON(JsonResultObj))
            })
        }

      
}
}

struct Result
{
    var artistName,artistId,name,id,artistProfile:String?
    
    init() {
        }
    init(json:JSON)
    {
        artistName = json["artistName"].stringValue
        artistId = json["artistId"].stringValue
        name = json["name"].stringValue
        id = json["id"].stringValue
        artistProfile = json["artworkUrl100"].stringValue
    }

}
