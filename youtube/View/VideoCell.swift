//
//  VideoCell.swift

//  Copyright © 2018 Andrii Pyvovarov. All rights reserved.
//

import UIKit
class BaseCell : UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
     func setupViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell : BaseCell {
    var video : Video? {
        didSet {
            tittleLabel.text = video?.title
            setupthumbnailImage()
            setupProfileImage()
//            if let profileImageName = video?.channel?.profileImageName {
//                userprofileImageView.image = UIImage(named: profileImageName)
//            }
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let subtitleText = "\(channelName) - \(numberFormatter.string(from: numberOfViews)!) - 2 years ago"
                subTittleTextView.text = subtitleText
            }
            if let title = video?.title {
                let size = CGSize(width: frame.width - 44 - 16 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.height > 20{
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
//            subTittleTextView.text = video?.channel?.name
//            userprofileImageView.image = UIImage(named: (video?.channel?.profileImageName)!)
        }
    }
    func setupProfileImage(){
        if let profileImageUrl = video?.channel?.profileImageName{
            //            print(thumbnailImageUrl)
            userprofileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }
    func setupthumbnailImage(){
        if let thumbnailImageUrl = video?.thumbnailImageName{
//            print(thumbnailImageUrl)
            
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
            
            let url = NSURL(string: thumbnailImageUrl)
            URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error)
                }
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = UIImage(data: data!)
                }
                
            }).resume()
        }
    }
    let thumbnailImageView : CustomImageView = {
        let imageView = CustomImageView()
        //        imageView.backgroundColor = .blue
        imageView.image = UIImage(named: "creed")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    let userprofileImageView : CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "image1")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let tittleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //        label.backgroundColor = .purple
        label.text = "Yegor Creed - tear"
        label.numberOfLines = 2
        return label
    }()
    let subTittleTextView : UITextView = {
        let textView = UITextView()
        //        textView.backgroundColor = .red
        textView.text = "BlackStar - 78,532.387 views - 4 months ago"
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    var titleLabelHeightConstraint : NSLayoutConstraint?
  override  func setupViews(){
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userprofileImageView)
        addSubview(tittleLabel)
        addSubview(subTittleTextView)
        
        addConstraintWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintWithFormat(format: "H:|-16-[v0(44)]", views: userprofileImageView)
        //vertical constraints
        addConstraintWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userprofileImageView, separatorView)
        addConstraintWithFormat(format: "H:|[v0]|", views: separatorView)
        
        addConstraint(NSLayoutConstraint(item: tittleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: tittleLabel, attribute: .left, relatedBy: .equal, toItem: userprofileImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: tittleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
    titleLabelHeightConstraint = NSLayoutConstraint(item: tittleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
    addConstraint(titleLabelHeightConstraint!)
        addConstraint(NSLayoutConstraint(item: subTittleTextView, attribute: .top, relatedBy: .equal, toItem: tittleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: subTittleTextView, attribute: .left, relatedBy: .equal, toItem: userprofileImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subTittleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subTittleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



