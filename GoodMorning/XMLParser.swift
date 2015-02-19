//
//  XMLParser.swift
//  GoodMorning
//
//  Created by Ben Sweett on 2015-02-18.
//  Copyright (c) 2015 Ben Sweett. All rights reserved.
//

import Foundation

class XMLParser: NSObject {
   
    func checkValidRSSChannel(xml: AEXMLDocument, type: RSSType, url: String) -> RSSFeed? {
        
        var title = xml.root["channel"]["title"].stringValue
        var link = xml.root["channel"]["link"].stringValue
        var lastBuild = xml.root["channel"]["lastBuildDate"].stringValue
        var description = xml.root["channel"]["description"].stringValue
        var language = xml.root["channel"]["language"].stringValue
        
        var activeDate: NSDate!
        if(lastBuild.rangeOfString("not found") == nil) {
            activeDate = NSDate().dateFromInternetDateTimeString(lastBuild, formatHint: DateFormatHint.RFC822)
        } else {
            activeDate = NSDate()
        }
        
        var imageURL = xml.root["channel"]["image"]["url"].stringValue
        
        if title.rangeOfString("not found") != nil || link.rangeOfString("not found") != nil {
            return nil
        }
        
        if description.rangeOfString("not found") != nil {
            description = ""
        }
        
        if language.rangeOfString("not found") != nil {
            language = ""
        }
        
        var rss = RSSFeed(title: title, creation: NSDate(), lastActiveDate: activeDate, type: type, description: description, language: language, link: link, rssLink: url)
        
        if imageURL.rangeOfString("not found") != nil {
            rss.setLogoUrl("")
        } else {
            rss.setLogoUrl(imageURL)
        }
        
        return rss
    }
}
