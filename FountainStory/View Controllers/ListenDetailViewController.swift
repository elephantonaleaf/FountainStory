//
//  ListenDetailViewController.swift
//  FountainStory
//
//  Created by Harrison Kim on 2019/4/24.
//  Copyright © 2019 Harrison Kim. All rights reserved.
//

import UIKit

class ListenDetailViewController: UIViewController {

    var topic:Topic?
    
    @IBOutlet weak var modalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.layer.cornerRadius = 8
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        
//        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func playTapped(_ sender: UIButton) {
    }
    
    @IBAction func pauseTapped(_ sender: UIButton) {
    }
    
    @IBAction func subscribeTapped(_ sender: UIButton) {
    }
    
    @IBAction func likeTapped(_ sender: UIButton) {
    }
    
    
}
