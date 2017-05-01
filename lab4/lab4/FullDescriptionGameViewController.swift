//
//  FullDescriptionGameViewController.swift
//  Lab2
//
//  Created by Oleg Pyatko on 4/5/17.
//  Copyright © 2017 Oleg Pyatko. All rights reserved.
//

import UIKit

class FullDescriptionGameViewController: UIViewController {

    var game : GameModel?;
    
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProperties();
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var image: UIImageView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var descriptionTextField: UITextView!
    
    func setUpProperties(){
        nameLabel.text = game?.Title;
        image.image = game?.Image;
        descriptionTextField.text = game?.FullDescription;
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
