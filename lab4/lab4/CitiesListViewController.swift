//
//  CitiesListViewController.swift
//  lab4
//
//  Created by Evgeni' Roslik on 5/2/17.
//  Copyright © 2017 bsuir. All rights reserved.
//

import UIKit
import Alamofire
import MapKit

class CitiesListViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let cities = ["Minsk", "Moscow", "London", "Berlin", "Rome", "Paris"];
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var citiesTableView: UITableView!
    
    var wheather : WheatherModel!;
    let regionRadius : CLLocationDistance = 10000;
    
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
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (UIDevice.current.orientation.isPortrait){
            return true;
        }
        else{
            let index = citiesTableView.indexPathForSelectedRow?.row;
            let city = cities[index!];
            showOnMap(city: city);
            return false;
        }
    }
    
    func showOnMap(city : String){
        performRequest(city: city){
            response in
            self.wheather = response;
            let initialLocation = CLLocation(latitude: self.wheather.latitude, longitude: self.wheather.longitude);
            self.centerMapOnLocation(location: initialLocation);
            let annotation = MKPointAnnotation();
            annotation.title = self.wheather.city;
            annotation.subtitle = "Current wheather is: " + String(self.wheather.temp) + " C";
            annotation.coordinate = CLLocationCoordinate2D(latitude: self.wheather.latitude, longitude: self.wheather.longitude);
            self.mapView.delegate = self;
            self.mapView.addAnnotation(annotation);
            self.mapView.selectAnnotation(annotation, animated: true);
        }
    }
    
    func centerMapOnLocation(location : CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0);
        mapView.setRegion(coordinateRegion, animated: true);
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

