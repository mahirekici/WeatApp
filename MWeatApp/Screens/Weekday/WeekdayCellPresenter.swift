

import Foundation
import WeatNetwork

protocol WeekdayCellPresenterDelegate {
    func setupCell(imageIcon: String, temperature: String, date: String)
}

final class WeekdayCellPresenter {
    private let weatherData: WeatherDataModel
    
    init(model: WeatherDataModel) {
        self.weatherData = model
    }
    
    func attachView(_ view: WeekdayCellPresenterDelegate) {
        let imageIcon = weatherData.weatherStateAbbr
        
        let format  =  "%.1fºC "
        let temperature = (String(format:format, weatherData.theTemp))
        let date = weatherData.applicableDate.string(format: .short)
        
        view.setupCell(
            imageIcon: imageIcon,
            temperature: temperature,
            date: date)
    }
}
