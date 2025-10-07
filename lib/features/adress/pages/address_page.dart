import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:store_app/features/adress/managers/address_bloc.dart';
import 'package:store_app/features/adress/managers/address_state.dart';
import 'package:store_app/features/adress/managers/address_event.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  void initState() {
    super.initState();
    context.read<AddressBloc>().add(LoadAddress());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/cards'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Address'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.go('/notifications'),
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Saved Locations',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<AddressBloc, AddressState>(
                builder: (context, state) {
                  return state.when(
                    initial: () =>
                        const Center(child: Text("No addresses yet")),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (msg) => Center(child: Text("Error: $msg")),
                    success: (addresses) {
                      if (addresses.isEmpty) {
                        return const Center(child: Text("No saved addresses"));
                      }
                      return ListView.builder(
                        itemCount: addresses.length,
                        itemBuilder: (context, index) {
                          final address = addresses[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(address.title),
                              subtitle: Text(address.fullAddress),
                              trailing: Icon(
                                address.isDefault
                                    ? Icons.check_circle
                                    : Icons.location_on_outlined,
                                color: address.isDefault ? Colors.green : null,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                context.go('/addAddress');
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 54.h,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCCCCCC), width: 3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add),
                    SizedBox(width: 8),
                    Text('Add New Address', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                final state = context.read<AddressBloc>().state;
                state.when(
                  initial: () => ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('No addresses'))),
                  loading: () {},
                  error: (msg) =>
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg))),
                  success: (addresses) {
                    final defaultAddress =
                    addresses.firstWhere((addr) => addr.isDefault, orElse: () => addresses.first);
                    context.go('/cards', extra: defaultAddress);
                  },
                );
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 54.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: Text(
                  'Apply',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),],
        ),
      ),
    );
  }
}
