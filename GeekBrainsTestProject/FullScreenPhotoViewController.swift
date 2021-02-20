//
//  FullScreenPhotoViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 20.02.2021.
//

import UIKit

class FullScreenPhotoViewController: UIViewController {
    
    var imageView: UIImageView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let image = imageView {
            image.frame = UIScreen.main.bounds
            image.backgroundColor = .black
            image.contentMode = .scaleAspectFill
            image.isUserInteractionEnabled = true
            self.view.addSubview(image)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
