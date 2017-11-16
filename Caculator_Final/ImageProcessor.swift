//
//  ImageProcessor.swift
//  Caculator_Final
//
//  Created by 耿楷寗 on 08/11/2017.
//  Copyright © 2017 EIE. All rights reserved.
//

import CoreVideo
import CoreGraphics
struct ImageProcessor {
    static func pixelBuffer(forImage image:CGImage) -> CVPixelBuffer?{
        
        let frameSize = CGSize(width: image.width, height: image.height)
        
        var pixelBuffer:CVPixelBuffer? = nil
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(frameSize.width), Int(frameSize.height), kCVPixelFormatType_32BGRA , nil, &pixelBuffer)
        
        if status != kCVReturnSuccess {
            return nil
            
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags.init(rawValue: 0))
        /*
         Lock the base address of the pixel buffer
         We must call the CVPixelBufferLockBaseAddress(_:_:) function before accessing pixel data with the CPU, and call the CVPixelBufferUnlockBaseAddress(_:_:) function afterward. If you include the readOnly value in the lockFlags parameter when locking the buffer, you must also include it when unlocking the buffer.
         */
        let data = CVPixelBufferGetBaseAddress(pixelBuffer!)
        /*
         return the base address of the pixel buffer
         retrieving the base address for a pixel buffer requires that the buffer base address be locked using the CVPixelBufferLockBaseAddress(_:_:) function.
         */
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
        let context = CGContext(data: data, width: Int(frameSize.width), height: Int(frameSize.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: bitmapInfo.rawValue)
        /*
         Core Graphic is also known as Quartz2D.
         We can know the API is based on Core Graphic framwork, so the data types and the routines that operate on them use CGprefix
         */
        
       
        context?.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))

        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
        
    }
}
