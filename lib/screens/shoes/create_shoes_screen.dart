import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/blocs/create_shoes_bloc/create_shoes_bloc.dart';
import 'package:flutter_application_1/blocs/upload_picture_bloc/upload_picture_bloc.dart';
import 'package:flutter_application_1/components/my_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shoes_repository/shoes_repository.dart';

/// A screen widget for creating a new pair of shoes.
class CreateShoesScreen extends StatefulWidget {
  /// Constructs a [CreateShoesScreen].
  const CreateShoesScreen({super.key});

  @override
  State<CreateShoesScreen> createState() => _CreateShoesScreenState();
}

class _CreateShoesScreenState extends State<CreateShoesScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool creationRequired = false;
  String? _errorMsg;
  late Shoes shoes;

  @override
  void initState() {
    shoes = Shoes.empty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateShoesBloc, CreateShoesState>(
      listener: (BuildContext context, CreateShoesState state) async {
        if (state is CreateShoesSuccess) {
          setState(() async {
            creationRequired = false;
            Navigator.pop(context);
          });
        } else if (state is CreateShoesLoading) {
          setState(() {
            creationRequired = true;
          });
        }
      },
      child: BlocListener<UploadPictureBloc, UploadPictureState>(
        listener: (BuildContext context, UploadPictureState state) {
          if (state is UploadPictureLoading) {
          } else if (state is UploadPictureSuccess) {
            setState(() {
              shoes.picture = state.url;
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Create a New SHoes !',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image != null && context.mounted) {
                        context.read<UploadPictureBloc>().add(
                              UploadPicture(
                                await image.readAsBytes(),
                                basename(image.path),
                              ),
                            );
                      }
                    },
                    child: shoes.picture.isNotEmpty
                        ? Container(
                            width: 400,
                            height: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(shoes.picture),
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        : Ink(
                            width: 400,
                            height: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  CupertinoIcons.photo,
                                  size: 100,
                                  color: Colors.grey.shade200,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Add a Picture here...',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 400,
                          child: MyTextField(
                            controller: nameController,
                            hintText: 'Name',
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            errorMsg: _errorMsg,
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return 'Please fill in this field';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 400,
                          child: MyTextField(
                            controller: descriptionController,
                            hintText: 'Description',
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            errorMsg: _errorMsg,
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return 'Please fill in this field';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 400,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: MyTextField(
                                  controller: priceController,
                                  hintText: 'Price',
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  errorMsg: _errorMsg,
                                  validator: (String? val) {
                                    if (val!.isEmpty) {
                                      return 'Please fill in this field';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (!creationRequired)
                    SizedBox(
                      width: 400,
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              shoes
                                ..name = nameController.text
                                ..description = descriptionController.text
                                ..sizeShoes = <int>[
                                  36,
                                  37,
                                  38,
                                  39,
                                  40,
                                  41,
                                  42,
                                  43,
                                  44,
                                  45,
                                ]
                                ..price = double.parse(priceController.text);
                            });
                            context
                                .read<CreateShoesBloc>()
                                .add(CreateShoes(shoes));
                          }
                        },
                        style: TextButton.styleFrom(
                          elevation: 3,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 5,
                          ),
                          child: Text(
                            'Create Pizza',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
