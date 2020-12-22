
import CoreLocation
import WeatNetwork

protocol HomePresenterDelegate {
    func showAlert(message: String, buttonTitle: String, title: String)
    func showLoading()
    func hideLoading()
    func reloadData()
}

final class HomePresenter: NSObject {
    var dataSource: [WeatherSearchCityModel] = []
    private var view: HomePresenterDelegate?
    private var service: SearchNetworkServiceProtocol
    private let locationManager  = CLLocationManager()
    private var router: HomeRouterProtocol
    
    init(
        service: SearchNetworkServiceProtocol = SearchNetworkService(),
        router: HomeRouterProtocol
    ) {
        self.service = service
        self.router = router
        super.init()
        
        self.service.delegate = self
    }
    
    func attachView(_ view: HomePresenterDelegate) {
        self.view = view
        setupLocationManager()
    }
    
    func inputTextDidChange(_ text: String) {
        let characterCount  = text.count
        if characterCount  > 2 {
            let inputText = text
            service.citySearch(query: inputText)
        } else {
            clearTableView()
        }
    }
    
    func tryAgainButtonDidTap() {
        clearTableView()
       
        startLocationService()
    }
    
    func rowDidTap(_ row: Int) {
        let model = dataSource[row]
        router.navigateToWeekScene(model: model)
    }
    
    private func clearTableView() {
        dataSource.removeAll()
        view?.reloadData()
    }
    
    private func setupLocationManager() {
         locationManager.delegate = self
         locationManager.desiredAccuracy = kCLLocationAccuracyBest
         locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
         startLocationService()
        
    }
    private func startLocationService(){
        // Check authorization for location tracking

        if CLLocationManager.authorizationStatus() != .authorizedAlways
        {
            locationManager.requestAlwaysAuthorization()
            // LocationManager will callbackdidChange... once user responds
        } else {
            locationManager.startUpdatingLocation()
        }

    }
}



// MARK: Service Output

extension HomePresenter: SearchServiceDelegate {
    
    func didFindCities(_ cities: [WeatherSearchCityModel]) {
        dataSource = cities
        
        view?.hideLoading()
        view?.reloadData()
    }
    
    func didFail(error: Error) {
        view?.hideLoading()
        
        print(error)
        
        let message  = localizable.inAppError.generic.localized
        let buttonTitle  = localizable.inAppError.button.localized
        let title  = localizable.inAppError.title.localized
        
        view?.showAlert(
            message: message,
            buttonTitle: buttonTitle,
            title: title
        )
    }
}

// MARK: CoreLocation Output

extension HomePresenter: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            let lattlong = "\(lat),\(lon)"
            service.citySearch(query: lattlong)
            view?.showLoading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        view?.showAlert(
            message: localizable.inAppError.generic.localized,
            buttonTitle: localizable.inAppError.button.localized,
            title: localizable.inAppError.title.localized
        )
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("")
    }
    
    
    // called when the authorization status is changed for the core location permission
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
                    case .notDetermined:
                        print("notDetermined")
                        manager.requestWhenInUseAuthorization()
                    case .restricted:
                        print("restricted")
                        // Inform user about the restriction
                        break
                    case .denied:
                        print("deined")
                        // The user denied the use of location services for the app or they are disabled globally in Settings.
                        // Direct them to re-enable this.
                        break
                    case .authorizedAlways, .authorizedWhenInUse:
                        print("authorized")
//                        manager.requestLocation()
                        locationManager.startUpdatingLocation()

                    }
        }
}
