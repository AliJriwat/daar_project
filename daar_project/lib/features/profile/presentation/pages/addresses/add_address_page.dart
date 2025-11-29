import 'package:daar_project/features/profile/presentation/pages/addresses/widgets/address_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../app/theme/colors.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  CameraPosition? userLocation;
  //final SupabaseClient supabase;
  final supabase = Supabase.instance.client;

  final addressTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  getUserLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (kDebugMode) {
      print("Service Enabled $isServiceEnabled ");
    }
    if (isServiceEnabled == false) {
      Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return;
    }

    final position = await Geolocator.getCurrentPosition();
    userLocation = CameraPosition(target: LatLng(position.latitude, position.longitude));

    setState(() {
      userLocation = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
        zoom: 15,
      );
    });
  }

  Future<void> saveAddress() async {
    await supabase.from('addresses').insert({
      'user_id': supabase.auth.currentUser!.id,
      'address_name': addressTextController.text,
      'description': descriptionTextController.text,
      'latitude': userLocation!.target.latitude,
      'longitude': userLocation!.target.longitude,
      'is_default': true,
    });
  }
  @override
  void initState() {
    getUserLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
      ),
      body: Column(
        children: [
          userLocation == null
              ? Center(child:  CircularProgressIndicator())
              : Expanded(
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: userLocation!,
                      myLocationEnabled: true,
                      zoomGesturesEnabled: true,
                      scrollGesturesEnabled: true,

                      onCameraMove: (position) {
                          setState(() {
                            userLocation = position;
                          });
                      },
                    ),
                    Positioned(
                        child: Center(
                          child: Icon(
                            Icons.location_pin,
                            size: 32,
                            color: AppColors.primary,
                          ),
                        )
                    ),
                  ],
                ),
              ),
          // 🎯 BOTTONE CONTINUE IN FONDO
          Container(
            padding: const EdgeInsets.all(25),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 400,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            children: [
                              Text(
                                  "Add Additional Data for your location",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 20),
                              buildAddressTextField(
                                  controller: addressTextController,
                                  hintText: "Address Name",
                              ),
                              const SizedBox(height: 16),
                              buildAddressTextField(
                                  controller: descriptionTextController,
                                  hintText: "Address Description",
                                isDescription: true,
                              ),
                              const SizedBox(height: 16),
                              buildAddressButton(
                                  text: "Confirm",
                                  onPressed: () {
                                    saveAddress();
                                    Navigator.pop(context);
                                  },
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}