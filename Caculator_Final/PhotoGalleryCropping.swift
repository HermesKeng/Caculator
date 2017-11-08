//
//  PhotoGalleryCropping.swift
//
//  Created by Vincent Narbot on 7/23/15.
//  Copyright (c) 2015 Vincent Narbot. All rights reserved.
//  reference:https://github.com/VincentNarbot/PhotoGallery-to-Square

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
            positionX = -((height - width) / 2.0)
            width = height
        } 
        else if width < height {
            //Portrait
            positionY = ((height - width) / 2.0)
            height = width
        }
        else{
            //Already Square
        }
        
        var cropSquare = CGRect(x:positionX,y:positionY,width:width,height:height)
        
        
        return UIImage(cgImage: (image.cgImage?.cropping(to: cropSquare))!, scale: 1.0, orientation:image.imageOrientation)
    }

}
