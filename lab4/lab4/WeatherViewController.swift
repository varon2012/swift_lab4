//
//  WeatherViewController.swift
//  Lab2
//
//  Created by Oleg Pyatko on 4/5/17.
//  Copyright © 2017 Oleg Pyatko. All rights reserved.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var weatherTableView: UITableView!
    let cities = ["London", "Minsk", "Moscow"];
    var weathers = [Weather]();
    func download(){
        for city in cities{
            weathers += [Weather(city: city)];
        }
        DispatchQueue.global(qos : .utility).async {
            for weather in self.weathers{
                self.performRequest(weather: weather);
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5)       {
                self.weatherTableView.delegate = self;
                self.weatherTableView.dataSource = self;
                self.weatherTableView.reloadData();
            }
        }

    }
    
    func performRequest(weather : Weather){
        Alamofire.request(weather.url).responseString(completionHandler: {
            response in
            let result = response.result.value;
            let temp = WeatherDeserializer().Deserialize(source: result!);
            
            weather.temp = temp;
        })
    }
    
    //override func viewWillAppear(_ animated: Bool) {
        //ownload();
    //}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        tabBarController?.navigationItem.title = "Weather";
        download();
        
        //weatherTableView.delegate = self;
        //weatherTableView.dataSource = self;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let weather = weathers[indexPath.row];

        let cellIdentifier = "WeatherCell";
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? WeatherTableViewCell
            else{
                exit(1);
        }
        cell.cityLabel.text = weather.city;
        cell.weatherLabel.text = weather.temp + "C";
        return cell;
        //let weather =
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
