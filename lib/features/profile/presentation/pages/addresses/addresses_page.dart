import 'package:daar_project/app/theme/colors.dart';
import 'package:daar_project/features/profile/presentation/pages/addresses/widgets/address_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/routes/route_names.dart';
import '../../../../../init_dependencies.dart';
import '../../../domain/entities/address.dart';
import '../../cubit/address_cubit.dart';


class AddressesPage extends StatefulWidget {
  const AddressesPage({super.key});

  @override
  State<AddressesPage> createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  final _addressCubit = serviceLocator<AddressCubit>();

  @override
  void initState() {
    _addressCubit.getAddresses();
    super.initState();
  }

  void _showEditDialog(Address address) {
    final nameController = TextEditingController(text: address.name);
    final descriptionController = TextEditingController(text: address.description);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SizedBox(
            width: 350,
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text("Edit Address"),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(hintText: "Address Name"),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(hintText: "Description"),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      final updatedAddress = address.copyWith(
                        name: nameController.text,
                        description: descriptionController.text,
                      );
                      _addressCubit.updateAddress(updatedAddress);
                    },
                    child: const Text("Confirm"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _addressCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text('my_addresses'.tr()),
          centerTitle: true,
        ),
        body: BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            if (state is AddressLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AddressError) {
              return Center(child: Text(state.message));
            }

            if (state is AddressLoaded) {
              final addresses = state.addresses;

              if (addresses.isEmpty) {
                return const Center(
                  child: Text("Nessun indirizzo salvato"),
                );
              }

              return ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final address = addresses[index];

                  return AddressCard(
                    address: address,
                    onEdit: () => _showEditDialog(address),
                    onDelete: () => _addressCubit.deleteAddress(address.id),
                    onTap: () => _addressCubit.setDefaultAddress(address.id), // <-- Aggiungi questo
                  );
                },
              );
            }

            return const Center(child: Text("Nessun indirizzo salvato"));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.addAddress);

            _addressCubit.getAddresses();
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}