//
//  RegTeacherViewController.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-11-24.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth

class RegTeacherViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let ref = Database.database().reference(withPath: "Users")
    var refObservers: [DatabaseHandle] = []
    
    @IBOutlet weak var teacher_iv: UIImageView!
    @IBOutlet weak var name_tf: UITextField!
    @IBOutlet weak var lastname_tf: UITextField!
    @IBOutlet weak var address_tf: UITextField!
    @IBOutlet weak var phone_tf: UITextField!
    @IBOutlet weak var email_tf: UITextField!
    @IBOutlet weak var password_tf: UITextField!
    @IBOutlet weak var password_tf_confirm: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectImageTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    //gestiona las alertas
    func displayAlert(title: String, message:String){
        let alertController =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true, completion: nil)
    }
    
    //gestiona que hacer cuando el usuario selecciona la imagen
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            teacher_iv.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneRegTeacherButtonAct(_ sender: Any) {
        // TODO: VALIDAR CAMPOS VACIOS O NULOS Y CONTRASEÑA IGUAL
        
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x:0, y:0, width:50, height:50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        //UIApplication.shared.beginIgnoringInteractionEvents()
        
        if let email = email_tf.text, let password = password_tf.text, let name = name_tf.text{
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let result = result, error == nil {
                    let randomID = UUID.init().uuidString
                    let uploadRef = Storage.storage().reference(withPath: "profile_images/\(randomID).jpg")
                    guard let imageData = self.teacher_iv.image!.jpegData(compressionQuality: 0.5) else { return }
                    let uploadMetadata = StorageMetadata.init()
                    uploadMetadata.contentType = "image/jpg"
                    
                    uploadRef.putData(imageData, metadata: uploadMetadata) { (downloadMetada, error) in
                        if let error = error {
                            print("Oh no! got an error! \(error.localizedDescription)")
                            return
                        }
                        
                        print("Put is complete and I got this back: \(String(describing: downloadMetada))")
                    }
                    
                    let currentUserId = Auth.auth().currentUser?.uid
                    
                    Manager.user.createNewAccount(
                        uid: currentUserId!,
                        name: name,
                        lastname: self.lastname_tf.text!,
                        address: self.address_tf.text!,
                        phone: self.phone_tf.text!,
                        email: self.email_tf.text!,
                        imageUrl: uploadRef.fullPath,
                        userType: "teacher",
                        classroom: "",
                        completion: { check in if check {
                            activityIndicator.stopAnimating()
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                        else {
                            self.displayAlert(title: "Could not sign you up", message: error!.localizedDescription)
                        }
                    })
                    
                }else{
                    var errorText = "Unknown error: please try again"
                    if let error = error{
                        errorText = error.localizedDescription
                    }
                    self.displayAlert(title: "Could not sign you up", message: errorText)
                    activityIndicator.stopAnimating()
                }
            }
        }else{
            displayAlert(title: "Error in form", message: "Invalid fields, please check")
            activityIndicator.stopAnimating()
        }
    }
    
}
