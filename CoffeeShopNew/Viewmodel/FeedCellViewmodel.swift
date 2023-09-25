//
//  FeedCellViewmodel.swift
//  CoffeeShopNew
//
//  Created by Mehmet Gül on 21.09.2023.
//

import Foundation
import UIKit

class FeedCellViewmodel {
    
    func findDominantColor(in image: UIImage) -> UIColor? {
        guard let cgImage = image.cgImage else {
            return nil
        }

        let width = cgImage.width
        let height = cgImage.height

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)

        guard let context = CGContext(data: nil,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: bitsPerComponent,
                                      bytesPerRow: bytesPerRow,
                                      space: colorSpace,
                                      bitmapInfo: bitmapInfo.rawValue) else {
            return nil
        }

        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        var colorCount: [UIColor: Int] = [:]

        let pixelData = context.data!.bindMemory(to: UInt8.self, capacity: width * height * bytesPerPixel)

        for y in 0..<height {
            for x in 0..<width {
                let offset = (y * width + x) * bytesPerPixel
                let alpha = CGFloat(pixelData[offset + 3]) / 255.0
                let red = CGFloat(pixelData[offset]) / 255.0
                let green = CGFloat(pixelData[offset + 1]) / 255.0
                let blue = CGFloat(pixelData[offset + 2]) / 255.0

                let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
                colorCount[color, default: 0] += 1
            }
        }

        if let dominantColor = colorCount.max(by: { $0.1 < $1.1 })?.key {
            return dominantColor
        }

        return nil
    }
    
    func isDarkColor(_ color: UIColor) -> Bool {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Renk bileşenlerinin ortalama değerini hesaplayın
        let brightness = (red + green + blue) / 3.0
        
        // Koyu renk kontrolü
        if brightness < 0.5 {
            return true // Koyu renkli
        } else {
            return false // Açık renkli
        }
    }
    
}
