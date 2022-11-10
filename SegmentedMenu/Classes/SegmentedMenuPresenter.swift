//
//  SegmentedMenuPresenter.swift
//  Pods
//
//  Created by Sy Quan on 11/17/18.
//
//

import Foundation
import UIKit

class SegmentedMenuPresenter: NSObject {
    // MARK: Core Properties
    weak var view: SegmentedMenuViewInput!
    weak var router: SegmentedMenuRouter!
    var interactor: SegmentedMenuInteractorInput!

    // MARK: Properties
    private var datasources: [SegmentedMenuDataModel] = []
    private var dumpLabel = UILabel(frame: CGRect.zero)
    var index: Int = 0
    var isFullItemWidth = false
    var lineHeight:CGFloat = 2
    var badgeContent: [Int: String] = [:]
    var enableBade: Bool = false
    var viewHeight: CGFloat = 40
    
    // MARK: Methods
    var color: UIColor?
    
    override init() {
        super.init()
        self.dumpLabel.font = UIFont.systemFont(ofSize: 12)
    }
}


extension SegmentedMenuPresenter: SegmentedMenuViewPresenter {
    // View -> Presenter
    // TODO: Declare presentation methods
    
    func viewIsReady() {
        self.view.reloadIndex()
        self.view.setBackgroundColor(self.color)
    }
    
    func viewDealloc() {
        
    }
    
    func viewReappear(){
        
    }
    
    func selectIndex(_ index: Int) {
//        self.index = index;
//        self.view.reloadIndex()
        if !(datasources.objectAtIndex(index)?.ignoreSwitch ?? false){
            scrollIndex(index)
            self.router.segmentedMenuSelected(self.index)
        }else{
            self.router.segmentedMenuSelected(index)
        }
    }
    func scrollIndex(_ index: Int){
        
        self.index = index;
        self.view.reloadIndex()
    }
    
    func widthForIndex(_ index: NSInteger) -> CGFloat {
        if self.isFullItemWidth {
            return UIScreen.main.bounds.width/CGFloat(self.datasources.count)
        }
        var extraIcon: CGFloat = 0
        if let data = self.datasources.objectAtIndex(index){
            let content = data.title
            self.dumpLabel.text = content
            if data.icon != nil {
                extraIcon = viewHeight
            }
        }
        
        let finalWidth = self.dumpLabel.widthWithMaxHeight(CGFloat.greatestFiniteMagnitude) + 30 + extraIcon
        
        return finalWidth
    }
    
    func widthCurrentIndex() -> CGFloat{
        return self.widthForIndex(self.index)
    }
    
    func numberOfItem() -> NSInteger {
        return self.datasources.count
    }
    
    func itemAtIndex(_ index: NSInteger) -> SegmentedMenuDataModel{
        return self.datasources.objectAtIndex(index) ?? SegmentedMenuDataModel(title: "---")
    }
    func xForCurrentIndex() -> CGFloat {
        return xForIndex(self.index)
    }
    
    func xForIndex(_ index: NSInteger) -> CGFloat{
        var x:CGFloat = 0
        for i in 0..<index {
            x += self.widthForIndex(i)
        }
        return x
    }
    
    func getIndex() -> NSInteger{
        return self.index
    }
    
    func getBadgeIndex(_ index: Int) -> String? {
        return self.badgeContent[index]
    }
}

extension SegmentedMenuPresenter: SegmentedMenuInteractorPresenter {
    // Interactor -> Presenter
    // TODO: Declare interactor output methods
}

extension SegmentedMenuPresenter: SegmentedMenuDataPresenter {
    // Outsite -> Presenter
    public func setDataSources(_ datas: [String]) {
        self.datasources.removeAll()
        for item in datas{
            self.datasources.append(SegmentedMenuDataModel(title: item))
        }
        self.view.reloadData()
    }
    
    func setLineColor(color: UIColor) {
        self.view.setLineColor(color: color)
    }
    
    
    public func setDataSources(models: [SegmentedMenuDataModel]){
        self.datasources = models
        self.view.reloadData()
    }

    public func setFullItemWidth(_ full:Bool){
        self.isFullItemWidth = full
    }
    public func setLineHeight(_ height: CGFloat){
        self.lineHeight = height
    }
    
    func setDefaultIndex(_ index: Int) {
        self.index = index
    }
    
    func setBadge(_ content: String?, index: Int){
        self.badgeContent[index] = content
    }
    
    func setEnableBadge(_ enable: Bool) {
        self.enableBade = enable
    }
    func getEnableBadge() -> Bool {
        return self.enableBade
    }
    
    func setHeight(_ height: CGFloat) {
        viewHeight = height
    }
    
    func getHeight() -> CGFloat {
        return viewHeight
    }
    
    func setBackgroundColor(_ color: UIColor){
        self.color = color
    }
}
