//
//  SegmentedMenuProtocol.swift
//
//  Created by Quan on 08/07/2022.
//
//

import Foundation
import UIKit


public class SegmentedMenuDataModel: NSObject{
    public var title: String
    public var icon: String?
    public var isRemote: Bool = false
    public var fullImage: Bool = false
    public var data: Any?
    public var bundle: Bundle?
    public var ignoreSwitch: Bool = false
    
    public init(title: String, icon: String? = nil, bundle: Bundle? = nil) {
        self.title = title
        super.init()
        self.icon = icon
        self.bundle = bundle
    }
}

public protocol SegmentedMenuViewInput: AnyObject {
    // Any -> View
    // TODO: Declare view methods
    
    func getView() -> UIView
    func reloadData()
    func reloadIndex()
    func setLineHeight(_ height: CGFloat)
    func setBackgroundColor(_ color: UIColor?)
    func setLineColor(color: UIColor)
}


public protocol SegmentedMenuDataPresenter: AnyObject {
    // Outsite -> Presenter
    // TODO: Declare presentation methods
    func setDataSources(_ datas: [String])
    func setDataSources(models: [SegmentedMenuDataModel])
    func setFullItemWidth(_ full:Bool)
    func setLineHeight(_ height: CGFloat)
    func setDefaultIndex(_ index: Int)
    func setBadge(_ content: String?, index: Int)
    func setEnableBadge(_ enable: Bool)
    func getEnableBadge() -> Bool
    func setHeight(_ height: CGFloat)
    func getHeight() -> CGFloat
    func setBackgroundColor(_ color: UIColor)
    func setLineColor(color: UIColor)
}


public protocol SegmentedMenuViewPresenter: SegmentedMenuDataPresenter {
    // View -> Presenter
    // TODO: Declare presentation methods
    
    func viewIsReady()
    func viewDealloc()
    func viewReappear()
    func selectIndex(_ index: Int)
    func scrollIndex(_ index: Int)
    func xForCurrentIndex() -> CGFloat
    func widthCurrentIndex() -> CGFloat
    func widthForIndex(_ index: NSInteger) -> CGFloat
    func numberOfItem() -> NSInteger
    func itemAtIndex(_ index: NSInteger) -> SegmentedMenuDataModel
    func getIndex() -> NSInteger
    func getBadgeIndex(_ index: Int) -> String?
}


public protocol SegmentedMenuInteractorInput: AnyObject {
    // Any -> Interactor
    // TODO: Declare use case methods
    
}


public protocol SegmentedMenuInteractorPresenter: AnyObject {
    // Interactor -> Presenter
    // TODO: Declare interactor output methods
    
}


public protocol SegmentedMenuRouter: AnyObject {
    // Any -> Router
    // TODO: Declare router methods
    
    func segmentedMenuSelected(_ index: Int)
    
}



public protocol SegmentedMenuDelegate: AnyObject {
    // Any -> Wireframe
    // TODO: Declare wireframe methods
    func segmentedMenu(_ segmented: SegmentedMenuModule, index: Int)
    
}


public protocol SegmentedMenuModule: AnyObject {
    // Any -> Module
    // TODO: Declare module methods
    
    func setDelegate(_ delegate: SegmentedMenuDelegate)
    func getDelegate() -> SegmentedMenuDelegate?
    func getView() -> UIView
    func getModuleData() -> SegmentedMenuDataPresenter
    func selectIndex(_ index: Int)
    func scrollIndex(_ index: Int)
    func reloadData()
}


public class SegmentedMenuFactory: NSObject {
    public static func create() -> SegmentedMenuModule {
        
        let module: SegmentedMenuView = SegmentedMenuView.init(frame: CGRect.zero)
        let presenter = SegmentedMenuPresenter()
        let interactor = SegmentedMenuInteractor()
        
        module.presenter =  presenter
        
        interactor.presenter = presenter
        
        presenter.view = module
        presenter.router = module
        presenter.interactor = interactor
        
        return module
    }
}
