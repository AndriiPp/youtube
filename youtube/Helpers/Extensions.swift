//
//  Extensions.swift
//  youtube
//
//  Created by Andrii Pyvovarov on 03.04.18.
//  Copyright © 2018 Andrii Pyvovarov. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintWithFormat(format : String, views : UIView...){
        var viewsDictionary = [String : UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
}
 
extension UIColor{
    static func rgb(red : CGFloat, green : CGFloat, blue : CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

let imageCashe = NSCache<AnyObject, AnyObject>()

class CustomImageView : UIImageView {
    var imageUrlString : String?
    func loadImageUsingUrlString(urlString : String){
        imageUrlString = urlString
        let url = NSURL(string: urlString)
        
          image = nil
        
        if let imageFromCashe = imageCashe.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCashe
            return
        }
        
        URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
            if error != nil {
                print(error)
            }
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                if self.imageUrlString == urlString  {
                    self.image = imageToCache
                }
                imageCashe.setObject(imageToCache!, forKey: urlString as AnyObject)
            }
            
        }).resume()
    }
}


