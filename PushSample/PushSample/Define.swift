//
//  Define.swift
//  Smartic2
//
//  Created by JinGu on 2016. 7. 14..
//  Copyright © 2016년 JinGu. All rights reserved.
//

import UIKit


let appDel = (UIApplication.shared.delegate as! AppDelegate)
let userD = UserDefaults.standard


struct SCREEN {
    static let BOUND = UIScreen.main.bounds
    static let WIDTH = UIScreen.main.bounds.size.width
    static let HEIGHT = UIScreen.main.bounds.size.height
    struct MID {
        static let X = SCREEN.WIDTH / 2
        static let Y = SCREEN.HEIGHT / 2
    }
}

let STATUS_BAR_HEIGHT     : CGFloat = { return UIApplication.shared.statusBarFrame.size.height }()
let NAVIGATION_BAR_HEIGHT : CGFloat = { return UINavigationController().navigationBar.frame.size.height }()
let TABBAR_HEIGHT         : CGFloat = 49

let MY_IPHONE = SCREEN.HEIGHT
let IPHONE_SE : CGFloat     = 568 // 320 x 568
let IPHONE_N : CGFloat      = 667 // 375 x 667
let IPHONE_N_PLUS : CGFloat = 736 // 414 x 736
let IPHONE_X : CGFloat      = 812 // 375 x 812

let IS_IPHONE_SE     = (MY_IPHONE == IPHONE_SE)
let IS_IPHONE_N      = (MY_IPHONE == IPHONE_N)
let IS_IPHONE_N_PLUS = (MY_IPHONE == IPHONE_N_PLUS)
let IS_IPHONE_X      = (MY_IPHONE == IPHONE_X)


let IPHONE_X_SAFE_AREA : CGFloat = 44
let SAFE_AREA : CGFloat = {
    IS_IPHONE_X ? IPHONE_X_SAFE_AREA : 0
}()


let AppleSDGothicNeo                   = "Apple SD Gothic Neo"
let AppleSDGothicNeoBold               = "Apple SD Gothic Neo Bold"
let NanumGothicOTF                     = "NanumGothicOTF"
let NanumGothicOTFBold                 = "NanumGothicOTFBold"

let Arita_dotum_Bold_OTF               = "Arita-dotum-Bold_OTF"
let Arita_dotum_Light_OTF              = "Arita-dotum-Light_OTF"
let Arita_dotum_Medium_OTF             = "Arita-dotum-Medium_OTF"
let Arita_dotum_SemiBold_OTF           = "Arita-dotum-SemiBold_OTF"
let Arita_dotum_Thin_OTF               = "Arita-dotum-Thin_OTF"

let Nanum_Barun_Gothic_OTF             = "NanumBarunGothicOTF"
let Nanum_Barun_Gothic_OTF_Ultra_Light = "NanumBarunGothicOTFUltraLight"
let Nanum_Barun_Gothic_OTF_Light       = "NanumBarunGothicOTFLight"
let Nanum_Barun_Gothic_OTF_Bold        = "NanumBarunGothicOTFBold"

let ROBOTO_REGULAR                     = "Roboto-Regular"
let ROBOTO_BLACK                       = "Roboto-Black"
let ROBOTO_LIGHT                       = "Roboto-Light"
let ROBOTO_BOLD_ITALIC                 = "Roboto-BoldItalic"
let ROBOTO_LIGHT_ITALIC                = "Roboto-LightItalic"
let ROBOTO_THIN                        = "Roboto-Thin"
let ROBOTO_MEDUM_ITALIC                = "Roboto-MediumItalic"
let ROBOTO_MEDIUM                      = "Roboto-Medium"
let ROBOTO_BOLD                        = "Roboto-Bold"
let ROBOTO_BLACK_ITALIC                = "Roboto-BlackItalic"
let ROBOTO_ITALIC                      = "Roboto-Italic"
let ROBOTO_THIN_ITALIC                 = "Roboto-ThinItalic"

