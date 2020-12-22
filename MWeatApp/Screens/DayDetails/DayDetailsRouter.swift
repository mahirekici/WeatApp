

import UIKit
import WeatNetwork


final class DayDetailsRouter: Routerable {
    private var navigation: UINavigationController
    private var weatherData: WeatherDataModel
    private var search: WeatherSearchCityModel
    
    init(navigation: UINavigationController, weatherData: WeatherDataModel, search: WeatherSearchCityModel) {
        self.navigation = navigation
        self.weatherData = weatherData
        self.search = search
    }
    
    func makeViewController() -> UIViewController {
        let presenter = DayDetailsPresenter(weatherData: weatherData, search: search)
        let viewController = DayDetailsViewController(presenter: presenter)
        return viewController
    }
}
