//
//  ViewController.swift
//  APNGTest
//
//  Created by Erik Hede on 2019-04-01.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import UIKit
import APNGKit

class ViewController: UIViewController {
    
    var timer: Timer?
    
    var monitoring = Monitoring()
    
    var monitoringViewModel: MonitoringViewModel!

    var pickedImage: APNGImage?
    
    var urlString: String?
    
    @IBOutlet weak var apngAnimationView: APNGImageView!
    @IBOutlet weak var cpuUsageLabel: UILabel!
    @IBOutlet weak var memoryUsageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        monitoringViewModel = MonitoringViewModel(monitoring: monitoring)
        
        let apngImage: APNGImage?
        
        apngImage = APNGImage(named: "coin-animation")
        
        apngAnimationView.image = apngImage
        
        apngAnimationView.startAnimating()
        
        startTimer()
        
    
    }

    @IBAction func loadFromLibraryPressed(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil )
    }
    
    @IBAction func loadFromURLPressed(_ sender: Any) {
        let alert = UIAlertController(title: "URL", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textfield) in
            textfield.placeholder = "URL here:"
        }
        
        let done = UIAlertAction(title: "Done", style: .default) { (action) in
            if let text = alert.textFields?.first?.text {
                print(text)
                self.urlString = text

                if text.isValidURL {
                    if let url = URL(string: text) {
                        self.apngAnimationView.load(url: url)
                    }
                }
            }
            print("Done")
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Cancel")
        }
        alert.addAction(done)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("Timer fired!")
            self.monitoring.updateCpuUsage()
            self.monitoring.updateMemoryUsage()
        }
    }
    


    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? APNGImage
        self.pickedImage = image
        
        picker.dismiss(animated: true, completion: nil)
    }
}

