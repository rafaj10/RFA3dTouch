//
//  RFA3dTouch.swift
//  RFA3dTouch
//
//  Created by Rafael Assis on 3/6/16.
//  Copyright © 2016 rfa. All rights reserved.
//

import UIKit
import AudioToolbox

public protocol RFA3dTouchDataSource {
    func RFA3dTouchNumberOfRows() -> Int
    func RFA3dTouchTitlePerRow(row: NSInteger) -> NSString
    func RFA3dTouchIconPerRow(row: NSInteger) -> NSString
}

public protocol RFA3dTouchDelegate {
    func RFA3dTouchSelectItemForRow(row: NSInteger)
}

class RFA3dTouch: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var datasource: RFA3dTouchDataSource?
    var delegate: RFA3dTouchDelegate?
    
    var tableView: UITableView = UITableView()
    var contentView: UIView = UIView()
    
    let cell_height : CGFloat = 60.0
    
    class func instance(interface: AnyObject) -> RFA3dTouch {
        let window = UIApplication.sharedApplication().delegate?.window!!
        let view = RFA3dTouch(frame: (window?.bounds)!)
        view.datasource = interface as? RFA3dTouchDataSource
        view.delegate = interface as? RFA3dTouchDelegate
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    func showMenu(sender : UIView, point: CGPoint) {
        
        if datasource?.RFA3dTouchNumberOfRows() == 0 {
            return
        }
        
        let window = UIApplication.sharedApplication().delegate?.window!!
        window!.addSubview(self)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        self.contentView = UIVisualEffectView(effect: blurEffect)
        self.contentView.frame = ((window?.bounds)!)
        self.contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.contentView.alpha = 0;
        self.addSubview(self.contentView)
        self.createTable()
        
        self.contentView.addSubview(sender)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapped:")
        self.contentView.addGestureRecognizer(tapGestureRecognizer)
        
        sender.frame = CGRectMake(point.x, point.y, sender.frame.size.width, sender.frame.size.height)
        
        self.tableView.frame = CGRectMake(point.x, point.y, 10, 10)
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: {
            self.contentView.alpha = 1
            self.tableView.alpha = 0.6
            self.tableView.frame = self.whatsTablePosition(point, fromSize: sender.frame.size)
            }, completion: { finished in })
    }
    
    class func absolutePosition (superView: AnyObject, view: AnyObject) -> CGPoint {
        let window = UIApplication.sharedApplication().delegate?.window!!
        let frame = superView.convertRect(view.frame, toView: window)
        return frame.origin
    }
    
    class func takeSnap (view: AnyObject) -> UIView {
        let viewSnap = view.resizableSnapshotViewFromRect(view.bounds, afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)
        return viewSnap
    }
    
    func tapped(sender: UITapGestureRecognizer) {
        self.dismiss()
    }
    
    func dismiss() {
        UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseInOut, animations: {
            self.contentView.alpha = 0
            self.tableView.alpha = 0 }, completion: { finished in
                self.removeFromSuperview()
                //self.hidden = true
        })
    }
    
    func kill (){
        self.removeFromSuperview()
    }
    
    private func createTable() {
        
        let window = UIApplication.sharedApplication().delegate?.window!!
        
        tableView.frame         =   CGRectMake((window!.frame.size.width-tableSize().width)/2, (window!.frame.size.height-tableSize().width)/2, tableSize().width, tableSize().height);
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.layer.cornerRadius = 8.0
        tableView.clipsToBounds = true
        tableView.alpha = 0;
        tableView.backgroundColor = UIColor.clearColor()
        tableView.showsVerticalScrollIndicator = false
        
        self.addSubview(tableView)
    }
    
    private func whatsTablePosition (fromPoint: CGPoint, fromSize: CGSize) -> CGRect{
        let window = UIApplication.sharedApplication().delegate?.window!!
        var newPoint = CGPointMake(0, 0)
        let margin = CGFloat(12)
        
        if(fromPoint.x <= margin){
            newPoint.x = margin;
        } else if ( (fromPoint.x+self.tableSize().width) >= window?.frame.width){
            newPoint.x = ((window?.frame.size.width)!-self.tableSize().width)-margin
        }else{
            newPoint.x = fromPoint.x
        }
        
        if( (fromPoint.y+tableSize().height) >= window?.frame.height){
            newPoint.y = ((fromPoint.y - tableSize().height)-margin)
        }else{
            newPoint.y = ((fromPoint.y + fromSize.height)+margin)
        }
        
        let tableRect = CGRectMake(newPoint.x, newPoint.y, self.tableSize().width, tableSize().height)
        return tableRect
    }
    
    private func tableSize() -> CGSize{
        let tableWidth =  CGFloat(230)
        let numberOfRows = self.datasource == nil ? 0 : self.datasource!.RFA3dTouchNumberOfRows()
        let tableHeight = numberOfRows > 5 ? CGFloat (310) : CGFloat(60*self.datasource!.RFA3dTouchNumberOfRows())
        
        return CGSizeMake(tableWidth, tableHeight)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cell_height
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return self.datasource == nil ? 0 : self.datasource!.RFA3dTouchNumberOfRows()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")!
        
        for view in cell.subviews{
            view.removeFromSuperview()
        }
        
        cell.alpha = 0.7;
        
        cell.backgroundColor =  UIColor( red: CGFloat(233.0/255.0), green: CGFloat(242/255.0), blue: CGFloat(246/255.0), alpha: CGFloat(1.0) )
        
        let labelTitle = UILabel(frame: CGRect(x: 68, y: cell_height/2, width: 140, height: 36))
        labelTitle.text = self.datasource!.RFA3dTouchTitlePerRow(indexPath.row) as String
        labelTitle.font = UIFont(name: labelTitle.font.fontName, size: 14)
        labelTitle.numberOfLines = 2
        cell.addSubview(labelTitle)
        
        let imageView = UIImageView(image: UIImage(named: self.datasource!.RFA3dTouchIconPerRow(indexPath.row) as String))
        imageView.frame = CGRect(x: 12, y: 8, width: 42, height: 42)
        cell.addSubview(imageView)
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.delegate!.RFA3dTouchSelectItemForRow(indexPath.row)
        dismiss()
    }
    
}

