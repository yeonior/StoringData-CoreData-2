//
//  ImageTransformer.swift
//  CoreDataExample2
//
//  Created by ruslan on 20.12.2021.
//

import UIKit

class ImageTransformer: ValueTransformer {
    
    // image to data
    override func transformedValue(_ value: Any?) -> Any? {
        
        guard let image = value as? UIImage else { return nil }
        let data = image.pngData()
        
        return data
    }
    
    // data to image
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        
        guard let data = value as? Data else { return nil }
        let image = UIImage(data: data)
        
        return image
    }
}
