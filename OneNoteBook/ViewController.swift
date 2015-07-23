//
//  ViewController.swift
//  OneNoteBook
//
//  Created by shinobu okano on 2015/07/23.
//  Copyright © 2015年 shinobu okano. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    let defaultText = "test"
    
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fm = NSFileManager.defaultManager()
        let note = getNotePath()
        if fm.fileExistsAtPath(note) {
            let noteText = try! NSString(contentsOfFile: note, encoding: NSUTF8StringEncoding)
            label.text = noteText as String
            text.text = noteText as String
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: AnyObject) {
        let inputText :String = text.text!
        do{
            try inputText.writeToFile(getNotePath(), atomically: true, encoding: NSUTF8StringEncoding)
            label.text = inputText as String
            let alertController = UIAlertController(title: "保存", message: "保存しました", preferredStyle: .Alert)
            let otherAction = UIAlertAction(title: "OK", style: .Default) {
                action in NSLog("OKボタンが押されました")
            }
            alertController.addAction(otherAction)
            presentViewController(alertController, animated: true, completion: nil)
        } catch {
            NSLog("catch")
        }
    }
    
    @IBAction func deleteNote(sender: AnyObject) {
        let fm = NSFileManager.defaultManager()
        do{
            try fm.removeItemAtPath(getNotePath())
            label.text = defaultText
            text.text = ""
            let alertController = UIAlertController(title: "削除", message: "削除しました", preferredStyle: .Alert)
            let otherAction = UIAlertAction(title: "OK", style: .Default) {
                action in NSLog("OKボタンが押されました")
            }
            alertController.addAction(otherAction)
            presentViewController(alertController, animated: true, completion: nil)
        } catch {
            NSLog("catch")
        }
    }
    
    func getNotePath() -> String {
        return NSTemporaryDirectory() + "/" + "note.txt"
    }
}

