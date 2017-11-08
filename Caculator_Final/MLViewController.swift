//
//  MLViewController.swift
//  Caculator_Final
//
//  Created by 耿楷寗 on 07/11/2017.
//  Copyright © 2017 EIE. All rights reserved.
//

import UIKit

class MLViewController: ViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    //let model = GoogLeNetPlaces()
    //let model = MobileNet()
    let model = Resnet50()
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
        
        //let optionMenu = UIAlertController(title: nil,message: "Please choose your training model !", preferredStyle:.alert)
        
        if let processedImage = ImageProcessor.pixelBuffer(forImage: (photoImageView.image?.cgImage)!){
            guard let detectedImage = try? model.prediction(image: processedImage) else{
                print("error")
                displayLabel.text = "error: image size is incorrect "
                return
            }
            displayLabel.text = detectedImage.classLabel
        }
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
        print(imageSize.width,imageSize.height)
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
        selectedImg.draw(in: canvas)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        print(newImage?.size.width,newImage?.size.height)
        
        photoImageView.image = newImage
        displayLabel.text="Unprocessed Image"
        dismiss(animated: true, completion: {print("select image successfully")})
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
