import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {

  //final _controller = MapController();

  final Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController? newGoogleMapController;

  static const CameraPosition _mapPosition = const CameraPosition(
      //bearing: 192.8334901395799,
      target: LatLng(-16.505830,-68.130170),
      tilt: 59.440717697143555,
      zoom: 18.151926040649414

  );

  blackThemeGoogleMap() {
    newGoogleMapController!.setMapStyle('''
                    [
    {
        "featureType": "all",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "color": "#ffffff"
            }
        ]
    },
    {
        "featureType": "all",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "color": "#3e606f"
            },
            {
                "weight": 2
            },
            {
                "gamma": 0.84
            }
        ]
    },
    {
        "featureType": "all",
        "elementType": "labels.icon",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "geometry",
        "stylers": [
            {
                "weight": 0.6
            },
            {
                "color": "#12538d"
            }
        ]
    },
    {
        "featureType": "landscape",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#10437b"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#406d80"
            }
        ]
    },
    {
        "featureType": "poi.park",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#008141"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#2196d0"
            },
            {
                "lightness": -37
            }
        ]
    },
    {
        "featureType": "transit",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#136cad"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#00328f"
            }
        ]
    }
]
                ''');
  }
  @override
  Widget build(BuildContext context) {
    return
      Stack(
        children:[
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _mapPosition,
            onMapCreated: (GoogleMapController controller){
              _mapController.complete(controller);
              newGoogleMapController = controller;
              blackThemeGoogleMap();
            },
          onTap:(positionTap){
            print('Posicion Tap $positionTap');
          },
          onLongPress:(positionTap){
      print('Posicion Long $positionTap');
    },
          ),
        ],
    );
  }
}
