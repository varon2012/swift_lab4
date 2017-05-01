//
//  GamesListTableViewController.swift
//  Lab2
//
//  Created by Oleg Pyatko on 4/5/17.
//  Copyright © 2017 Oleg Pyatko. All rights reserved.
//

import UIKit

class GamesListTableViewController: UITableViewController {

    var gameSource = [GameModel]();
    var choosenGame : GameModel? = nil;
    func loadSource()
    {
        let path = Bundle.main.path(forResource: "games", ofType: "json");
        do {
            let data = try String(contentsOfFile: path!)
            let array = GameJSONSerializer().Deserialize(source: data);
            gameSource = array;
        }
        catch
        {
        }
        
        // let first = GameModel(title: "GTA 5", shortDescription: "game", fullDescription: "full", image: UIImage(named : "game1")!);
        //gameSource += [first];
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fromListToFullDescription"){
            let destVC = segue.destination as! FullDescriptionGameViewController;
            destVC.game = choosenGame;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSource();	
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gameSource.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = gameSource[indexPath.row];
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell", for: indexPath) as! GameTableViewCell;

        // Configure the cell...
        cell.gameNameLabel.text = element.Title;
        cell.shortDescriptionLabel.text = element.ShortDescription;
        cell.previewImage.image = element.Image;
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosenGame = gameSource[(tableView.indexPathForSelectedRow?.row)!];
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
