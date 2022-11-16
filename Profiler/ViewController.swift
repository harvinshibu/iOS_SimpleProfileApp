//
//  ViewController.swift
//  Profiler
//
//  Created by Harvin Shibu on 04/11/22.
//

import UIKit

struct abc{
    var asd : String
    var qwe: String
}

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var profImg: UIImageView!
    
    @IBOutlet weak var sexField: UITextField!
    var pickerView = UIPickerView()
    var sArray = ["Male","Female","Others"]
    
    @IBOutlet weak var dateField: UITextField!
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        sexField.inputView = pickerView
        pickerView.backgroundColor = .white
        pickerView.tintColor = .black
        
        
        datePicker.datePickerMode = .date
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.addTarget(self, action: #selector(dateSelectorFromPicker(sender:)), for: UIControl.Event.valueChanged)
        dateField.inputView = datePicker
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func uploadBtn(_ sender: Any) {
        let takePhoto = UIAlertAction(title: "Take Photo",
                                style: .default) { (action) in
            self.showImagePicker(source: .camera)
           }
           let uploadLibrary = UIAlertAction(title: "Upload from Library",
                                style: .default) { (action) in
               self.showImagePicker(source: .photoLibrary)
           }
           
        
        let alert = UIAlertController(title: "Upload Image", message: "Select an Option:", preferredStyle: .alert)
        alert.addAction(takePhoto)
        alert.addAction(uploadLibrary)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert,animated: true,completion: nil)
        
    }
    @objc func dateSelectorFromPicker(sender : UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateField.text = formatter.string(from: sender.date)
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sexField.text = sArray[row]
        sexField.resignFirstResponder()
        
    }
    
    func showImagePicker(source : UIImagePickerController.SourceType){
        guard UIImagePickerController.isSourceTypeAvailable(source) else{
            print("Source not Available")
            return
        }
        
        let imgPickController = UIImagePickerController()
        imgPickController.delegate = self
        imgPickController.sourceType = source
        imgPickController.allowsEditing = false
        self.present(imgPickController, animated: true)
            
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let sImg = info[.originalImage] as? UIImage{
            profImg.image = sImg
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

}

