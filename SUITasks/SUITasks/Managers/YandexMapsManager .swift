//
//  YandexMapsManager .swift
//  SUITasks
//
//  Created by user on 25.06.2024.
//

import YandexMapsMobile
import Combine
import Sentry

final class YandexMapsManager: ObservableObject {
    let mapView: YMKMapView = YMKMapView(frame: CGRect.zero)
    
    private lazy var map: YMKMap = {
        return mapView.mapWindow.map
    }()
    
    private let locationManager = LocationManager()
    private var subs = Set<AnyCancellable>()
    private var coordinates: (latitude: Double, longitude: Double)?
    
    private var searchManager: YMKSearchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)
    private let drivingRouter: YMKDrivingRouter = YMKDirections.sharedInstance().createDrivingRouter()
    private var routesCollection: YMKMapObjectCollection?
    
    
    private let searchOptions: YMKSearchOptions = {
        let options = YMKSearchOptions()
        options.searchTypes = .biz
        options.resultPageSize = 32
        return options
    }()
    
    let drivingOptions: YMKDrivingDrivingOptions = {
        let options = YMKDrivingDrivingOptions()
        options.routesCount = 3
        return options
    }()
    
    private var searchSession: YMKSearchSession?
    private var drivingSession: YMKDrivingSession?
    private let vehicleOptions = YMKDrivingVehicleOptions()
    
    func getInitialUserLocation(){
        locationManager.currentLocation.sink { [weak self] location in
            guard let self else { return }
            coordinates = (location?.coordinate.latitude, location?.coordinate.longitude) as? (Double, Double)
            self.setCenterMapLocation(map: mapView, target: YMKPoint(latitude: coordinates!.latitude, longitude: coordinates!.longitude))
        }
        .store(in: &subs)
        
        routesCollection = map.mapObjects.add()
    }
    
    func getCurrentLocation() {
        setCenterMapLocation(map: mapView, target: YMKPoint(latitude: coordinates!.latitude, longitude: coordinates!.longitude))
    }
    
    func search(_ searchText: String) {
        searchSession = searchManager.submit(withText: searchText,
                                             geometry: YMKVisibleRegionUtils.toPolygon(with: map.visibleRegion),
                                             searchOptions: searchOptions,
                                             responseHandler: handleSearchSessionResponse)
    }
    
    private func handleSearchSessionResponse(response: YMKSearchResponse?, error: Error?) {
        if let error {
            SentrySDK.capture(error: error)
            return
        }
        
        let geoObjects = response?.collection.children.compactMap { $0.obj }
        guard let point = geoObjects?.first?.geometry.first?.point else { return }
        
        setCenterMapLocation(map: mapView, target: point)
        drivingRoute(to: point)
    }
    
    func drivingRoute(to point: YMKPoint) {
        let requestPoints = [
            YMKRequestPoint(point: YMKPoint(latitude: coordinates!.latitude, longitude: coordinates!.longitude), type: .waypoint, pointContext: nil, drivingArrivalPointId: nil),
            YMKRequestPoint(point: YMKPoint(latitude: point.latitude, longitude: point.longitude), type: .waypoint, pointContext: nil, drivingArrivalPointId: nil)
        ]
        
        drivingSession = drivingRouter.requestRoutes(
            with: requestPoints,
            drivingOptions: drivingOptions,
            vehicleOptions: vehicleOptions,
            routeHandler: drivingRouteHandler
        )
        
    }
    
    func drivingRouteHandler(drivingRoutes: [YMKDrivingRoute]?, error: Error?) {
        if let error {
            print(error.localizedDescription)
            return
        }
        
        guard let polyline = drivingRoutes?.first?.geometry else { return }
        
        drawRoute(polyline: polyline)
    }
    
    func drawRoute(polyline: YMKPolyline) {
        guard let routesCollection else {
            return
        }
        routesCollection.clear()
        let polylineMapObject = routesCollection.addPolyline(with: polyline)
        polylineMapObject.strokeWidth = 5.0
        polylineMapObject.setStrokeColorWith(.gray)
        polylineMapObject.outlineWidth = 1.0
        polylineMapObject.outlineColor = .black
    }

    private func setCenterMapLocation(map: YMKMapView, target location: YMKPoint?) {
        guard let location = location else {
            SentrySDK.capture(message: "Failed to get user current location")
            return
        }
        
        map.mapWindow.map.move(
            with: YMKCameraPosition(target: location, zoom: 18, azimuth: 0, tilt: 0),
            animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 0.5)
        )
        
        addPlacemark(map.mapWindow.map, target: location)
    }
    
    private func addPlacemark(_ map: YMKMap, target: YMKPoint) {
        let image = UIImage(named: "location")!
        
        let placemark = map.mapObjects.addPlacemark()
        placemark.geometry = target
        
        placemark.setIconWith(
            image,
            style: YMKIconStyle(
                anchor: CGPoint(x: 0.5, y: 0.5) as NSValue,
                rotationType: YMKRotationType.rotate.rawValue as NSNumber,
                zIndex: 0,
                flat: true,
                visible: true,
                scale: 1.5,
                tappableArea: nil
            )
        )
    }
}
