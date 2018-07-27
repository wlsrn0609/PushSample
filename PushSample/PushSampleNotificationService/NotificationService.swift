//
//  NotificationService.swift
//  PushSampleNotificationService
//
//  Created by m2comm on 2018. 7. 26..
//  Copyright © 2018년 wlsrn. All rights reserved.
//

import UserNotifications
import UIKit


//samplePayload
/*
{
    "aps" :
    {
        "alert" :
        {
            "title" : "타이틀",
            "subtitle" : "서브타이틀",
            "body" : "바디"
        },
        "mutable-content": 1
    },
    "imageURL": "https://i.ytimg.com/vi/7qkbRYM7YP8/maxresdefault.jpg"
}
 
 
 */

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
//        print(#function) //print를 찍으면 이 함수가 실행되지 않음 // 왜???
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
            if let imageUrlString = bestAttemptContent.userInfo["imageURL"] as? String {
                if let fileName = imageUrlString.components(separatedBy: "/").last {
                    if let imageURL = URL(string: imageUrlString) {
                        if let imageData = try? Data(contentsOf: imageURL) {
                            
                            let documentPathURL : URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
                            let fileURL : URL         = documentPathURL.appendingPathComponent(fileName)
                            try? imageData.write(to: fileURL)
                            
                            bestAttemptContent.body = fileURL.absoluteString
                            
                            let attachment = try! UNNotificationAttachment(identifier: "image", url: fileURL, options: nil)
                            bestAttemptContent.attachments = [attachment]
                            contentHandler(bestAttemptContent)
                            return
                        }
                    }
                }
            }
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
