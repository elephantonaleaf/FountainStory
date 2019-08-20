//
//  CategoryCell.swift
//  FountainStory
//
//  Created by Harrison Kim on 2019/4/24.
//  Copyright © 2019 Harrison Kim. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var topicCollectionView: UICollectionView!
    
    var topics = [Topic]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Configure collection view
        topicCollectionView.dataSource = self
        topicCollectionView.delegate = self
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func showTopics(_ t:[Topic]) {
        
        // set topics property with passed in topics
        topics = t
        
        // reload data
        topicCollectionView.reloadData()
    }
    
    
}

extension CategoryCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return topics.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopicCardCell", for: indexPath) as! TopicCardCell
        
        // Get the topic in question
        let t = topics[indexPath.row]
        
        // Set the topic to the collectionview cell
        cell.topic = t
        
//        cell.setTopic(t)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! TopicCardCell
        
        // Show the card
//        cell.showAudioPlayer()
    }
    
}
