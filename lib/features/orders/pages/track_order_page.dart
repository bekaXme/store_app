import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class TrackOrderPage extends StatelessWidget {
  const TrackOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/myOrders'),
        ),
        title: const Text('Track Order'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              context.go('/notifications');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Map Section
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(64.8439, -147.7212), // Center on Fairbanks, Alaska (example)
              initialZoom: 12.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [
                      LatLng(64.8439, -147.7212), // Starting point (example)
                      LatLng(64.8440, -147.7200), // In Transit point
                      LatLng(64.8441, -147.7190), // Delivery point
                    ],
                    strokeWidth: 4.0,
                    color: Colors.blue,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(64.8439, -147.7212),
                    child: const Icon(
                      Icons.store,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  Marker(
                    point: LatLng(64.8440, -147.7200),
                    child: Icon(
                      Icons.local_shipping,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  Marker(
                    point: LatLng(64.8441, -147.7190),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Order Status Section
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.close, color: Colors.black),
              ),
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Status',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildStatusItem('Packing', '2336 Jack Warren Rd, Delta Junction, Alaska...', false),
                  _buildStatusItem('Picked', '2417 Tongass Ave #111, Ketchikan, Alaska 9...', false),
                  _buildStatusItem('In Transit', '16 Rr 2, Ketchikan, Alaska 99901, USA', true),
                  _buildStatusItem('Delivered', '925 S Chugach St #APT 10, Alaska 99645', false),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: const NetworkImage(
                          'https://via.placeholder.com/40', // Placeholder for delivery guy image
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jacob Jones',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Delivery Guy'),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.phone),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(String status, String location, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isActive ? Icons.circle : Icons.radio_button_unchecked,
            size: 16,
            color: isActive ? Colors.blue : Colors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$status\n$location',
              style: TextStyle(
                color: isActive ? Colors.black : Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}