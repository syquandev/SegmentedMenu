//
//  ViewController.swift
//  SegmentedMenu
//
//  Created by 95286760 on 11/10/2022.
//  Copyright (c) 2022 95286760. All rights reserved.
//

import UIKit
import SegmentedMenu

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var segmentedHolder: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var pageHolder: UIView!
    
    var pageView: UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
    var segmeted = SegmentedMenuFactory.create()
    public var modules: [UIViewController] = []
    var tabIndex = 0
    let vc1 = ColorViewController.create()
    let vc2 = ColorViewController.create()
    let vc3 = ColorViewController.create()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSegmented()
        initPageView()
        pageView.dataSource = self
        pageView.delegate = self
        scrollToPageIndex(0)
    }
    
    func initPageView(){
        pageHolder.addSubViewAndBoundMaskPin(pageView.view)
        addChildViewController(pageView)
        pageView.didMove(toParentViewController: self)
        pageView.dataSource = self
        pageView.delegate = self
    }
    
    public func swipeAnimationTabIndex(_ index:Int){
        segmeted.selectIndex(index)
    }
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        return modules.objectAtIndex(index)
    }
    
    public func scrollToPageIndex(_ index: Int){
        let direction = index <  tabIndex ? UIPageViewController.NavigationDirection.reverse : UIPageViewController.NavigationDirection.forward
        if let controller = modules.objectAtIndex(index){
            self.pageView.setViewControllers([controller], direction: direction, animated: true) { (finished) in
                //
            }
        }
        tabIndex = index
    }
    
    func initSegmented(){
        modules.append(vc1)
        modules.append(vc2)
        modules.append(vc3)
        segmeted.getModuleData().setFullItemWidth(true)
        segmeted.setDelegate(self)
        segmentedHolder.addSubViewAndBoundMaskPin(segmeted.getView())
        segmeted.getModuleData().setDataSources(["Question 1", "Question 2", "Question 3"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: SegmentedMenuDelegate {
    
    public func segmentedMenu(_ segmented: SegmentedMenuModule, index: Int){
        
        scrollToPageIndex(index)
    }
}

extension ViewController: UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = modules.indexOfObject(viewController){
            return modules.objectAtIndex(index - 1)
        }
        return nil
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = modules.indexOfObject(viewController){
            return modules.objectAtIndex(index + 1)
        }
        return nil
    }
    
}

extension ViewController: UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let first = pageViewController.viewControllers?.first{
            if let index = modules.indexOfObject(first){
                swipeAnimationTabIndex(index)

            }
        }
    }
}
