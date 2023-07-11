//
//  MapView.swift
//  AdvanceMapKitTutorial
//
//  Created by recherst on 2021/9/7.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @EnvironmentObject var mapData: MapViewModel

    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator()
    }
    func makeUIView(context: Context) -> MKMapView {
        let view = mapData.mapView
        view.showsUserLocation = true
        view.delegate = context.coordinator
        return view
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {

    }
    class CustomAnnotationView: MKAnnotationView {
        override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
            super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
            self.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            self.addSubview(Circle()
                .frame(width: 10, height: 10)
                .foregroundColor(.red) as! UIView
            )
            self.canShowCallout = true
            self.addDropAnimation()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func addDropAnimation() {
            let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
            animation.values = [0, 10, -10, 5, -5, 0]
            animation.keyTimes = [0, 0.25, 0.5, 0.75, 0.9, 1]
            animation.duration = 0.5
            self.layer.add(animation, forKey: "dropAnimation")
        }
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            } else {
                let annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: "customAnnotation")
                return annotationView
            }
        }
    }
}
