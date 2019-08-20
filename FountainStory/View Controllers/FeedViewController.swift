//
//  FeedViewController.swift
//  FountainStory
//
//  Created by Harrison Kim on 2019/4/10.
//  Copyright © 2019 Harrison Kim. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    
    @IBOutlet weak var categoryTableView: UITableView!
    
    let sections = ["Trending Topics", "Most Popular", "Childhood"]
    
    var topicDictionary = [String:[Topic]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Some dummy topics for show
//        let trending = [Topic(topicName: "What do you remember?", cardImage: "card-background"),
//        Topic(topicName: "What do you remember?", cardImage: "card-background"),
//        Topic(topicName: "What do you remember?", cardImage: "card-background")]
//
//        topicDictionary[sections[0]] = trending
//
//
//        let popular = [Topic(topicName: "What do you remember?", cardImage: "card-background"),
//                        Topic(topicName: "What do you remember?", cardImage: "card-background"),
//                        Topic(topicName: "What do you remember?", cardImage: "card-background")]
//
//        topicDictionary[sections[1]] = popular
//
//        let childhood = [Topic(topicName: "What do you remember?", cardImage: "card-background"),
//                       Topic(topicName: "What do you remember?", cardImage: "card-background"),
//                       Topic(topicName: "What do you remember?", cardImage: "card-background")]
//
//        topicDictionary[sections[2]] = childhood
        
        // Configure the table view
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
            let vc = storyboard?.instantiateViewController(withIdentifier: "ListenDetail") as! ListenDetailViewController
        
            vc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        
            vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
            present(vc, animated: true, completion: nil)
        
        
    }
    
    

}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = sections[section]
        // TODO: need to change font to proper font in future
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        label.textColor = UIColor.white
        
        // Header View
        let headerView = UIView()
        headerView.addSubview(label)
        
        // Add positioning constraints
        let leftConstraint = NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: headerView, attribute: .left, multiplier: 1, constant: 20)
        
        let yCenterContraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: headerView, attribute: .centerY, multiplier: 1, constant: 0)
        
        headerView.addConstraints([leftConstraint, yCenterContraint])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 67
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return sections.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        // Get the topics for the section requested
        let sectionName = sections[indexPath.section]
        
        let topics = topicDictionary[sectionName]
        
        if topics != nil {
            // Set the topic for the cell
            cell.showTopics(topics!)
        }
        
        
        
        return cell
    }
    
    
    
    
    
}
