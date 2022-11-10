//
//  UILabelSizeCalculator.swift
//  ExtPageView
//
//  Created by Quan on 29/06/2022.
//

import Foundation
import UIKit

extension UILabel{
    
    public func widthWithMaxHeight(_ height:CGFloat) -> CGFloat{
        return self.widthWithMaxHeight(height, lineLimit: self.numberOfLines)
    }
    
    
    public func heightWithMaxWidth(_ width:CGFloat) -> CGFloat{
        return self.heightWithMaxWidth(width, lineLimit: self.numberOfLines)
        
    }
    
    
    public func widthWithMaxHeight(_ height:CGFloat, lineLimit: NSInteger) -> CGFloat{
        let frame = self.textRect(forBounds: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height), limitedToNumberOfLines: lineLimit)
        return frame.size.width;
    }
    
    
    public func heightWithMaxWidth(_ width:CGFloat, lineLimit: NSInteger) -> CGFloat{
        let frame = self.textRect(forBounds: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude), limitedToNumberOfLines: lineLimit)
        //        Log.console("heightWithMaxWidth \(width), \(lineLimit), \(self.attributedText?.string)")
        return frame.size.height;
        
    }
    public func sizeWithMaxWidth(_ width:CGFloat, lineLimit: NSInteger) -> CGSize{
        let frame = self.textRect(forBounds: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude), limitedToNumberOfLines: lineLimit)
        //        Log.console("heightWithMaxWidth \(width), \(lineLimit), \(self.attributedText?.string)")
        return frame.size;
        
    }
    
}

extension UITextField {
    
    public func widthWithMaxHeight(_ height:CGFloat) -> CGFloat{
        self.textRect(forBounds: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height))
        return frame.size.height;
    }
    
    public func heightWithMaxWidth(_ width:CGFloat) -> CGFloat{
        
        self.textRect(forBounds: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        return frame.size.height;
    }
}

