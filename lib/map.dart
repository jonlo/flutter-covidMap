import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;

class GmapApp extends StatefulWidget {
  const GmapApp(this.continent, this.continentKey) : super();
  final String continent;
  final String continentKey;
  @override
  _GmapAppState createState() => _GmapAppState(continentKey);
}

class _GmapAppState extends State<GmapApp> {
  _GmapAppState(this.continentKey) : super();
  final String continentKey;

  final Map<String, Marker> _markers = {};
  BuildContext mapContext;
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Container(
          child: Builder(builder: (ctx) => createGoogleMap(ctx)),
        ),
      );

  GoogleMap createGoogleMap(BuildContext ctx) {
    mapContext = ctx;
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: const LatLng(0, 0),
        zoom: 2,
      ),
      markers: _markers.values.toSet(),
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final covidFeatures = await locations.getCovidData(continentKey);

    setState(() {
      _markers.clear();
      for (final feature in covidFeatures.features) {
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
              snippet: "Deaths: ${feature.properties.deaths.toString()}",
              onTap: () {
                _showModal(mapContext, feature);
              }),
        );
        _markers[feature.properties.name] = marker;
      }
    });
  }

  void _showModal(BuildContext _context, locations.Feature feature) {
    setState(() {
      Future<void> future = showModalBottomSheet<void>(
        context: _context,
        builder: (BuildContext context) {
          return Container(
            child: Wrap(
              children: <Widget>[
                Text(
                  '${feature.properties.name}',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                ListTile(
                  leading: Icon(Icons.filter_vintage),
                  title: Text(
                      "Recovered: ${feature.properties.recovered.toString()}"),
                ),
                ListTile(
                  leading: Icon(Icons.clear),
                  title:
                      Text("Deaths: ${feature.properties.deaths.toString()}"),
                ),
                ListTile(
                  leading: Icon(Icons.flag),
                  title: Text(
                      "Confirmed: ${feature.properties.confirmed.toString()}"),
                ),
                ListTile(
                  leading: Icon(Icons.hotel),
                  title:
                      Text("Active: ${feature.properties.active.toString()}"),
                ),
              ],
            ),
          );
        },
      );
      future.then((void value) => _closeModal(value));
    });
  }

  void _closeModal(void value) {}
}
