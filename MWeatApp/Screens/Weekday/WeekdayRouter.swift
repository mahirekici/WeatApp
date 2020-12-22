
import UIKit
import WeatNetwork


protocol WeekdayRouterProtocol: AnyObject {
    func navigateToDatailsScene(weatherData: WeatherDataModel)
}

final class WeekdayRouter: Routerable {
    private var navigation: UINavigationController
    private var search: WeatherSearchCityModel
    
    init(navigation: UINavigationController, search: WeatherSearchCityModel) {
        self.navigation = navigation
        self.search = search
    }
    
    func makeViewController() -> UIViewController {
        let presenter = WeekdayPresenter(search: search, router: self)
        let viewController = WeekdayViewController(presenter: presenter)
        return viewController
    }
}

extension WeekdayRouter: WeekdayRouterProtocol {
    func navigateToDatailsScene(weatherData: WeatherDataModel) {
        let router = DayDetailsRouter(navigation: navigation, weatherData: weatherData, search: search)
        let vc = router.makeViewController()
        navigation.pushViewController(vc, animated: true)
    }
}
