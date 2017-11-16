//
//  PhotoGalleryCropping.swift
//
//  Created by Vincent Narbot on 7/23/15.
//  Copyright (c) 2015 Vincent Narbot. All rights reserved.
//  reference:https://github.com/VincentNarbot/PhotoGallery-to-Square
//  some similar question we can found in https://stackoverflow.com/questions/28478293/losing-image-orientation-while-converting-an-image-to-cgimage

import Foundation
import UIKit

class PhotoGalleryCropping : NSObject {

    func cropToSquare(image: UIImage) -> UIImage {
        var positionX: CGFloat = 0.0
        var positionY: CGFloat = 0.0
        var width: CGFloat = image.size.width
        var height: CGFloat = image.size.height

        if width > height {
            //Landscape
            positionX = ((width - height ) / 2.0)
            width = height
        } 
        else if width < height {
            //Portrait
            positionX = ((height - width) / 2.0)
            height = width
        }
        else{
            //Already Square
        }
        
        let cropSquare = CGRect(x:positionX,y:positionY,width:width,height:height)
        // Create the crop region
        // It will lose the orientation when UIview is transfomed into CGView
        let croppedImage = (image.cgImage?.cropping(to: cropSquare))!
        
        return UIImage(cgImage:croppedImage , scale: 1.0, orientation:image.imageOrientation)
        // Creates a bitmap image using the data contained within a subregion of an existing bitmap image.
        // Retrun A CGImage object specifies a subimage of the image
        // If the rect parameter defines an area that is not in the image, then it returns null
    }

}
