//
//  MapViewController.swift
//  lab4
//
//  Created by Evgeni' Roslik on 5/2/17.
//  Copyright © 2017 bsuir. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class MapViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    let regionRadius : CLLocationDistance = 1000000;
    var cities : [WheatherModel]!;
    let annotaion = MKPointAnnotation();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCities();
        //createAnnotations();
        mapView.delegate = self;
        
        let gr = UILongPressGestureRecognizer(target : self, action : #selector(self.tapOnMap(sender:)));
        gr.minimumPressDuration = 0.2;
        //gr.delaysTouchesBegan = true;
        //gr.delegate = self;
        mapView.addGestureRecognizer(gr);
        let initialLocation = CLLocation(latitude: 39, longitude: -77)
        centerMapOnLocation(location: initialLocation);
        // Do any additional setup after loading the view.
    }
    func tapOnMap(sender: UILongPressGestureRecognizer){
        if sender.state == UIGestureRecognizerState.ended{
            let touchLocation = sender.location(in: mapView);
            let coordinate = mapView.convert(touchLocation,toCoordinateFrom: mapView);
            let nearest = getNearestPoint(coordinate: coordinate);
            let message = nearest.city + " latitude: " + String(nearest.latitude) + " longitude: " + String(nearest.longitude);
            print(message);
            performRequest(city: nearest.city){
                response in
                let wheather = response;
                let respMessage = "response is " + response.city + " latitude: " + String(response.latitude) + " longitude:" + String(response.longitude);
                print(respMessage);
                //let allAnnotations = self.mapView.annotations;
                //self.mapView.removeAnnotations(allAnnotations);
                //annotaion = MKPointAnnotation();
                self.annotaion.coordinate = CLLocationCoordinate2D(latitude: wheather.latitude, longitude: wheather.longitude);
                self.annotaion.title = wheather.city;
                self.annotaion.subtitle = "Current temp is: " + String(wheather.temp) + "C";
                self.mapView.addAnnotation(self.annotaion);
                self.mapView.selectAnnotation(self.annotaion, animated: true);
            }
        }
    }
    
    func performRequest(city : String, completionHandler : ((WheatherModel)->Void)?){
        let request = "https://api.apixu.com/v1/current.json?key=152f26ba579c4fb5ba3204721170504&q=" + city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!;
        print(request);
        //let newUrl = request.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed);
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
    
    func getNearestPoint(coordinate : CLLocationCoordinate2D) -> WheatherModel{
        var minIndex = 0;
        var coordinateCity = CLLocationCoordinate2D();
        coordinateCity.latitude = cities[minIndex].latitude;
        coordinateCity.longitude = cities[minIndex].longitude;
        var minDistance = getDistance(coord1: coordinate, coord2: coordinateCity);
        for i in 1 ..< cities.count {
            coordinateCity.latitude = cities[i].latitude;
            coordinateCity.longitude = cities[i].longitude;
            let distance = getDistance(coord1: coordinate, coord2: coordinateCity);
            if distance < minDistance{
                minDistance = distance;
                minIndex = i;
            }
        }
        
        return cities[minIndex];
    }
    
    func getDistance(coord1 : CLLocationCoordinate2D, coord2 : CLLocationCoordinate2D) -> Double{
        let dx = sqr(x: coord1.latitude - coord2.latitude);
        let dy = sqr(x: coord1.longitude - coord2.longitude);
        let dist = sqrt(dx + dy);
        //print(dist);
        return dist;
    }
    
    func sqr(x : Double)-> Double{
        return x * x;
    }
    
    func createAnnotations(){
        for city in cities{
            let annotaion = MKPointAnnotation();
            annotaion.coordinate = CLLocationCoordinate2D(latitude: city.latitude, longitude: city.longitude);
            annotaion.title = city.city;
            mapView.addAnnotation(annotaion);
        }
    }
    
    func loadCities(){
        let path = Bundle.main.path(forResource: "cities", ofType: "json");
        do{
            let data = try String(contentsOfFile: path!);
            cities = JSONSerializer().deserializeArrayOfCities(source: data);
        }
        catch{}
    }
    
    func centerMapOnLocation(location : CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0);
        mapView.setRegion(coordinateRegion, animated: true);
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
