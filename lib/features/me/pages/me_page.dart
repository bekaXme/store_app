import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:store_app/features/common/bottom_nav_widget.dart';
import '../managers/me_bloc.dart';
import '../managers/me_event.dart';
import '../managers/me_state.dart';
import '../widgets/me_text_field.dart';
import '../widgets/me_dropdown.dart';
import '../widgets/me_submit_button.dart';


class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _dobController;
  late TextEditingController _phoneController;
  String _gender = "Male";

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _dobController = TextEditingController();
    _phoneController = TextEditingController();

    context.read<MeBloc>().add(LoadMyInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.go('/myAccount'),
        ),
        title: const Text(
          "My Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<MeBloc, MeState>(
        builder: (context, state) {
          if (state is MeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MeLoaded) {
            _nameController.text = state.me.fullName;
            _emailController.text = state.me.email;
            _dobController.text = state.me.birthDate != null
                ? DateFormat("dd/MM/yyyy").format(state.me.birthDate!)
                : "";
            _phoneController.text = state.me.phoneNumber?.toString() ?? "";
            _gender = state.me.gender ?? "Male";

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    MeTextField(controller: _nameController, label: "Full Name"),
                    const SizedBox(height: 16),
                    MeTextField(controller: _emailController, label: "Email Address"),
                    const SizedBox(height: 16),
                    MeTextField(
                      controller: _dobController,
                      label: "Date of Birth",
                      readOnly: true,
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: state.me.birthDate ?? DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          _dobController.text =
                              DateFormat("dd/MM/yyyy").format(picked);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    MeDropdown(
                      value: _gender,
                      items: const ["Male", "Female"],
                      onChanged: (v) => setState(() => _gender = v ?? "Male"),
                    ),
                    const SizedBox(height: 16),
                    MeTextField(
                      controller: _phoneController,
                      label: "Phone Number",
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 24),
                    MeSubmitButton(
                      onPressed: () {
                        context.read<MeBloc>().add(UpdateMyInfo(
                          fullName: _nameController.text,
                          email: _emailController.text,
                          phoneNumber: _phoneController.text,
                          gender: _gender,
                          birthDate: _dobController.text.isNotEmpty
                              ? DateFormat("dd/MM/yyyy")
                              .parse(_dobController.text)
                              : DateTime.now(),
                        ));
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (state is MeError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: CustomBottomNav(currentIndex: 4),
    );
  }
}
