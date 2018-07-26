//
//  NotiCenter.swift
//  NotiCenterSample
//
//  Created by JinGu-MacBookPro on 14/06/2018.
//  Copyright © 2018 JinGu-MacBookPro. All rights reserved.
//

import UIKit
import UserNotifications

class NotiCenter: NSObject, UNUserNotificationCenterDelegate {
    
    static let shared : NotiCenter = {
        let sharedCenter = NotiCenter()
        return sharedCenter
    }()
    
    let notiCenter = UNUserNotificationCenter.current()
    
    func authorizationCheck() {
        notiCenter.requestAuthorization(options: [.alert,.sound,.badge]) { ( authorization: Bool, error : Error?) in
            if let error = error {
                print("requestAuthorization error : \(error)")
            }else{
                if !authorization {
                    print("권한부여를 해야한다는 안내")
                }else{
                    
                    self.notiCenter.delegate = self
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        }
    }
    
    func addAlram(time : Date, complete:@escaping (_ success : Bool) -> Void)  {
        
        let alramId = "sampleID"
        
        let content = UNMutableNotificationContent()
        content.title = "title"
        content.body = "body"
        content.sound = UNNotificationSound.default()

        
        //이미지를 추가하길 원한다면
        let imageURL = #imageLiteral(resourceName: "kakao").saveImageToDocuments(fileName: "kakao")
        let attachment = try! UNNotificationAttachment(identifier: "kakao", url: imageURL, options: nil)
        content.attachments = [attachment]
        
        //원하는 시간 컴포넌트 추가
//        var newTime = time
//        newTime = Calendar.current.date(bySetting: .hour, value: 0, of: newTime)!
//        newTime = Calendar.current.date(bySetting: .minute, value: 0, of: newTime)!
//        newTime = Calendar.current.date(bySetting: .second, value: 0, of: newTime)!

        //해당하는 Date 객체와 어떤거가 맞을때 알람이 울릴지 결정
        let triggerDate = Calendar.current.dateComponents([.hour,.minute,.second], from: time)
        
        //이번에는 시간으로 트리거를 정할 뿐 트리거는 여러 종류가 있다.
        //위치기반, 현재 시각 기반 등등
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate,repeats: true)
        
        //identifier를 이용해 알람을 구분
        let request = UNNotificationRequest(identifier: alramId, content: content, trigger: trigger)
        
        notiCenter.add(request) { (error : Error?) in
            if error == nil {
                complete(true)
            }else{
                complete(false)
            }
        }
        
    }
    
    func removeAlram(id : String){
        //알려진거, 안 알려진거 모두 제거
        self.notiCenter.removeDeliveredNotifications(withIdentifiers: [id])
        self.notiCenter.removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    func readAlram(identifiers : String ){
        var deliveredCheck = true
        self.notiCenter.getDeliveredNotifications { (notifications : [UNNotification]) in
            for notification in notifications {
                if notification.request.identifier == identifiers {
                    print("readAlram - Delivered : \(notification)")
                    deliveredCheck = false
                }
            }
            if deliveredCheck {
                print("readAlram - no deliveredNoti")
            }
            
        }
        
        var pendingCheck = true
        self.notiCenter.getPendingNotificationRequests { ( notificationRequests : [UNNotificationRequest]) in
            for notificationRequest in notificationRequests {
                if notificationRequest.identifier == identifiers {
                    print("readAlram - Pending : \(notificationRequest)")
                    pendingCheck = false
                }
            }
            if pendingCheck {
                print("readAlram - no pendingNoti")
            }
        }
        
    }
    
    func removeAllDeliveredAlram() {
        self.notiCenter.removeAllDeliveredNotifications()
    }
    
    func removeAllPendingAlram() {
        self.notiCenter.removeAllPendingNotificationRequests()
    }
    
    
}




//========================================================================//
//                   UNUserNotificationCenterDelegate                     //
//========================================================================//


func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
    
    
    //배너 호출
    completionHandler([.alert,.sound])//호출을 해야 실제로 알람 등이 울린다.
}


func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void){
    
    
    //호출된 배너를 눌렀을때
    
    completionHandler()
}




extension AppDelegate {

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString =  deviceToken.reduce("", { $0 + String(format: "%02x", $1)})
        print("deviceTokenString:\n\(deviceTokenString)")
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(#function)
        print("error : \(error.localizedDescription)")
    }
}
