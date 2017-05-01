//
//  FirstViewController.swift
//  Lab2
//
//  Created by Oleg Pyatko on 2/22/17.
//  Copyright © 2017 Oleg Pyatko. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet var gameTableView: UITableView!
    var gameSource = [GameModel]();
    var choosenGame : GameModel? = nil;
    func loadSource()
    {
        let path = Bundle.main.path(forResource: "gamesList", ofType: "json");
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        tabBarController?.navigationItem.title = "Games";
        
        loadSource();
        
        self.gameTableView.delegate = self;
        self.gameTableView.dataSource = self;
       // self.gameTableView.register(GameTableViewCell.self, forCellReuseIdentifier: "GameTableViewCell")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fromCellToFullDescription"){
            let destVC = segue.destination as! FullDescriptionGameViewController;
            let index = gameTableView.indexPathForSelectedRow?.row;
            destVC.game = gameSource[index!];
        }
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameSource.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let element = gameSource[indexPath.row];
        
        let cellIdentifier = "GameTableViewCell";
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? GamesTableViewCell
            else{
                exit(1);
        }
        cell.gameNameLabel.text = element.Title;
        cell.gameDescriptionLabel.text = element.ShortDescription;
        cell.previewImage.image = element.Image;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let index = tableView.indexPathForSelectedRow?.row;
        //choosenGame = gameSource[indexPath.row];
    }

}
/*
extension FirstViewController : UITableViewDataSource, UITableViewDelegate{
    

    
   override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameSource.count;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "GameTableViewCell";
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as?       GameTableViewCell else{
            exit(1);
        }
        let game = gameSource[indexPath.row];
        //    cell.gameNameLabel.text = game.Title;
        //  cell.shotDescriptionLabel.text = game.ShortDescription;
        
        return cell
    }
}*/

