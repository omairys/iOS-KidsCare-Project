//
//  EditProfileTableViewController.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-12-07.
//

import UIKit
import FirebaseStorage

class EditProfileTableViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var teacher_iv_update: UIImageView!
    @IBOutlet weak var class_room_update: UILabel!
    @IBOutlet weak var name_tf_update: UILabel!
    @IBOutlet weak var lastname_update: UILabel!
    @IBOutlet weak var address_tf_update: UILabel!
    @IBOutlet weak var phone_tf_update: UILabel!

    var currentImageUrlupdate : String = ""
    var randomID : String?
    var dateString : String?
    var dateString2 : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIValues()
    }
    
    func setUIValues() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateString = dateFormatter.string(from: Date())
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyyMMddhhmmss"
        dateString2 = dateFormatter2.string(from: Date())
        guard
            let currentName = DefaultData.user.mName,
            let currentLastName = DefaultData.user.mLastname,
            let currentClassRoom = DefaultData.user.mClassroom,
            let currentAddress = DefaultData.user.mAddress,
            let currentPhone = DefaultData.user.mPhone,
            let currentImageUrl = DefaultData.user.mImageUrl,
            let currentId = DefaultData.user.mUid
        else {
                return
            }
        
        self.name_tf_update.text = currentName
        self.lastname_update.text = currentLastName
        self.class_room_update.text = currentClassRoom
        self.address_tf_update.text = currentAddress
        self.phone_tf_update.text = currentPhone
        self.currentImageUrlupdate = currentImageUrl
        self.randomID = currentId
        //Cargar imagen
        let downloadRef = Storage.storage().reference(withPath: currentImageUrl)
        downloadRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let image = UIImage(data: data!)
                self.teacher_iv_update.image = image
            }
          }
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
            teacher_iv_update.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Log("the selected section is: \(indexPath.section)")
        
        if indexPath.section == 0 && indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
        
        if indexPath.section == 0 && indexPath.row == 1 {
            tableView.deselectRow(at: indexPath, animated: true)
            let alert = UIAlertController(style: .actionSheet, title: "Classroom", message: "Select the classroom to enroll")
            let frameSizes: [CGFloat] = (150...300).map { CGFloat($0) }
            let pickerViewValues: [[String]] = [["2015","2016","2017","2018","2019","2020"]]
            let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: 2 )
            
            alert.addPickerView(values: pickerViewValues, initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 1) {
                        vc.preferredContentSize.height = frameSizes[index.row]
                    }
                }
                self.class_room_update.text = values[0][index.row]
            }
            alert.addAction(title: "Done", style:.cancel)
            alert.show()
            
        }
        
        if indexPath.section == 0 && indexPath.row == 2 {
            var textFieldName = UITextField()
            tableView.deselectRow(at: indexPath, animated: true)
            let alert = UIAlertController(style: .actionSheet, title: "Name:", message: "Enter your name")
    
            let textField: TextField.Config = { textField in
                textField.leftViewPadding = 12
                textField.becomeFirstResponder()
                textField.borderWidth = 1
                textField.cornerRadius = 8
                textField.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
                textField.backgroundColor = nil
                textField.textColor = .black
                textField.keyboardAppearance = .default
                textField.keyboardType = .default
                textField.returnKeyType = .done
                textField.action { textField in
                    textFieldName = textField
                    
                }
            }
            
        
            alert.addOneTextField(configuration: textField)
            alert.addAction(title: "OK", style: .cancel) { action in
                self.name_tf_update.text = textFieldName.text!
            }
            alert.show(animated: true, vibrate: true)
        }
        
        if indexPath.section == 0 && indexPath.row == 3 {
            var textFieldLastName = UITextField()
            tableView.deselectRow(at: indexPath, animated: true)
            let alert = UIAlertController(style: .actionSheet, title: "LastName:", message: "Enter your lastname")
            
            let textField: TextField.Config = { textField in
                textField.leftViewPadding = 12
                textField.becomeFirstResponder()
                textField.borderWidth = 1
                textField.cornerRadius = 8
                textField.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
                textField.backgroundColor = nil
                textField.textColor = .black
                textField.keyboardAppearance = .default
                textField.keyboardType = .default
                textField.returnKeyType = .done
                textField.action { textField in
                    textFieldLastName = textField
                    
                }
            }
            alert.addOneTextField(configuration: textField)
            alert.addAction(title: "OK", style: .cancel) { action in
                self.lastname_update.text = textFieldLastName.text!
            }
            alert.show()
            
            
        }

        if indexPath.section == 0 && indexPath.row == 4 {
            tableView.deselectRow(at: indexPath, animated: true)
            var textFieldAlergies = UITextField()
            let alert = UIAlertController(style: .actionSheet, title: "Phone:", message: "Enter your phone")
            let textField: TextField.Config = { textField in
                textField.leftViewPadding = 12
                textField.becomeFirstResponder()
                textField.borderWidth = 1
                textField.cornerRadius = 8
                textField.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
                textField.backgroundColor = nil
                textField.textColor = .black
                textField.keyboardAppearance = .default
                textField.keyboardType = .default
                textField.returnKeyType = .done
                textField.action { textField in
                    textFieldAlergies = textField
                    //Log("textField = \(String(describing: textField.text))")
                }
            }
            alert.addOneTextField(configuration: textField)
            alert.addAction(title: "OK", style: .cancel){ action in
                self.phone_tf_update.text = textFieldAlergies.text!
            }
            alert.show()
        }
        if indexPath.section == 0 && indexPath.row == 5 {
            tableView.deselectRow(at: indexPath, animated: true)
            var textFieldEmergencyPhone = UITextField()
            let alert = UIAlertController(style: .actionSheet, title: "Address:", message: "Enter your Address")
            let textField: TextField.Config = { textField in
                textField.leftViewPadding = 12
                textField.becomeFirstResponder()
                textField.borderWidth = 1
                textField.cornerRadius = 8
                textField.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
                textField.backgroundColor = nil
                textField.textColor = .black
                textField.keyboardAppearance = .default
                textField.keyboardType = .default
                textField.returnKeyType = .done
                textField.action { textField in
                    textFieldEmergencyPhone = textField
                    //Log("textField = \(String(describing: textField.text))")
                }
            }
            alert.addOneTextField(configuration: textField)
            alert.addAction(title: "OK", style: .cancel){ action in
                self.address_tf_update.text = textFieldEmergencyPhone.text!
            }
            alert.show()
        }
    }


    @IBAction func saveTeacher(_ sender: Any) {
        var uploadRef:StorageReference?
        
        if randomID != nil {
            uploadRef = Storage.storage().reference(withPath: currentImageUrlupdate)
        } else {
            randomID = UUID.init().uuidString
            uploadRef = Storage.storage().reference(withPath: "profile_images/\(String(describing: randomID)).jpg")
        }
        guard let imageData = self.teacher_iv_update.image!.jpegData(compressionQuality: 0.5) else { return }
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = "image/jpg"
        
        uploadRef?.putData(imageData, metadata: uploadMetadata) { (downloadMetada, error) in
            if let error = error {
                print("Oh no! got an error! \(error.localizedDescription)")
                return
            }
            //print("Put is complete and I got this back: \(String(describing: downloadMetada))")
            Manager.user.createNewAccount(
                uid: DefaultData.user.mUid!,
                name: self.name_tf_update.text!,
                lastname: self.lastname_update.text!,
                address: self.address_tf_update.text!,
                phone: self.phone_tf_update.text!,
                email: DefaultData.user.mEmail!,
                imageUrl: uploadRef!.fullPath,
                userType: "teacher",
                classroom: self.class_room_update.text!,
                completion: { check in if check {
                    //activityIndicator.stopAnimating()
                    print("usuario actualizado")
                    
                    self.clearDefaultData()
                    DefaultData.user.ditinit(id: DefaultData.user.mUid!, completion: {
                        let defaults = UserDefaults.standard
                        defaults.set(DefaultData.user.mClassroom, forKey: "classroom")
                        defaults.synchronize()
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                }
                else {
                    self.displayAlert(title: "Could not update", message: error!.localizedDescription)
                }
            })
        }
    }
    
    private func clearDefaultData() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "classroom")
        defaults.synchronize()
    }
}
