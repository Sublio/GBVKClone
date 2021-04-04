//
//  PhotoCommentViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 03.04.2021.
//

import UIKit
import AlamofireImage

class PhotoCommentViewController: UIViewController {

     @IBOutlet weak var imageView: UIImageView!
     @IBOutlet weak var scrollView: UIScrollView!
     @IBOutlet weak var nameTextField: UITextField!

    var photo: UIImage?
    var photoIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let photo = self.photo {
          self.imageView.image = photo
        }
        let tapGestureRecongniser = UITapGestureRecognizer(target: self, action: #selector(openZoomController))
        self.imageView.addGestureRecognizer(tapGestureRecongniser)
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(keyboardWillShow(_:)),
          name: UIResponder.keyboardWillShowNotification,
          object: nil)

        NotificationCenter.default.addObserver(
          self,
          selector: #selector(keyboardWillHide(_:)),
          name: UIResponder.keyboardWillHideNotification,
          object: nil)
    }

    func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
      guard
        let userInfo = notification.userInfo,
        let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
          as? NSValue
        else {
          return
      }

      let adjustmentHeight = (keyboardFrame.cgRectValue.height + 20) * (show ? 1 : -1)
      scrollView.contentInset.bottom += adjustmentHeight
      scrollView.verticalScrollIndicatorInsets.bottom += adjustmentHeight
    }

    @objc func keyboardWillShow(_ notification: Notification) {
      adjustInsetForKeyboardShow(true, notification: notification)
    }
    @objc func keyboardWillHide(_ notification: Notification) {
      adjustInsetForKeyboardShow(false, notification: notification)
    }

    @IBAction func hideKeyboard(_ sender: AnyObject) {
      nameTextField.endEditing(true)
    }

    @IBAction func openZoomController(_ sender: Any) {
        self.performSegue(withIdentifier: "zooming", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let id = segue.identifier,
        let viewController = segue.destination as? ZoomFullScreenPhotoViewController,
        id == "zooming" {
        let size = CGSize(width: 1024, height: 768)
        let aspectScaledToFitImage = self.photo!.af.imageAspectScaled(toFit: size, scale: 0)
        viewController.photo = aspectScaledToFitImage
      }
    }
}
