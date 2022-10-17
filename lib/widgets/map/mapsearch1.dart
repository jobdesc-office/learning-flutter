import 'dart:async';

import 'package:boilerplate/helpers/function.dart';
import 'package:boilerplate/styles/color_palattes.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:map_picker/map_picker.dart';

import '../../contracts/master/customerAddress_contract.dart';
import '../../presenters/default/map_presenter.dart';
import '../snackbar.dart';
import '_map_source.dart';
import 'mapsearch2.dart';

class GoogleMapsSearchPage extends StatefulWidget {
  final CameraPosition camera;
  const GoogleMapsSearchPage({Key? key, required this.camera});

  @override
  _GoogleMapsSearchPageState createState() => _GoogleMapsSearchPageState();
}

class _GoogleMapsSearchPageState extends State<GoogleMapsSearchPage>
    implements CustomerAddressContract {
  final controller = Get.put(MapSource());
  final _controller = Completer<GoogleMapController>();
  final presenter = Get.put(MapPresenter());
  MapPickerController mapPickerController = MapPickerController();

  var textController = TextEditingController();
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CameraPosition cameraPosition = widget.camera;
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
                cameraPosition = cameraPosition;
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
            top: 24,
            left: 24,
            right: 24,
            child: BsRow(
              children: [
                BsCol(
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //     color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.white,
                  ),
                  sizes: ColScreen(sm: Col.col_4),
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: GooglePlaceAutoCompleteTextField(
                        textEditingController: search,
                        googleAPIKey: "AIzaSyDUYfxm7qJq8dcMMhvhaoUukhQqMxBO6oc",
                        inputDecoration:
                            InputDecoration(hintText: "Search your location"),
                        debounceTime: 800,
                        countries: ["id"],
                        isLatLngRequired: true,
                        getPlaceDetailWithLatLng: (Prediction prediction) {
                          setState(() {
                            cameraPosition = CameraPosition(
                              target: LatLng(parseDouble(prediction.lat),
                                  parseDouble(prediction.lng)),
                              zoom: 14.4746,
                            );
                          });
                          Get.to(GoogleMapsSearchPage2(
                            camera: CameraPosition(
                              target: LatLng(parseDouble(prediction.lat),
                                  parseDouble(prediction.lng)),
                              zoom: 14.4746,
                            ),
                          ));
                        },
                        itmClick: (Prediction prediction) {
                          search.text = prediction.description ?? '';

                          search.selection = TextSelection.fromPosition(
                              TextPosition(
                                  offset: prediction.description?.length ?? 0));
                        }
                        // default 600 ms ,
                        ),
                  ),
                ),
                // BsCol(
                //   decoration: BoxDecoration(
                //     // border: Border.all(
                //     //     color: Colors.black),
                //     borderRadius: BorderRadius.all(Radius.circular(5.0)),
                //     color: Colors.white,
                //   ),
                //   height: 49,
                //   alignment: Alignment.center,
                //   sizes: ColScreen(sm: Col.col_1),
                //   child: Icon(
                //     Icons.search,
                //     size: 24,
                //   ),
                // )
              ],
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
