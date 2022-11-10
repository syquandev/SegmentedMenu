import UIKit

public class SegmentedMenu: NSObject {
    public static let shared = SegmentedMenu()
    
    public static func getBundle() -> Bundle {
        
        let frameworkBundle = Bundle(for: SegmentedMenu.self)
        let path = frameworkBundle.resourceURL?.appendingPathComponent("SegmentedMenu.bundle")
        let resourcesBundle = Bundle(url: path!)
        return resourcesBundle ?? Bundle.main
        
    }
    
    public static func resourcesPath(name: String, type: String) -> String? {
        let bundle = SegmentedMenu.getBundle()
        let pathForResourceString = bundle.path(forResource: name, ofType: type)
        return pathForResourceString
    }

    
}
