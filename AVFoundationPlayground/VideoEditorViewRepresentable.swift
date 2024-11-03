//
//  VideoEditorViewRepresentable.swift
//  AVFoundationPlayground
//
//  Created by Waheed Abbas on 03/11/2024.
//
import SwiftUI

struct VideoEditorViewRepresentable : UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let videoEditor = VideoEditorViewController()
        return videoEditor
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
         
    }
}
