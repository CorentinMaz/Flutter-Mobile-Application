import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/user/blocs/update_user_bloc/update_user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_repository/user_repository.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({required this.user, Key? key}) : super(key: key);
  final MyUser user;

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late File? _imageFile;
  bool updateUserRequired = false;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _imageFile = File(widget.user.picture);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserBloc, UpdateUserState>(
      listener: (BuildContext context, UpdateUserState state) {
        if (state is UpdateUserSuccess) {
          setState(() {
            updateUserRequired = false;
          });
        } else if (state is UpdateUserLoading) {
          setState(() {
            updateUserRequired = true;
          });
        } else if (state is UpdateUserFailure) {
          setState(() {
            updateUserRequired = false;
            _errorMsg = 'Update user failed';
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  final ImagePicker imagePicker = ImagePicker();
                  final XFile? pickedImage =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    if (pickedImage != null) {
                      _imageFile = File(pickedImage.path);
                    }
                  });
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      (_imageFile != null && _imageFile!.path.isNotEmpty)
                          ? FileImage(_imageFile!) as ImageProvider
                          : (widget.user.picture.isNotEmpty)
                              ? NetworkImage(widget.user.picture)
                              : null,
                  child: _imageFile == null || _imageFile!.path.isEmpty
                      ? const Icon(Icons.camera_alt, size: 30)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final MyUser updatedUser = widget.user
                    ..email = _emailController.text
                    ..name = _nameController.text
                    ..picture = _imageFile != null
                        ? _imageFile!.path
                        : widget.user.picture;
                  print(updatedUser);
                  context.read<UpdateUserBloc>().add(UpdateUser(updatedUser));
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
