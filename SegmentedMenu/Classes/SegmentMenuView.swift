//
//  SegmentMenuView.swift
//  Page
//
//  Created by Quan on 08/07/2022.
//
import UIKit

public class SegmentedMenuView: AIXibViewLoader {
    // MARK: Core Properties
    weak var delegate : SegmentedMenuDelegate?
    var presenter: SegmentedMenuViewPresenter!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    let lineView = UIView(frame: CGRect.zero)
    
    
    var normalColor = UIColor.black
    var lineColor = UIColor(hexString: "#3669A3")
    var loaded = false
    
    var lineHeight: CGFloat = 3
    
    public override class func getBundle() -> Bundle {
        return SegmentedMenu.getBundle()
    }
    public override func initCustom() {
        super.initCustom()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewIsReady()
        self.initCollection()
        self.initLine()
        self.loaded = true
        self.reloadIndex()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    deinit {
        presenter?.viewDealloc()
    }
    
    func initLine() {
        self.lineView.frame = CGRect(x: 0, y: self.height - self.lineHeight, width: self.widthForIndex(0), height: lineHeight)
        self.lineView.backgroundColor = self.lineColor
        self.lineView.roundCorners(3, corner: [.topLeft, .topRight])
        self.collectionView.addSubview(self.lineView)
    }
    
    func initCollection() {
        
        self.collectionView.register(SegmentMenuCell.nib(), forCellWithReuseIdentifier: SegmentMenuCell.identifer)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.updateLineView()
    }
    
    func updateLineView(){
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.lineView.width = self.presenter!.widthCurrentIndex()
            self.lineView.roundCorners(5, corner: [.topLeft, .topRight])
            self.lineView.x = self.presenter!.xForCurrentIndex()
        }, completion: nil)
    }
    
    func widthForIndex(_ index: NSInteger) -> CGFloat{
        return self.presenter!.widthForIndex(index)
    }
}

extension SegmentedMenuView: SegmentedMenuViewInput {
    
    // Any -> View
    // TODO: Declare view methods
    
    
    public func getView() -> UIView {
        return self
    }
    
    public func reloadData(){
        self.collectionView.reloadData()
    }
    
    public func reloadIndex(){
        if self.loaded{
            self.updateLineView()
            self.collectionView.scrollToItem(at: IndexPath(item: self.presenter!.getIndex(), section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            self.reloadData()
        }
    }
    
    public func setLineHeight(_ height: CGFloat) {
        self.lineHeight = height
    }
    
    public func setBackgroundColor(_ color: UIColor?){
        if let color = color{
            self.backgroundColor = color
            self.collectionView.superview?.backgroundColor = color
            self.collectionView.backgroundColor = color
        }
    }
    
    public func setLineColor(color: UIColor) {
        self.lineColor = color
    }
}

extension SegmentedMenuView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter!.numberOfItem()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentMenuCell.identifer, for: indexPath) as! SegmentMenuCell
        let data = self.presenter?.itemAtIndex(indexPath.item)
        cell.titleLabel?.text = data?.title
        let selected = indexPath.row == self.presenter!.getIndex()
        cell.titleLabel?.textColor = selected ? self.lineColor : self.normalColor
        return cell
    }
}

extension SegmentedMenuView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.selectIndex(indexPath.item);
    }
}

extension SegmentedMenuView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: self.widthForIndex(indexPath.item), height: self.presenter.getHeight())
        //        Log.console("menu size \(size)")
        return size
    }
}
