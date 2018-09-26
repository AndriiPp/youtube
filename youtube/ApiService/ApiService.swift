//
//  ApiService.swift
//  youtube
//
//  Created by Andrii Pyvovarov on 30.05.18.
//  Copyright © 2018 Andrii Pyvovarov. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    static let sharedInstance = ApiService()
    
    func fetchVideos(completion : @escaping ([Video ]) -> ()){
        let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                var videos = [Video]()
                for dictionary in json as! [[String : AnyObject]]{
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    //                    self.videos?.append(video)
                    
                    let channelDictionary = dictionary["channel"] as! [String : AnyObject]
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    video.channel = channel
                    
                    videos.append(video)
                }
                DispatchQueue.main.async {
//                     self.collectionView?.reloadData()
                  completion(videos)
                }
            }catch let jsonError{
                print(jsonError)
            }
            
            //            let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            //            print(str)
            }.resume()
    }
}
