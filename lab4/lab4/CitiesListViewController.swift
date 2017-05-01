//
//  CitiesListViewController.swift
//  lab4
//
//  Created by Evgeni' Roslik on 5/2/17.
//  Copyright © 2017 bsuir. All rights reserved.
//

import UIKit
import Alamofire

class CitiesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cities = ["Minsk", "Moscow", "London", "Berlin", "Rome", "Paris"];
    
    @IBOutlet weak var citiesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        citiesTableView.delegate = self;
        citiesTableView.dataSource = self;
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = cities[indexPath.row];
        
        let cellIdentifier = "CityCellIdentifier";
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CityNameTableViewCell;
        cell.cityNameLabel.text = element;
        
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fromCitiesListToMap")
        {
            let destVC = segue.destination as! CityMapViewController;
            
            let index = citiesTableView.indexPathForSelectedRow?.row;
            destVC.city = cities[index!];
            //performRequest(city: cities[index!]){
            //   response in
            //   destVC.wheather = response;
            //}
        }
    }
    
    func performRequest(city : String, completionHandler : ((WheatherModel)->Void)?){
        let request = "https://api.apixu.com/v1/current.json?key=152f26ba579c4fb5ba3204721170504&q=" + city;
        let url = URL(string : request);
        self.requestAlamofire(url : url!, completionHandler: completionHandler);
    }
    
    func requestAlamofire(url : URL, completionHandler : ((WheatherModel)->Void)?){
        
        Alamofire.request(url).responseString(completionHandler: {
            response in
            let result = response.result.value;
            let wheather = JSONSerializer().deserialize(source: result!);
            completionHandler!(wheather);
        })
    }
}

