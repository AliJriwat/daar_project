import 'package:daar_project/app/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../app/routes/route_names.dart';

class AddressesPage extends StatefulWidget {
  const AddressesPage({super.key});

  @override
  State<AddressesPage> createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getAddresses() async {
    return await supabase
        .from('addresses')
        .select()
        .eq('user_id', supabase.auth.currentUser!.id)
        .order('created_at', ascending: true);
  }

  Future<void> setDefaultAddress(String id) async {
    final userId = supabase.auth.currentUser!.id;

    await supabase
        .from('addresses')
        .update({'is_default': false})
        .eq('user_id', userId);

    await supabase
        .from('addresses')
        .update({'is_default': true})
        .eq('id', id);

    setState(() {});
  }

  Future<void> modifyAddress(String id, String? addressName, String? description) async {
    final Map<String, dynamic> updateData = {};

    if (addressName != null && addressName.isNotEmpty) {
      updateData['address_name'] = addressName;
    }

    if (description != null && description.isNotEmpty) {
      updateData['description'] = description;
    }

    if (updateData.isNotEmpty) {
      await supabase.from('addresses').update(updateData).eq('id', id);
      setState(() {});
    }
  }

  Future<void> deleteAddress(String id) async {
    final userId = supabase.auth.currentUser!.id;

    // Controlla se l'indirizzo da eliminare è quello di default
    final deletedItem = await supabase
        .from('addresses')
        .select()
        .eq('id', id)
        .single();

    final isDefault = deletedItem['is_default'] == true;

    // Elimina l'indirizzo
    await supabase.from('addresses').delete().eq('id', id);

    // Se era default, setta l'ultimo indirizzo creato come default
    if (isDefault) {
      final lastAddress = await supabase
          .from('addresses')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();

      if (lastAddress != null) {
        await setDefaultAddress(lastAddress['id'].toString());
      }
    } else {
      setState(() {}); // Aggiorna la UI
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my_addresses'.tr()),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getAddresses(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final addresses = snapshot.data!;

          if (addresses.isEmpty) {
            return const Center(
              child: Text("Nessun indirizzo salvato"),
            );
          }

          return ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final item = addresses[index];
              final isDefault = item['is_default'] == true;

              return GestureDetector(
                onTap: () => setDefaultAddress(item['id'].toString()),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // 🔵 Cerchio cliccabile
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary,
                            width: 2,
                          ),
                          color: isDefault ? AppColors.primary : Colors.transparent,
                        ),
                      ),

                      const SizedBox(width: 14),

                      // 📍 Nome e descrizione
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['address_name'],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            if (item['description'] != null &&
                                item['description'].toString().isNotEmpty)
                              Text(
                                item['description'],
                                style: TextStyle(
                                    color: Colors.grey.shade700, fontSize: 14),
                              ),
                          ],
                        ),
                      ),

                      // ✏️ Pulsante modifica
                      IconButton(
                        onPressed: () {
                          final addressNameController =
                          TextEditingController(text: item['address_name']);
                          final descriptionController =
                          TextEditingController(text: item['description']);

                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
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
                                          controller: addressNameController,
                                          decoration:
                                          const InputDecoration(hintText: "Address Name"),
                                        ),
                                        const SizedBox(height: 16),
                                        TextField(
                                          controller: descriptionController,
                                          decoration:
                                          const InputDecoration(hintText: "Description"),
                                        ),
                                        const SizedBox(height: 24),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            modifyAddress(
                                              item['id'].toString(),
                                              addressNameController.text,
                                              descriptionController.text,
                                            );
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
                        },
                        icon: const Icon(Icons.edit),
                      ),

                      // ❌ Pulsante elimina
                      IconButton(
                        onPressed: () {
                          deleteAddress(item['id'].toString());
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteNames.addAddress);
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
