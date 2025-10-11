import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import 'package:geocoding/geocoding.dart';
import 'package:store_app/features/adress/managers/address_bloc.dart';
import 'package:store_app/features/adress/managers/address_event.dart';
import 'package:store_app/features/adress/managers/address_state.dart';

import '../../../data/models/address/adres_model.dart';

class AddNewAddressPage extends StatefulWidget {
  const AddNewAddressPage({super.key});

  @override
  State<AddNewAddressPage> createState() => _AddNewAddressPageState();
}

class _AddNewAddressPageState extends State<AddNewAddressPage> {
  final TextEditingController _addressController = TextEditingController();
  String? _nickname;
  bool _isDefault = false;
  bool _isSubmitting = false;

  LatLng _selectedPosition = LatLng(41.3111, 69.2797);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (addresses) {
            if (_isSubmitting) {
              _isSubmitting = false;
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: const Icon(
                      Icons.verified,
                      color: Colors.green,
                      size: 48,
                    ),
                    content: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Congratulations!',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text('Your new address has been added.'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          context.go('/address');
                        },
                        child: const Text('Thanks'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          error: (msg) {
            if (_isSubmitting) _isSubmitting = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $msg')));
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.go('/address'),
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('New Address'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => context.go('/notifications'),
              icon: const Icon(Icons.notifications_outlined),
            ),
          ],
        ),
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 562.h,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: _selectedPosition,
                  initialZoom: 14,
                  onTap: (tapPosition, point) async {
                    setState(() => _selectedPosition = point);
                    try {
                      List<Placemark> placemarks =
                      await placemarkFromCoordinates(point.latitude, point.longitude);
                      if (placemarks.isNotEmpty) {
                        final placemark = placemarks.first;
                        String fullAddress =
                            '${placemark.street ?? ''}, ${placemark.locality ?? ''}, ${placemark.administrativeArea ?? ''}, ${placemark.country ?? ''}';
                        setState(() {
                          _addressController.text = fullAddress;
                        });
                      }
                    } catch (e) {
                      print("Error fetching address: $e");
                    }
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.store_app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _selectedPosition,
                        width: 50,
                        height: 50,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Address',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _nickname,
                        decoration: const InputDecoration(
                          labelText: 'Address Nickname',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'Home', child: Text('Home')),
                          DropdownMenuItem(value: 'Work', child: Text('Work')),
                          DropdownMenuItem(value: 'Other', child: Text('Other')),
                        ],
                        onChanged: (val) => setState(() => _nickname = val),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          labelText: 'Full Address',
                          hintText: 'Enter your full address...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Checkbox(
                            value: _isDefault,
                            onChanged: (val) => setState(() => _isDefault = val ?? false),
                          ),
                          const Text('Make this as a default address'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isSubmitting
                              ? null
                              : () {
                            if (_nickname != null && _addressController.text.isNotEmpty) {
                              final address = AddressModel(
                                nickname: _nickname!,
                                fullAddress: _addressController.text,
                                isDefault: _isDefault,
                                lat: _selectedPosition.latitude,
                                lng: _selectedPosition.longitude,
                              );

                              _isSubmitting = true;
                              context.read<AddressBloc>().add(AddAddress(address));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please fill all required fields')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isSubmitting
                              ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(color: Colors.white))
                              : const Text('Add',
                              style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}