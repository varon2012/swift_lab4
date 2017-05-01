//
//  CityMapViewController.swift
//  lab3
//
//  Created by Oleg Pyatko on 4/18/17.
//  Copyright © 2017 Oleg Pyatko. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class CityMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var wheather : WheatherModel!;
    let regionRadius : CLLocationDistance = 10000;
    var city : String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
