//
//  GameFullDescriptionViewController.swift
//  Lab2
//
//  Created by Oleg Pyatko on 3/22/17.
//  Copyright © 2017 Oleg Pyatko. All rights reserved.
//

import UIKit

class GameFullDescriptionViewController: UIViewController {

    var game : GameModel?;
    
    func backButtonAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
     /*   if let nav = self.navigationController,
            let item = self.navigationBar.topItem{
            item.backBarButtonItem = UIBarButtonItem(title: "back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.backButtonAction));
        }*/
        
        // Do any additional setup after loading the view.
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
