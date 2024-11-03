//
//  VideoEditorViewController.swift
//  AVFoundationPlayground
//
//  Created by Waheed Abbas on 03/11/2024.
//

import UIKit
import AVFoundation
import PhotosUI

class VideoEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var loadVideoButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLoadVideoButton()
    }
    // Setup button to load video from the gallery
     func setupLoadVideoButton() {
         loadVideoButton = UIButton(type: .system)
         loadVideoButton?.setTitle("Select", for: .normal)
         loadVideoButton?.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
         loadVideoButton?.backgroundColor = .systemBlue
         loadVideoButton?.tintColor = .white
         loadVideoButton?.layer.cornerRadius = 10
         loadVideoButton?.translatesAutoresizingMaskIntoConstraints = false
         
         // Add target to call openGallery method
         loadVideoButton?.addTarget(self, action: #selector(openGallery), for: .touchUpInside)
         
         if let videoButton = self.loadVideoButton {
             view.addSubview(videoButton)
             
             // Set up constraints for the button
             NSLayoutConstraint.activate([
                videoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                videoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                videoButton.widthAnchor.constraint(equalToConstant: 200),
                videoButton.heightAnchor.constraint(equalToConstant: 50)
             ])
         }
     }
    
    // Open the photo library to select a video
    @objc func openGallery() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // UIImagePickerController Delegate: called after a media file is selected
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        
        // Retrieve the video URL
        if let videoURL = info[.mediaURL] as? URL {
            loadVideo(for: videoURL)
        }
    }
    
    // Load the video using AVFoundation
    private func loadVideo(for url: URL) {
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        
        // Set up the player and player layer
        player = AVPlayer(playerItem: playerItem)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = view.bounds
        playerLayer?.videoGravity = .resizeAspect
        view.layer.addSublayer(playerLayer!)
        
        // Start playback
        player?.play()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
