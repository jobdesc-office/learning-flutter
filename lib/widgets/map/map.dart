import 'dart:async';

import 'package:boilerplate/styles/color_palattes.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';

import '../../contracts/master/customerAddress_contract.dart';
import '../../presenters/default/map_presenter.dart';
import '../snackbar.dart';
import '_map_source.dart';

class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({Key? key}) : super(key: key);

  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage>
    implements CustomerAddressContract {
  final controller = Get.put(mapSource());
  final _controller = Completer<GoogleMapController>();
  final presenter = Get.put(MapPresenter());
  MapPickerController mapPickerController = MapPickerController();

  _GoogleMapsPageState() {
    presenter.mapAddresContract = this;
  }

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(-6.199086, 106.5750849),
    zoom: 14.4746,
  );

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          MapPicker(
            // pass icon widget
            iconWidget: Image.asset(
              "assets/images/location.png",
              height: 60,
            ),
            //add map picker controller
            mapPickerController: mapPickerController,
            child: GoogleMap(
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              // hide location button
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              //  camera position
              initialCameraPosition: cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onCameraMoveStarted: () {
                // notify map is moving
                mapPickerController.mapMoving!();
                textController.text = "checking ...";
              },
              onCameraMove: (cameraPosition) {
                this.cameraPosition = cameraPosition;
              },
              onCameraIdle: () async {
                // notify map stopped moving
                mapPickerController.mapFinishedMoving!();

                //get address name from camera position
                // List<Placemark> placemarks = await placemarkFromCoordinates(
                //   cameraPosition.target.latitude,
                //   cameraPosition.target.longitude,
                // );
                // update the ui with the address
                textController.text =
                    '${cameraPosition.target.latitude}, ${cameraPosition.target.longitude}';
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).viewPadding.top + 20,
            width: MediaQuery.of(context).size.width - 50,
            height: 50,
            child: TextFormField(
              maxLines: 3,
              textAlign: TextAlign.center,
              readOnly: true,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero, border: InputBorder.none),
              controller: textController,
            ),
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: SizedBox(
              height: 50,
              child: BsButton(
                style: BsButtonStyle(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: ColorPallates.primary,
                    backgroundColor: ColorPallates.secondary),
                label: const Text(
                  "Submit",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: Color(0xFFFFFFFF),
                    fontSize: 19,
                    // height: 19/19,
                  ),
                ),
                onPressed: () async {
                  String country = await presenter.address(
                      '${cameraPosition.target.latitude},${cameraPosition.target.longitude}');

                  if (country == 'ID') {
                    Snackbar().locationSelected();
                    controller.latitude.value = cameraPosition.target.latitude;
                    controller.longitude.value =
                        cameraPosition.target.longitude;
                    controller.linkCoordinate.value =
                        'https://maps.google.com?q=${cameraPosition.target.latitude},${cameraPosition.target.longitude}';
                    controller.latitudelongitude.value =
                        '${cameraPosition.target.latitude},${cameraPosition.target.longitude}';
                    Navigator.pop(context, true);
                  } else {
                    Snackbar().outOfRange();
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void onLoadAddressSuccess(Response response) {}
}
