import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sneakboutique/blocs/upload_picture_bloc/upload_picture_bloc.dart';
import 'package:sneakboutique/screens/user/blocs/update_user_bloc/update_user_bloc.dart';
import 'package:user_repository/user_repository.dart';

/// Widget for displaying user-specific content.
class UserScreen extends StatefulWidget {
  /// Constructs a [UserScreen] with the provided user data.
  const UserScreen({required this.user, super.key});

  /// The user data to be displayed.
  final MyUser user;

  @override
  UserScreenState createState() => UserScreenState();
}

/// A stateful widget responsible for managing the state of the user screen.
class UserScreenState extends State<UserScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late String _imageFile;
  bool _isHovering = false;
  bool _isNameSelected = false;
  bool _isEmailSelected = false;

  /// Flag indicating whether an update for the user data is required.
  bool updateUserRequired = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _imageFile = widget.user.picture;
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
          });
        }
      },
      child: BlocListener<UploadPictureBloc, UploadPictureState>(
        listener: (BuildContext context, UploadPictureState state) {
          if (state is UploadPictureLoading) {
          } else if (state is UploadPictureSuccess) {
            setState(() {
              _imageFile = state.url;
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                          image:
                              _imageFile.isNotEmpty
                                ? DecorationImage(
                                    image: NetworkImage(_imageFile),
                                    fit: BoxFit.contain,
                                  )
                                : null,
                        ),
                        child: _imageFile.isEmpty
                          ? Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: Colors.grey[400],
                            )
                          : null,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: MouseRegion(
                          onEnter: (_) {
                            setState(() {
                              _isHovering = true;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              _isHovering = false;
                            });
                          },
                          child: GestureDetector(
                            onTap: () async {
                              final ImagePicker imagePicker = ImagePicker();
                              final XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
                              if (pickedImage != null && context.mounted) {
                                context.read<UploadPictureBloc>().add(
                                  UploadPicture(
                                    await pickedImage.readAsBytes(),
                                    basename(pickedImage.path),
                                  ),
                                );
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              padding: EdgeInsets.all(_isHovering ? 8.0 : 6.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                              child: const Icon(
                                Icons.photo_library,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: MouseRegion(
                          onEnter: (_) {
                            setState(() {
                              _isHovering = true;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              _isHovering = false;
                            });
                          },
                          child: GestureDetector(
                            onTap: () async {
                              late XFile? pickedImage;
                              if (!kIsWeb) {
                                final ImagePicker imagePicker = ImagePicker();
                                pickedImage = await imagePicker.pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
                              } else {
                                // final CameraService cameraService = CameraService();
                                // final CameraPlugin imagePicker = CameraPlugin(cameraService: cameraService);
                                // pickedImage = await imagePicker.takePicture();
                                // final ImagePickerPlugin imagePicker = ImagePickerPlugin();
                                // pickedImage = await imagePicker.getImageFromSource(
                                //   source: ImageSource.camera,
                                // );
                              }
                              if (pickedImage != null && context.mounted) {
                                context.read<UploadPictureBloc>().add(
                                  UploadPicture(
                                    await pickedImage.readAsBytes(),
                                    basename(pickedImage.path),
                                  ),
                                );
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              padding: EdgeInsets.all(_isHovering ? 8.0 : 6.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: _buildCustomTextField(
                      controller: _nameController,
                      labelText: 'Your Name',
                      isSelected: _isNameSelected,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: _buildCustomTextField(
                      controller: _emailController,
                      labelText: 'Your Email',
                      isSelected: _isEmailSelected,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final MyUser updatedUser = widget.user
                        ..email = _emailController.text
                        ..name = _nameController.text
                        ..picture =
                            _imageFile.isNotEmpty ? _imageFile : widget.user.picture;
                      context.read<UpdateUserBloc>().add(UpdateUser(updatedUser));
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }

  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String labelText,
    required bool isSelected,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isSelected ? Colors.black : Colors.transparent,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: isSelected ? Colors.black : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
          border: InputBorder.none,
        ),
        onTap: () {
          setState(() {
            if (labelText == 'Your Name') {
              _isNameSelected = true;
              _isEmailSelected = false;
            } else {
              _isEmailSelected = true;
              _isNameSelected = false;
            }
          });
        },
        onEditingComplete: () {
          setState(() {
            _isNameSelected = false;
            _isEmailSelected = false;
          });
        },
      ),
    );
  }
}
