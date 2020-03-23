//
//  LoginController.swift
//  AirportFinder
//
//  Created by André Escajeda Ríos on 22/03/20.
//  Copyright © 2020 André Escajeda Ríos. All rights reserved.
//

import MapKit
import TransitionButton
import UIKit

class MainController: UIViewController, CLLocationManagerDelegate {
    
    var airports: [Airport] = []
    var locationManager = CLLocationManager()
    var coordinates = CLLocationCoordinate2D()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 68)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 48)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let sliderLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 68)
        label.textAlignment = .center
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        slider.isContinuous = true
        slider.maximumValue = 100
        slider.minimumValue = 1
        slider.tintColor = .blue
        slider.maximumTrackTintColor = .white
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.value = 60
        
        return slider
    }()
    
    let radiusInKmLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.text = "RADIUS IN KM"
        label.textAlignment = .center
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let button: TransitionButton = {
        let button = TransitionButton()
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        button.backgroundColor = .darkBlue
        button.cornerRadius = 26
        button.setTitle("SEARCH", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.spinnerColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        let strokeTextAttributes: [NSAttributedString.Key : Any] = [.strokeColor: UIColor.gray, .foregroundColor: UIColor.white, .strokeWidth: -0.5]

        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.topAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 60, paddingRight: 15, paddingBottom: 0, paddingLeft: 15, width: 0, height: 0)
        titleLabel.attributedText = NSAttributedString(string: "AIRPORT", attributes: strokeTextAttributes)
        
        view.addSubview(subtitleLabel)
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: -15, paddingRight: 15, paddingBottom: 0, paddingLeft: 15, width: 0, height: 0)
        subtitleLabel.attributedText = NSAttributedString(string: "finder", attributes: strokeTextAttributes)
        
        sliderLabel.text = "\(Int(slider.value))"
        
        let stackView = UIStackView(arrangedSubviews: [sliderLabel, slider, radiusInKmLabel])
        stackView.axis = .vertical
        stackView.spacing = 9
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        stackView.anchor(top: nil, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 0, paddingRight: 15, paddingBottom: 0, paddingLeft: 15, width: 0, height: 0)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
                case 1792, 2436, 2688:
                    let bottomSafeAreaInsetView = UIView()
                    bottomSafeAreaInsetView.backgroundColor = .background
                    
                    view.addSubview(bottomSafeAreaInsetView)
                    bottomSafeAreaInsetView.anchor(top: nil, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom)!)
                    
                    view.addSubview(button)
                    button.anchor(top: nil, right: view.rightAnchor, bottom: bottomSafeAreaInsetView.topAnchor, left: view.leftAnchor, paddingTop: 0, paddingRight: 15, paddingBottom: 15, paddingLeft: 15, width: 0, height: 52)
                default:
                    view.addSubview(button)
                    button.anchor(top: nil, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, paddingTop: 0, paddingRight: 15, paddingBottom: 15, paddingLeft: 15, width: 0, height: 52)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        coordinates = manager.location!.coordinate as CLLocationCoordinate2D
    }
    
    @objc func handleButton() {
        button.startAnimation()
        
        guard let url = URL(string: "https://cometari-airportsfinder-v1.p.rapidapi.com/api/airports/by-radius?radius=\(Int(slider.value))&lng=\(coordinates.longitude)&lat=\(coordinates.latitude)") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("cometari-airportsfinder-v1.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        urlRequest.addValue("e8b6a25a3bmsh75adfa00875ec15p13f880jsn549b680da5a1", forHTTPHeaderField: "x-rapidapi-key")
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            guard let data = data, error == nil else {
                print("Failed to get data from URL. Exception: ", error ?? "Unknown error.")
                
                if error?.code == -1004 {
                    let alert = UIAlertController(title: "Servicio no disponible", message: "Error al establecer la conexión con el servidor. Intente de nuevo más tarde.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                } else if error?.code == -1009 {
                    let alert = UIAlertController(title: "Sin conexión a internet", message: "Verifique que se encuentre conectado a Internet.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
                
                dispatchGroup.leave()
                
                return
            }
            
            do {
                self.airports = try JSONDecoder().decode(Array<Airport>.self, from: data)
                
                dispatchGroup.leave()
            } catch {
                print("Failed to decode. Exception: \(error)")
            }
        }.resume()
        
        dispatchGroup.wait()
        
        self.button.stopAnimation(animationStyle: .expand, revertAfterDelay: 0) {
            let tabBarController = TabBarController(nil, nil, self.airports)
            
            if self.airports.count > 0 {
                self.present(tabBarController, animated: true)
            } else {
                let alert = UIAlertController(title: "Sin coincidencias", message: "\(self.airports.count)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "No hemos encontrado aeropuertos alrededor. Reintenta ampliando el radio de búsqueda.", style: .cancel, handler: nil))
                
                self.present(alert, animated: true)
            }
        }
    }
    
    @objc func handleSlider() {
        sliderLabel.text = "\(Int(slider.value))"
    }
}
