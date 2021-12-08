//
//  EnrollKidsTableViewController.swift
//  iOS-KidsCare-Project
//
//  Created by Omairys Uzcátegui on 2021-12-01.
//

import UIKit
import FirebaseStorage

class EnrollKidsTableViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var kidprofileImageView: UIImageView!
    @IBOutlet weak var classRoomLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var alergiesLabel: UILabel!
    @IBOutlet weak var emergencyContactLabel: UILabel!
    @IBOutlet weak var emergencyContactNameLabel: UILabel!
    
    var randomID : String?
    var currentToddler : Toddler?
    var isUpdate = false
    var isChangeClassroom = false
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
            let currentName = self.currentToddler?.mName,
            let currentLastName = self.currentToddler?.mLastname,
            let currentClassRoom = self.currentToddler?.mClassRoom,
            let currentBirthday = self.currentToddler?.mBirthday,
            let currentGender = self.currentToddler?.mGender,
            let currentAlergies = self.currentToddler?.mAlergies,
            let currentEmerPhone = self.currentToddler?.mEmergencyPhone,
            let currentEmerName = self.currentToddler?.mEmergencyName,
            let currentImageUrl = self.currentToddler?.mImageUrl,
            let currentId = self.currentToddler?.mUid
        else {
                return
            }
        self.isUpdate = true
        self.nameLabel.text = currentName
        self.lastNameLabel.text = currentLastName
        self.classRoomLabel.text = currentClassRoom
        self.birthdayLabel.text = currentBirthday
        self.alergiesLabel.text = currentAlergies
        self.genderLabel.text = currentGender
        self.emergencyContactLabel.text = currentEmerPhone
        self.emergencyContactNameLabel.text = currentEmerName
        self.randomID = currentId
        //Cargar imagen
        let downloadRef = Storage.storage().reference(withPath: currentImageUrl)
        downloadRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let image = UIImage(data: data!)
                self.kidprofileImageView.image = image
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
            kidprofileImageView.image = image
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
        
        if indexPath.section == 1 && indexPath.row == 0 {
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
                self.classRoomLabel.text = values[0][index.row]
            }
            alert.addAction(title: "Done", style:.cancel)
            alert.show()
            
        }
        
        if indexPath.section == 1 && indexPath.row == 1 {
            var textFieldName = UITextField()
            tableView.deselectRow(at: indexPath, animated: true)
            let alert = UIAlertController(style: .actionSheet, title: "Name:", message: "Enter your kids's name")
    
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
                self.nameLabel.text = textFieldName.text!
            }
            alert.show(animated: true, vibrate: true)
        }
        
        if indexPath.section == 1 && indexPath.row == 2 {
            var textFieldLastName = UITextField()
            tableView.deselectRow(at: indexPath, animated: true)
            let alert = UIAlertController(style: .actionSheet, title: "LastName:", message: "Enter your kids's lastname")
            
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
                self.lastNameLabel.text = textFieldLastName.text!
            }
            alert.show()
            
            
        }
        if indexPath.section == 1 && indexPath.row == 3 {
            tableView.deselectRow(at: indexPath, animated: true)
            let alert = UIAlertController(style: .actionSheet, title: "Birthday", message: "Select the date of your kid's birthday")
            alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
                self.birthdayLabel.text = date.dateString()
            }
            alert.addAction(title: "Done", style: .cancel)
            alert.show()
        }
        if indexPath.section == 1 && indexPath.row == 4 {
            tableView.deselectRow(at: indexPath, animated: true)
            
            let alert = UIAlertController(style: .actionSheet, title: "Gender", message: "Select your kid's gender")
            alert.addAction(title: "Female", style: .default){ action in self.genderLabel.text = action.title }
            alert.addAction(title: "Male", style: .default){ action in self.genderLabel.text = action.title }
            alert.addAction(title: "Cancel", style: .cancel)
            alert.show()
        }
        if indexPath.section == 1 && indexPath.row == 5 {
            tableView.deselectRow(at: indexPath, animated: true)
            var textFieldAlergies = UITextField()
            let alert = UIAlertController(style: .actionSheet, title: "Allergies:", message: "Enter your kid's allergies")
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
                self.alergiesLabel.text = textFieldAlergies.text!
            }
            alert.show()
        }
        if indexPath.section == 1 && indexPath.row == 6 {
            tableView.deselectRow(at: indexPath, animated: true)
            var textFieldEmergencyPhone = UITextField()
            let alert = UIAlertController(style: .actionSheet, title: "Emergency contact phone:", message: "Enter your kid's emergency contact phone")
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
                self.emergencyContactLabel.text = textFieldEmergencyPhone.text!
            }
            alert.show()
        }
        
        if indexPath.section == 1 && indexPath.row == 7 {
            tableView.deselectRow(at: indexPath, animated: true)
            var textFieldEmergencyName = UITextField()
            let alert = UIAlertController(style: .actionSheet, title: "Emergency contact name:", message: "Enter your kid's emergency contact name")
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
                    textFieldEmergencyName = textField
                    //Log("textField = \(String(describing: textField.text))")
                }
            }
            alert.addOneTextField(configuration: textField)
            alert.addAction(title: "OK", style: .cancel){ action in
                self.emergencyContactNameLabel.text = textFieldEmergencyName.text!
            }
            alert.show()
        }
    }
    func addFeed(){
        if self.isUpdate {
            Manager.feed.createNewFeed(
                idf: DefaultData.user.mUid!+self.dateString2!,
                title: DefaultData.user.mName! + " has made an update",
                description: "Updated data for " + self.nameLabel.text!,
                visibility: self.classRoomLabel.text!,
                associatedImage: "",
                userImage: DefaultData.user.mImageUrl!,
                requiredAction: "NO",
                author: DefaultData.user.mUid!,
                date: self.dateString!,
                kid:self.randomID!,
                aid:"",
                completion: {check in if check {
                    print("information was added to the feed")
                    }
                    else {
                        self.displayAlert(title: "No information could be added to the feed", message: "unknow error")
                    }
                })
            if isChangeClassroom {
                enroll()
            }
        } else {
            enroll()
        }
    }
    
    func enroll(){
        Manager.feed.createNewFeed(
            idf: DefaultData.user.mUid!+self.dateString2!,
            title: self.nameLabel.text! + "  has enrolled in your class",
            description: self.nameLabel.text! + " has enrolled in your class, your acceptance is required",
            visibility: self.classRoomLabel.text!,
            associatedImage: "",
            userImage: DefaultData.user.mImageUrl!,
            requiredAction: "ACEPTAR",
            author: DefaultData.user.mUid!,
            date: self.dateString!,
            kid:self.randomID!,
            aid:"",
            completion: {check in if check {
                print("information was added to the feed")
                }
                else {
                    self.displayAlert(title: "No information could be added to the feed", message: "unknow error")
                }
            })
    }
    @IBAction func saveKid(_ sender: Any) {
        var enrrolled = false
        if currentToddler?.mClassRoom == self.classRoomLabel.text {
            enrrolled = true
        } else {
            isChangeClassroom = true
        }
        var uploadRef:StorageReference?
        
        if randomID != nil {
            uploadRef = Storage.storage().reference(withPath: (currentToddler?.mImageUrl!)!)
        } else {
            randomID = UUID.init().uuidString
            uploadRef = Storage.storage().reference(withPath: "profile_images/\(String(describing: randomID)).jpg")
        }
        guard let imageData = self.kidprofileImageView.image!.jpegData(compressionQuality: 0.5) else { return }
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = "image/jpg"
        
        uploadRef?.putData(imageData, metadata: uploadMetadata) { (downloadMetada, error) in
            if let error = error {
                print("Oh no! got an error! \(error.localizedDescription)")
                return
            }
            //print("Put is complete and I got this back: \(String(describing: downloadMetada))")
            Manager.toddler.createNewToddler(
                kid: self.randomID!,
                name_kid: self.nameLabel.text!,
                lastname_kid: self.lastNameLabel.text!,
                classRoom_kid: self.classRoomLabel.text!,
                emerPhone: self.emergencyContactLabel.text!,
                emerName: self.emergencyContactNameLabel.text!,
                imageUrl_kid: uploadRef!.fullPath,
                alergies: self.alergiesLabel.text!,
                birthday_kid: self.birthdayLabel.text!,
                gender_kid: self.genderLabel.text!,
                parent_kid_id: DefaultData.user.mUid!,
                enrrolled: enrrolled,
                completion: {check in if check {
                //activityIndicator.stopAnimating()
                    self.addFeed()
                    self.navigationController?.popViewController(animated: true)
                    
                }
                else {
                    self.displayAlert(title: "Could not enroll this kid", message: error!.localizedDescription)
                }
            })
        }
    }
}
