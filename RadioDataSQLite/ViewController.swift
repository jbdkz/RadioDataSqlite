//
//  ViewController.swift
//  RadioDataSQLite
//
//  Created by John Diczhazy on 7/4/17.
//  Copyright © 2017 JohnDiczhazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var lineROW: UILabel!
   
    @IBOutlet weak var lineMake: UITextField!
   
    @IBOutlet weak var lineModel: UITextField!
    
    @IBOutlet weak var lineSerialNO: UITextField!
    
    @IBOutlet weak var lineStatus: UILabel!
    
    @IBAction func createRecord(_ sender: Any) {
        self.lineStatus.text = ""
        if validate() == true {
        self.lineStatus.text = DBAccess.createRecord(make: (lineMake.text)!, model: (lineModel.text)!, serialNO:(lineSerialNO.text)!)
        }
    }
    
    @IBAction func readRecord(_ sender: Any) {
        let arrayOutput: [String]
        arrayOutput = DBAccess.readRecord(model: lineModel.text!) 
        
        lineROW.text = arrayOutput[0]
        lineMake.text = arrayOutput[1]
        lineModel.text = arrayOutput[2]
        lineSerialNO.text = arrayOutput[3]
        lineStatus.text = arrayOutput[4]
    }
    
    @IBAction func updateRecord(_ sender: Any) {
        self.lineStatus.text = ""
        if validate() == true {
        self.lineStatus.text = DBAccess.updateRecord(row: Int32(lineROW.text!)!,make: (lineMake.text)!, model: (lineModel.text)!, serialNO:(lineSerialNO.text)!)
       }
    }
    
    @IBAction func deleteRecord(_ sender: Any) {
        let uiAlert = UIAlertController(title: "Delete", message: "Confirm Delete Action", preferredStyle: UIAlertControllerStyle.alert)
        self.present(uiAlert, animated: true, completion: nil)
        
        uiAlert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { action in
            print("Click of default button")
            self.lineStatus.text = DBAccess.deleteRecord(row: Int32(self.lineROW.text!)!)
            if self.lineStatus.text == "Record Deleted"{
              self.lineROW.text = ""
              self.lineMake.text = ""
              self.lineModel.text = ""
              self.lineSerialNO.text = ""
            }
            
        }))
        
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            print("Click of cancel button")
        }))
    }

    override func viewDidLoad() {
        DBAccess.initDB()
        super.viewDidLoad()
        self.lineMake.becomeFirstResponder()
    }

    func validate() ->Bool {
        lineStatus.text = ""
        
        if (lineMake.text?.isEmpty)! {
            lineStatus.text = "Value in Make field is required!"
            self.lineMake.becomeFirstResponder()
            return false
        } else if (lineModel.text?.isEmpty)! {
            lineStatus.text = "Value in Model field is required!"
            self.lineModel.becomeFirstResponder()
            return false
        } else if (lineSerialNO.text?.isEmpty)!{
            lineStatus.text = "Value in SerialNO field is required!"
            self.lineSerialNO.becomeFirstResponder()
            return false
        } else {
            self.lineMake.becomeFirstResponder()
            return true
        }
    }
}
