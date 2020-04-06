import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final covidFeaturesEu = await locations.getCovidDataEu();
    setState(() {
      _markers.clear();
      for (final feature in covidFeaturesEu.features) {
        if (feature.properties.latitude == "" ||
            feature.properties.longitude == "") {
          continue;
        }
        final marker = Marker(
          markerId: MarkerId(feature.properties.name),
          position: LatLng(double.parse(feature.properties.latitude),
              double.parse(feature.properties.longitude)),
          infoWindow: InfoWindow(
            title: feature.properties.name,
            snippet: "Deaths: ${feature.properties.deaths.toString()}\n" +
                "Confirmed: ${feature.properties.confirmed.toString()}\n",
           ),
        );
        _markers[feature.properties.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Covid 19 data'),
            backgroundColor: Colors.green[700],
          ),
          body: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: const LatLng(0, 0),
              zoom: 2,
            ),
            markers: _markers.values.toSet(),
          ),
        ),
      );
}
