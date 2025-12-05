import 'package:daar_project/features/profile/presentation/pages/edit_profile/widgets/profile_edit_text_field.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/theme/colors.dart';
import '../../../../../core/utils/show_snackbar.dart';
import '../../../bloc/edit_profile_bloc/edit_profile_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<EditProfileBloc>().add(LoadProfile());
  }

  @override
  void dispose() {
    nameTextController.dispose();
    emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state.saved) {
          showSnackBar(context, "Profilo salvato con successo");

          //Reset
          context.read<EditProfileBloc>().add(ResetSaved());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('edit_profile'.tr()),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  )
              ),
              const SizedBox(height: 40),
              BlocBuilder<EditProfileBloc, EditProfileState>(
                builder: (context, state) {
                  if (state.username.isEmpty && state.email.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    children: [
                      buildProfileTextField(
                        controller: nameTextController,
                        hintText: state.username,
                      ),
                      const SizedBox(height: 10),
                      buildProfileTextField(
                        controller: emailTextController,
                        hintText: state.email,
                      ),
                      const SizedBox(height: 10),
                      /*
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding:
                        const EdgeInsets.symmetric(horizontal:150, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Next", style: TextStyle(fontSize: 16)),
                    ),

                     */
                      ElevatedButton(
                          onPressed: () {
                            context.read<EditProfileBloc>().add(
                                SaveProfile(
                                  username: nameTextController.text,
                                  email: emailTextController.text,
                                )
                            );
                          },
                          child: Text("save")
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

