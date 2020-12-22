
import MapKit
import WeatNetwork

protocol DayDetailsPresenterDelegate {
    func setupIcon(iconImage: String)
    func setupDate(date: String)
    func setupCityName(city: String)
    func setupRain(rain: String)
    func setupWind(wind: String)
    func setupHumidity(humidity: String)
    func setupTempLabel(actualTemp: String, maxTemp: String, minTemp: String)
    func addCityPinToMap(latitude: Double, longitude: Double, city: String)
}

final class DayDetailsPresenter {
    
    private var view: DayDetailsPresenterDelegate?
    private let weatherData: WeatherDataModel
    private let search: WeatherSearchCityModel
    
    init(
        weatherData: WeatherDataModel,
        search: WeatherSearchCityModel
        
    ) {
        self.weatherData = weatherData
        self.search = search
    }
    
    func attachView(_ view: DayDetailsPresenterDelegate) {
        self.view = view
        setupTemp()
        setupIconAndLabels()
        setupDetails()
    }
    
    private func setupIconAndLabels() {
        view?.setupIcon(iconImage: weatherData.weatherStateAbbr)
        view?.setupCityName(city: search.title)
        view?.setupDate(date: weatherData.applicableDate.string(format: .long))
    }
    
    private func setupTemp() {
        let actualTemp = (String(format: "%.0fºC", weatherData.theTemp))
        let maxTemp = (String(format: "%.0fºC ", weatherData.maxTemp))
        let minTemp = (String(format: "%.0fºC ", weatherData.minTemp))
        
        view?.setupTempLabel(actualTemp: actualTemp, maxTemp: maxTemp, minTemp: minTemp)
    }
    
    private func setupDetails() {
        view?.setupRain(rain: String("\(weatherData.predictability)%"))
        view?.setupWind(wind: String(format: "%.0f km/h ", weatherData.windSpeed))
        view?.setupHumidity(humidity: String("\(weatherData.humidity)%"))
    }
    
    func formattedCoordinates() -> CLLocation {
        let coordinates = search.lattLong
        let coordinatesArray = coordinates.components(separatedBy: ",")
        
        guard coordinatesArray.count == 2,
            let latitude = Double(coordinatesArray[0]),
            let longitude = Double(coordinatesArray[1])
            else { return .init(
                latitude: 30,
                longitude: 70
                )
        }
        
        return CLLocation(
            latitude: latitude,
            longitude: longitude
        )
    }
    
    func didCenterToLocation() {
        view?.addCityPinToMap(
            latitude: formattedCoordinates().coordinate.latitude,
            longitude: formattedCoordinates().coordinate.longitude,
            city: search.title
        )
    }
}
