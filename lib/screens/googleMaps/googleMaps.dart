import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tienda_app/screens/home/home_screen.dart';
import 'package:geocoding/geocoding.dart';

class Googlemap extends StatefulWidget {
  final String address;
  final String name;
  Googlemap({this.address, this.name});
  @override
  _Googlemap createState() => _Googlemap();
}

class _Googlemap extends State<Googlemap> {
  GoogleMapController _mapController;
  List<Location> locations;
  MarkerId id = MarkerId("negocio");

  @override
  void initState() {
    super.initState();
    addressToLat();
  }

  Future<void> addressToLat() async {
    print(widget.address);
    List<Location> value = await locationFromAddress("${widget.address}");
    setState(() {
      locations = value;
    });
  }

  double locationlatitude() {
    if (locations == null) {
      return 0;
    } else {
      return locations[0].latitude;
    }
  }

  double locationlongitude() {
    if (locations == null) {
      return 0;
    } else {
      return locations[0].longitude;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LocalesScreen().createState().buildAppBar2(),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(locationlatitude(), locationlongitude()),
          zoom: 18,
        ),
        markers: _createMarkers(),
        onMapCreated: _onMapCreated,
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(vertical: 90),
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          child: Icon(Icons.zoom_out_map),
          onPressed: _centerView,
        ),
      ),
    );
  }

  Set<Marker> _createMarkers() {
    var tmp = Set<Marker>();
    tmp.add(Marker(
      markerId: id,
      infoWindow:
          InfoWindow(title: "${widget.name}", snippet: "${widget.address}"),
      position: LatLng(locationlatitude(), locationlongitude()),
    ));
    return tmp;
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _centerView();
  }

  _centerView() async {
    await _mapController.getVisibleRegion();
    var cameraUpdate = CameraUpdate.newLatLng(
        LatLng(locations[0].latitude, locations[0].longitude));
    _mapController.animateCamera(cameraUpdate);
    _mapController.showMarkerInfoWindow(id);
  }
}
