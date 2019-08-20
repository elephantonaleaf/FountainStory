//
//  TopicCardCell.swift
//  FountainStory
//
//  Created by Harrison Kim on 2019/4/24.
//  Copyright © 2019 Harrison Kim. All rights reserved.
//

import UIKit

class TopicCardCell: UICollectionViewCell {
    
    @IBOutlet weak var topicImageViewContainer: UIView!
    
    @IBOutlet weak var topicImageView: UIImageView!
    
    @IBOutlet weak var topicCardLabel: UILabel!
    
    var topic:Topic? = nil {
        
        didSet {
            
            if topic != nil {
                
                // Set the topic label
                topicCardLabel.text = topic!.topicName
                
                // Set the image when the topic property is set
                topicImageView.image = UIImage(named: topic!.cardImage)
                
                // Round the corners of the image view
                topicImageView.layer.cornerRadius = 8
                
                // Set the drop shadow                
                topicImageViewContainer.layer.shadowColor = UIColor.black.cgColor
                topicImageViewContainer.layer.shadowOffset = CGSize(width: 2, height: 2)
                topicImageViewContainer.layer.shadowOpacity = 1
                topicImageViewContainer.layer.shadowRadius = 0.1
                topicImageViewContainer.layer.shadowPath = UIBezierPath(roundedRect: topicImageViewContainer.bounds, cornerRadius: 8).cgPath
                topicImageViewContainer.layer.masksToBounds = false
                topicImageViewContainer.clipsToBounds = false
                
            }
            
        } //End didSet
    }
    
//    func showTopic(_ t:Topic) {
//
//        topicCardLabel.text = t.topicName
//
//
//    }
    
}
