//
//  ViewController.swift
//  demo
//
//  Created by ispl Mac Mini on 8/23/17.
//  Copyright © 2017 infinium. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate, UIActionSheetDelegate {

    let testingStoryboardCell:Bool = false
    var tests:NSMutableArray!
    @IBOutlet var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path: String? = Bundle.main.path(forResource: "myRecipesBook", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        let tblDtaFetch:NSArray = dict?.object(forKey: "RecipeName") as! NSArray
        
        tests = NSMutableArray(array: tblDtaFetch)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tests.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:MGSwipeTableCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MGSwipeTableCell
        
        cell.selectionStyle = .none
        cell.textLabel?.text = tests.object(at: indexPath.row) as? String
        cell.delegate = self
        
        return cell
    }
    
    
    func createLeftButtons(_ number: Int) -> [Any] {
        var result = [Any]()
        let titles: [String] = ["b1", "b2", "b3"]
        let colors: [UIColor] = [UIColor.green, UIColor(red: 0, green: 0x99 / 255.0, blue: 0xcc / 255.0, alpha: 1.0), UIColor(red: 0.59, green: 0.29, blue: 0.08, alpha: 1.0)]
        for i in 0..<number {
            
            let button:MGSwipeButton = MGSwipeButton(title: titles[i], backgroundColor: colors[i], padding: 15, callback: { (_ sender) -> Bool in
                return true
            })
            result.append(button)
        }
        return result
    }
    
    func createRightButtons(_ number: Int) -> [Any] {
        var result = [Any]()
        let titles: [String] = ["Delete", "More"]
        let colors: [UIColor] = [UIColor.green, UIColor.orange]
        for i in 0..<number {
//            let button:MGSwipeButton = MGSwipeButton(title: titles[i], backgroundColor: colors[i], callback: {(_ sender: MGSwipeTableCell) -> Bool in
//                let autoHide: Bool = i != 0
//                return autoHide
//                //Don't autohide in delete button to improve delete expansion animation
//            } as! MGSwipeButtonCallback)
//            result.append(button)
            
            let button:MGSwipeButton = MGSwipeButton(title: titles[i], backgroundColor: colors[i], padding: 15, callback: { (_ sender) -> Bool in
                let autoHide: Bool = i != 0
                return autoHide
            })
            result.append(button)
            
        }
        return result
    }
    
    func swipeTableCell(_ cell: MGSwipeTableCell!, swipeButtonsFor direction: MGSwipeDirection, swipeSettings: MGSwipeSettings!, expansionSettings: MGSwipeExpansionSettings!) -> [Any]! {
        
        swipeSettings.transition = .drag
        
        //Button display here...
        if (direction == .leftToRight)
        {
            return createLeftButtons(3);
        }
        else
        {
            return createRightButtons(2);
        }
        
    }
}

