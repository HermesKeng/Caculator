//
//  MLViewController.swift
//  Caculator_Final
//
//  Created by 耿楷寗 on 07/11/2017.
//  Copyright © 2017 EIE. All rights reserved.
//

import UIKit

class MLViewController: ViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    let googleModel = GoogLeNetPlaces()
    let mobileModel = MobileNet()
    let ResnetModel = Resnet50()
    let targetSize : CGSize = CGSize(width:224,height:224)
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func detectClick(_ sender: UIButton) {
        displayLabel.text = "Start to analyze the photo ..."
        
        let optionMenu = UIAlertController(title: "Please choose your training model !",message:"You can choose the model to detect the photo. It will give you different result" , preferredStyle:.alert)
        
        let cancelAction = UIAlertAction(title:"Cancel",style:.cancel , handler:nil)
        let googleNetPlaceAction = UIAlertAction(title:"GoogLeNetPlaces",style:.default,handler:{(action:UIAlertAction!) -> Void in
            
            if let processedImage = ImageProcessor.pixelBuffer(forImage: (self.photoImageView.image?.cgImage)!){
                guard let detectedImage = try? self.googleModel.prediction(sceneImage: processedImage) else{
                    print("error")
                    self.displayLabel.text = "error: image size is incorrect "
                    return
                }
                self.displayLabel.text = detectedImage.sceneLabel
                
            }
        })
        let mobileNetAction = UIAlertAction(title:"MobileNet",style:.default,handler:{(action:UIAlertAction!) -> Void in
            
            if let processedImage = ImageProcessor.pixelBuffer(forImage: (self.photoImageView.image?.cgImage)!){
                guard let detectedImage = try? self.mobileModel.prediction(image: processedImage) else{
                    print("error")
                    self.displayLabel.text = "error: image size is incorrect "
                    return
                }
                self.displayLabel.text = detectedImage.classLabel
            }
        })
        
        let resnet50Action = UIAlertAction(title:"Resnet50",style:.default,handler:{(action:UIAlertAction!) -> Void in
            
            if let processedImage = ImageProcessor.pixelBuffer(forImage: (self.photoImageView.image?.cgImage)!){
                guard let detectedImage = try? self.ResnetModel.prediction(image: processedImage) else{
                    print("error")
                    self.displayLabel.text = "error: image size is incorrect "
                    return
                }
                self.displayLabel.text = detectedImage.classLabel
            }
        })
        
        optionMenu.addAction(googleNetPlaceAction)
        optionMenu.addAction(mobileNetAction)
        optionMenu.addAction(resnet50Action)
        optionMenu.addAction(cancelAction)
        
        present(optionMenu,animated: true,completion: nil)
        
    }
    
    @IBAction func imageTap(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController,animated: true,completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: {print("cancel")})
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImg = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        var resizeImg = PhotoGalleryCropping().cropToSquare(image:selectedImg)
        
        let imageSize = resizeImg.size
        
        let widthRatio = targetSize.width / imageSize.width
        let heightRatio = targetSize.height / imageSize.height
        var newSize : CGSize
        if(widthRatio > heightRatio){
            newSize = CGSize(width: widthRatio * imageSize.width , height: heightRatio * imageSize.height)
        }else{
            newSize = CGSize(width: widthRatio * imageSize.width , height: heightRatio * imageSize.height)
        }
        var canvas = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
        
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        resizeImg.draw(in: canvas)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        print(newImage?.size.width,newImage?.size.height)
        
        photoImageView.image = newImage
        displayLabel.text="Unprocessed Image"
        dismiss(animated: true, completion: {print("select image successfully")})
        
    }


}
