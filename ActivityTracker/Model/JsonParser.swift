//
//  JsonParser.swift
//  ActivityTracker
//
//  Created by Nikolay on 11/02/2019.
//  Copyright © 2019 Nikolay Rybin. All rights reserved.
//

import Foundation

class JsonParser <T: Decodable> {
    
    private var inpputJson : Data  //variale for input data
    private var outputType : T.Type // type of structure to parse data
    private (set) var output: T? = nil //variale for output data
    
    init(inpputJson: Data, outputType: T.Type) {
        self.inpputJson = inpputJson
        self.outputType = outputType
        self.output = decodeJson()
    }
    
    private func decodeJson () -> T?{
        let decoder = JSONDecoder()
        let mydata = try? decoder.decode(T.self, from: inpputJson)
        return mydata
    }
}
