//
//  RecorderViewController.swift
//  FountainStory
//
//  Created by Harrison Kim on 2019/4/10.
//  Copyright © 2019 Harrison Kim. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth


class RecorderViewController: UIViewController, AVAudioRecorderDelegate {
    var recordingSession:AVAudioSession!
    var audioRecorder:AVAudioRecorder!
    var audioPlayer:AVAudioPlayer!
        
    var numberOfRecords:Int = 0
        

    
    @IBOutlet var recordButton: UIButton!
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func getAudiFileURL() -> URL {
        return getDocumentsDirectory().appendingPathComponent(".m4a")
    }
    
    @IBAction func recordTapped(_ sender: UIButton) {
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.low.rawValue
        ]
        
        do {
            let audioFileUrl = getAudiFileURL()
            audioRecorder = try AVAudioRecorder(url: audioFileUrl, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
//            blackView.isHidden = false
        } catch {
            print("failed to upload")
        }
        
    }
    
//    @IBAction func playTapped(_ sender: UIButton) {
//        if let audioUrl = message?.audioUrl, let url = URL(string: audioUrl) {
//            do {
//                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord)
//                audioPlayer = try AVAudioPlayer(contentsOf: url)
//                audioPlayer?.delegate = self
//                audioPlayer?.prepareToPlay()
//                audioPlayer?.play()
//
//                print("Audio ready to play")
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    //Here is where I try to upload the audio file to Firebase storage, and it does print out the correct downloadURL.
//    func handleAudioSendWith(url: String) {
//        guard let fileUrl = URL(string: url) else {
//            return
//        }
//        let fileName = NSUUID().uuidString + ".m4a"
//
//        Storage.storage().reference().child("recordings").child(fileName).putFile(fileUrl, metadata: nil) { (metadata, error) in
//            if error != nil {
//                print(error ?? "error")
//            }
//
//            if let downloadUrl = metadata?.downloadURL()?.absoluteString {
//                print(downloadUrl)
//                let values: [String : Any] = ["audioUrl": downloadUrl]
//                self.sendMessageWith(properties: values)
//            }
//        }
//    }
    
    @IBAction func pauseTapped(_ sender: UIButton) {
    }
    @IBAction func stopTapped(_ sender: UIButton) {
    }
    @IBAction func deleteTapped(_ sender: UIButton) {
    }
    @IBAction func subtmitTapped(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            
    }
        
}




//    var button = dropDownBtn()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//
//
//        //Configure the button
//        button = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        button.setTitle("Colors", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//
//        //Add Button to the View Controller
//        self.view.addSubview(button)
//
//        //button Constraints
//        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
//
//        //Set the drop down menu's options
//        button.dropView.dropDownOptions = ["Blue", "Green", "Magenta", "White", "Black", "Pink"]
//
//    }
//
//}
//
//protocol dropDownProtocol {
//    func dropDownPressed(string : String)
//}
//
//class dropDownBtn: UIButton, dropDownProtocol {
//
//    func dropDownPressed(string: String) {
//        self.setTitle(string, for: .normal)
//        self.dismissDropDown()
//    }
//
//    var dropView = dropDownView()
//
//    var height = NSLayoutConstraint()
//
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        self.backgroundColor = UIColor.darkGray
//
//        dropView = dropDownView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
//        dropView.delegate = self
//        dropView.translatesAutoresizingMaskIntoConstraints = false
//    }
//
//    override func didMoveToSuperview() {
//        self.superview?.addSubview(dropView)
//        self.superview?.bringSubviewToFront(dropView)
//        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
//        height = dropView.heightAnchor.constraint(equalToConstant: 0)
//    }
//
//    var isOpen = false
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if isOpen == false {
//
//            isOpen = true
//
//            NSLayoutConstraint.deactivate([self.height])
//
//            if self.dropView.tableView.contentSize.height > 150 {
//                self.height.constant = 150
//            } else {
//                self.height.constant = self.dropView.tableView.contentSize.height
//            }
//
//
//            NSLayoutConstraint.activate([self.height])
//
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
//                self.dropView.layoutIfNeeded()
//                self.dropView.center.y += self.dropView.frame.height / 2
//            }, completion: nil)
//
//        } else {
//            isOpen = false
//
//            NSLayoutConstraint.deactivate([self.height])
//            self.height.constant = 0
//            NSLayoutConstraint.activate([self.height])
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
//                self.dropView.center.y -= self.dropView.frame.height / 2
//                self.dropView.layoutIfNeeded()
//            }, completion: nil)
//
//        }
//    }
//
//    func dismissDropDown() {
//        isOpen = false
//        NSLayoutConstraint.deactivate([self.height])
//        self.height.constant = 0
//        NSLayoutConstraint.activate([self.height])
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
//            self.dropView.center.y -= self.dropView.frame.height / 2
//            self.dropView.layoutIfNeeded()
//        }, completion: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//class dropDownView: UIView, UITableViewDelegate, UITableViewDataSource  {
//
//    var dropDownOptions = [String]()
//
//    var tableView = UITableView()
//
//    var delegate : dropDownProtocol!
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        tableView.backgroundColor = UIColor.darkGray
//        self.backgroundColor = UIColor.darkGray
//
//
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//
//        self.addSubview(tableView)
//
//        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dropDownOptions.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//
//        cell.textLabel?.text = dropDownOptions[indexPath.row]
//        cell.backgroundColor = UIColor.darkGray
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.delegate.dropDownPressed(string: dropDownOptions[indexPath.row])
//        self.tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//}


