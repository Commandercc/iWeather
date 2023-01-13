//
//  WTLocation.swift
//  iweather
//
//  Created by zhengxu on 2023/1/13.
//

import Foundation

final class WTLocation: Codable {
    var id: String = "" // 地点唯一标识
    var location: Coordinate = Coordinate(latitude: 0, longitude: 0)
    var name: String = "" // 地点名称
    var address: String = "" // 地点详细地址
    var city: String = "" // 地点所在城市
    var district: String = "" // 地点所在区县
    var town: String = "" // 地点所在街道
    var street: String = "" // 地点坐在路
    
    init(id: String = "", location: Coordinate = Coordinate(latitude: 0.0, longitude: 0.0), name: String = "", address: String = "", city: String = "", district: String = "", town: String = "", street: String = "") {
        self.id = id
        self.location = location
        self.name = name
        self.address = address
        self.city = city
        self.district = district
        self.town = town
        self.street = street
    }
}

struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double
}

extension CLLocationCoordinate2D {
    init(_ coordinate: Coordinate) {
        self = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

extension Coordinate {
    init(_ coordinate: CLLocationCoordinate2D) {
        self = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}
