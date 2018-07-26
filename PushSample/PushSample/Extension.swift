
import UIKit

extension NSMutableAttributedString {
    
    /*
     //이미지 추가
     let attributedString = NSMutableAttributedString(string: "like after")
     let textAttachment = NSTextAttachment()
     textAttachment.image = #imageLiteral(resourceName: "btn_d_fav_on")
     let attrStringWithImage = NSAttributedString(attachment: textAttachment)
     attributedString.replaceCharacters(in: NSMakeRange(4, 1), with: attrStringWithImage)
     textView.attributedText = attributedString
     */
    
    
    
    
    /* sample
     
     [(String,[NSAttributedStringKey:NSObject])]
     
     NSAttributedStringKey.font
     NSAttributedStringKey.foregroundColor
     NSAttributedStringKey.kern // 자간?
     
     let stringInfos = [(String,[NSAttributedStringKey:NSObject])]()
     
     */
    
    convenience init(stringsInfos : [(String,[NSAttributedStringKey:NSObject])]) {
        
        var targetString = ""
        for i in 0..<stringsInfos.count {
            targetString = "\(targetString)\(stringsInfos[i].0)"
        }
        
        self.init(string: targetString)
        
        for i in 0..<stringsInfos.count {
            var startIndex = 0
            if (i) > 0 {
                for j in 0..<i {
                    startIndex += stringsInfos[j].0.count
                }
                
            }
            self.setAttributes(stringsInfos[i].1, range: NSMakeRange(startIndex, stringsInfos[i].0.count))
        }
    }
}

extension UIButton {
    
    //addTarget Clsure ========================================================================================================//
    struct AssociatedKeys {
        static var buttonAction: UInt8 = 0
    }
    
    var buttonAction : ((_ button : UIButton) -> Void)? {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.buttonAction) as? ((_ button : UIButton) -> Void)? else { return nil }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.buttonAction, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func addTarget ( event : UIControlEvents, buttonAction kButtonAction:@escaping (_ button : UIButton) -> Void) {
        self.buttonAction = kButtonAction
        self.addTarget(self, action: #selector(buttonPressed(button:)), for: event)
    }
    
    @objc private func buttonPressed(button : UIButton){
        self.buttonAction?(self)
    }
    //======================================================================================================== addTarget Clsure//
    
    
}


extension UIImageView {
    
    //이미지를 세팅함과 동시에 비율 맞춰 높이 늘리기
    func setImageWithFrameHeight( image kImage : UIImage?){
        if let image = kImage {
            self.image = image
            let frameHeight = self.frame.size.width * (image.size.height / image.size.width)
            self.frame.size.height = frameHeight
        }
    }
}


extension UIImage {
    //이미지가 돌아가는 문제 -> png->jpg로 해결
    func saveImageToDocuments(fileName : String) -> URL{
        
        // 사진 저장
        let documentPathURL : URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let fileName : String     = String(format: "%@.png", fileName)
        let fileURL : URL         = documentPathURL.appendingPathComponent(fileName)
        
        let pngData  : Data = UIImageJPEGRepresentation(self, 1)!
        
        try? pngData.write(to: fileURL, options: [.atomic])
        
        return fileURL
    }
    
    
    
    class func readImageFromeDocuments(fileName : String) -> UIImage{
        
        let documentPathURL : URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let fileName : String     = String(format: "%@.png", fileName)
        let fileURL : URL         = documentPathURL.appendingPathComponent(fileName)
        
        let imageData = try! Data(contentsOf: fileURL)
        
        return UIImage(data: imageData)!
    }
    
    convenience init(documentFileName fileName : String) {
        
        let documentPathURL : URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let fileName : String     = String(format: "%@.png", fileName)
        let fileURL : URL         = documentPathURL.appendingPathComponent(fileName)
        
        let imageData = try! Data(contentsOf: fileURL)
        
        self.init(data: imageData)!
    }
    
}

extension UIViewController : UIGestureRecognizerDelegate {
    
    //스와이프(swipe)로 뒤로가기
    
    //navigationController의 rootViewController에 등록
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
//    }
    
    //extention으로 둠
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension UIViewController : UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        //핵심
        let textFieldMaxY = self.view.convert(textField.frame, from: textField.superview!).maxY
        let keyBoardHeight : CGFloat = ((UIScreen.main.bounds.size.height == 812) ? 377 : 216) + 44
        let targetHeight = (UIScreen.main.bounds.size.height - textFieldMaxY) - keyBoardHeight - 10
        if targetHeight < 0 {
            UIView.animate(withDuration: 0.3, animations: {
                (UIApplication.shared.delegate as! AppDelegate).window?.frame.origin.y = targetHeight
            }) { (fi:Bool) in
                
            }
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            (UIApplication.shared.delegate as! AppDelegate).window?.frame.origin.y = 0
        }) { (fi:Bool) in
            
        }
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if !touch.view!.isKind(of: UITextField.self) {
                self.view.endEditing(true)
            }
        }
    }
    
    
}



extension UIColor {
    
    class func randomColor() -> UIColor {
        
        func randomInt(min : Int, max : Int) -> Int {
            return min + Int(arc4random_uniform(UInt32(max - min + 1)))
        }

        func random(min : CGFloat, max : CGFloat, underPoint : Int) -> CGFloat {
            let multiple = pow(10, CGFloat(underPoint))
            let rand = randomInt(min: Int(min * multiple), max: Int(max * multiple))
            return CGFloat(rand) / multiple
        }
        
        func randomValue() -> CGFloat {
            return random(min: 0, max: 1, underPoint: 2)
        }
        
        return UIColor(red: randomValue(), green: randomValue(), blue: randomValue(), alpha: 1)
    }
    
    
    
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    
}


extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "완료", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
        
    }
    
    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    //    @objc func cancelButtonTapped() { self.resignFirstResponder() }
}


extension String {
    
    func subString(start startIndex : Int , numberOf endIndex : Int ) -> String {
        let start  = self.index(self.startIndex, offsetBy: startIndex)
        let end  = self.index(start, offsetBy: endIndex)
        let subString = self[start..<end]
        return String(subString)
    }
    
    func subString(start startIndex : Int , end endIndex : Int ) -> String {
        let start  = self.index(self.startIndex, offsetBy: startIndex)
        let end  = self.index(self.startIndex, offsetBy: endIndex)
        let subString = self[start...end]
        return String(subString)
    }
    
    func subString(to endIndex : Int) -> String{
        let end  = self.index(self.startIndex, offsetBy: endIndex)
        let subString = self[self.startIndex...end]
        return String(subString)
    }
    
    func subString(from startIndex : Int) -> String{
        let start  = self.index(self.startIndex, offsetBy: startIndex)
        let subString = self[start..<self.endIndex]
        return String(subString)
    }
    
    func toCGFloat() -> CGFloat? {
        if let number = NumberFormatter().number(from: self) {
            return CGFloat(truncating: number)
        }
        return nil
        
    }
    
    func toInt() -> Int? {
        return Int(self, radix: 10)
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
   
    
    
}
