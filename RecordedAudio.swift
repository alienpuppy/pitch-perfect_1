//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Mary Elizabeth McManamon on 4/27/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation
class RecordedAudio {
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl :NSURL, title: String) {
        
        self.filePathUrl = filePathUrl
        self.title = title
    }
    
    //TO DO: init(filePathUrl :NSURL, title: NSString) {
    //
   // }
}

