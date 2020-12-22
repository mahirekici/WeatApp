

import UIKit

public struct WeatherSearchCityModel: Codable {
    public  let consolidatedWeather: [WeatherDataModel]?
    public let title: String
    public let woeid: Int
    public let lattLong: String
}

public struct WeatherDataModel: Codable {
    public let weatherStateAbbr: String
    public let applicableDate: Date
    public let theTemp: Double
    public let minTemp: Double
    public let maxTemp: Double
    public let windSpeed: Double
    public let humidity: Int
    public let predictability: Int
}

public protocol WeekdayDataServiceDelegate: AnyObject {
    func didUpdateWeather(_ weatherData: [WeatherDataModel])
    func didFail(error:Error)
}

public protocol SearchServiceDelegate: AnyObject {
    func didFindCities(_ cities: [WeatherSearchCityModel])
    func didFail(error:Error)
}
