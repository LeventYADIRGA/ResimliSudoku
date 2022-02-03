//
//  Extensions.swift
//  ResimliSudoku
//
//  Created by Levent yadırga on 31.01.2022.
//

import SwiftUI

extension View {
    
    
   
    
    
    var isMacOS: Bool {
#if os(macOS)
        return true
        #else
        return false
#endif
        
    }
    
    
    
    var isIpad: Bool {
#if os(iOS)
        return UIDevice.current.userInterfaceIdiom == .pad
#else
        return false
#endif
        
    }
    
    /// E.g., 12.9-inch iPads
    var isLargestIpad: Bool {
        isIpad && screenWidth > 1023
    }
    
    var screenHeight: CGFloat {
#if os(macOS)
        return NSScreen.main!.visibleFrame.size.height
#endif
        
#if os(iOS)
        return UIScreen.main.bounds.height
#endif
        
        
        
    }
    
    var screenWidth: CGFloat {
#if os(macOS)
        return NSScreen.main!.visibleFrame.size.width
#endif
        
#if os(iOS)
        return UIScreen.main.bounds.width
#endif
        
        
    }
    
    var isSmall: Bool{
        return screenHeight <= 1334 && screenHeight > 1136 //iPhones_6_6s_7_8
    }
    var isExtraSmall: Bool{
        return screenHeight <= 1136 //iPod
    }
}

