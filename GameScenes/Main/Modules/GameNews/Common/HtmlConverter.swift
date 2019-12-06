//
//  HtmlConverter.swift
//  GameScenes
//
//  Created by Михаил Игонин on 06.12.2019.
//  Copyright © 2019 FrozenApps. All rights reserved.
//

import Foundation
import UIKit

public class HtmlConverter: HtmlConverting {
    let screenWidth: Int

    public init(screenWidth: CGFloat) {
        self.screenWidth = Int(screenWidth)
    }

    public func convert(htmlString string: String) -> NSAttributedString? {
        var string = string

        if stringContainsBBCode(string) {
            string = convertBBCodeToHtml(string)
        }

        let fontFixedText = "<head><style type=\"text/css\">img { width: \(screenWidth - 30)px; }</style></head><body><span style=\"font-family: Helvetica; font-size: 16; color: gray\">\(string)</span></body>"

        if let htmlData = fontFixedText.data(using: .utf8),
            let attributedString = try? NSAttributedString(
                data: htmlData,
                options: [.documentType: NSAttributedString.DocumentType.html,],
                documentAttributes: nil
            ) {
                return attributedString
        } else {
            return nil
        }
    }

    private func convertBBCodeToHtml(_ string: String) -> String {
        var retString = string

        retString = string.replacingOccurrences(of: "{STEAM_CLAN_LOC_IMAGE}", with: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/clans/")
        retString = retString.replacingOccurrences(of: "{STEAM_CLAN_IMAGE}", with: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/clans/")

        retString = retString.replacingOccurrences(of: "[img]", with: "<img src=\"")
        retString = retString.replacingOccurrences(of: "[/img]", with: "\"/>")

//        retString = retString.replacingOccurrences(of: "[", with: "<")
//        retString = retString.replacingOccurrences(of: "]", with: ">")
//
//        retString = retString.replacingOccurrences(of: "[h1]", with: "<h1>")
//        retString = retString.replacingOccurrences(of: "[/h1]", with: "</h1>")

        return retString
    }

    private func stringContainsBBCode(_ string: String) -> Bool {
        return string.contains("[img]") || string.contains("[b]")
    }
}
