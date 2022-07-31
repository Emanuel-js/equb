import 'dart:math';

import 'package:equb/api/api.dart';
import 'package:equb/commen/screens/widgets/textWidget.dart';
import 'package:equb/sales/domain/services/salesService.dart';
import 'package:equb/theme/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

class AgentLocationScreen extends StatefulWidget {
  const AgentLocationScreen({Key? key}) : super(key: key);

  @override
  State<AgentLocationScreen> createState() => _AgentLocationScreenState();
}

const kGoogleApiKey = Api.api_key;
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _AgentLocationScreenState extends State<AgentLocationScreen> {
  final _salesService = Get.find<SalesService>();
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(8.980603, 38.757759), zoom: 14.0);
  CameraPosition? cameraPosition;

  Set<Marker> markersList = {};

  late GoogleMapController googleMapController;

  final Mode _mode = Mode.overlay;
  String location = "Location Name:";

  addMarker(cordinate, title) {
    int id = Random().nextInt(100);
    setState(() {});
    markersList.add(Marker(
        markerId: MarkerId(id.toString()),
        position: cordinate,
        infoWindow: InfoWindow(title: title)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      floatingActionButton: Container(
        alignment: Alignment.bottomLeft,
        margin: const EdgeInsets.only(left: 30, bottom: 10),
        child: FloatingActionButton.extended(
          onPressed: () async {
            _handlePressButton();
          },
          label: TextWidget(label: "አድራሻውን መዝግቡ 📌"),
          icon: Icon(
            Icons.location_on,
            color: AppColor.white,
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("አድራሻውን ይፈልጉ"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: markersList,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
            onCameraMove: (CameraPosition cameraPositiona) {
              cameraPosition = cameraPositiona; //when map is dragging
            },
            onTap: (controler) {
              _salesService.lat = controler.latitude;
              _salesService.long = controler.longitude;
              googleMapController
                  .animateCamera(CameraUpdate.newLatLngZoom(controler, 14.0));
              markersList.clear();
              addMarker(controler, "");
              setState(() {});
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'ፈልግ',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white))),
        components: [
          Component(Component.country, "ET"),
        ]);

    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState!
        .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

//  detail.result.name
  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    _salesService.lat = lat;
    _salesService.long = lng;
    markersList.clear();
    addMarker(
        LatLng(_salesService.lat!, _salesService.long!), detail.result.name);
    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(_salesService.lat!, _salesService.long!), 14.0));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
