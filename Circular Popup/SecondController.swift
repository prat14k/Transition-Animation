//
//  SecondController.swift
//  Circular Popup
//
//  Created by DEN on 05/08/17.
//  Copyright © 2017 14K. All rights reserved.
//

import UIKit

class SecondController: UIViewController {

    @IBOutlet weak var closeBtn: UIButton!
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        closeBtn.layer.cornerRadius = closeBtn.frame.size.width/2.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
