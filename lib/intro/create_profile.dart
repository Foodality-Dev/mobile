// import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../api/api_service.dart';
// import '../nav.dart';
import '../widgets/text_button.dart';
import '../widgets/text_form_field.dart';
import 'interests.dart';
import 'login.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({
    super.key,
    required this.email,
    required this.password
  });

  final String? email;
  final String? password;

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  
  File? image1;

  String? _usernameErrMsg;

  Future getImage(source) async {
    try{
      final image = await ImagePicker().pickImage(source: source);
      if (image == null)  return;
      final imageTemporary = File(image.path);
      setState(() {
        image1 = imageTemporary;
      });
      _cropImage();
    } catch(error) {
      print("error: $error");
    }
  }
  
  Future _cropImage() async {
    if (image1 != null) {
      CroppedFile? cropped = await ImageCropper().cropImage(
          sourcePath: image1!.path,
          // aspectRatioPresets: [
          //   CropAspectRatioPreset.square,
          //   CropAspectRatioPreset.ratio3x2,
          //   CropAspectRatioPreset.original,
          //   CropAspectRatioPreset.ratio4x3,
          //   CropAspectRatioPreset.ratio16x9
          // ],  
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop',
              cropGridColor: Colors.black,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
            IOSUiSettings(title: 'Crop')
          ]);
  
      if (cropped != null) {
        setState(() {
          image1 = File(cropped.path);
        });
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {   
    print(FirebaseAuth.instance.currentUser); 
    // return StreamBuilder(
    //   stream: FirebaseAuth.instance.userChanges(),
    //   initialData: FirebaseAuth.instance.currentUser,
    //   builder: (context, snapshot) {
    //     final user = snapshot.data;
    //     if (user != null) {
    //       log("user is logged in! this is from create_profile.dart");
    //       return const Nav();
    //     }
        
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 30,
            title: Align(alignment: Alignment.centerRight, child: TextButton(
              onPressed: () => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login())
                )
              },
              child: Text(
                textAlign: TextAlign.center,
                "sign in",
                style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: Colors.white.withOpacity(0.75)),
              ),
            )
          )),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Align(alignment: Alignment.center, child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .1),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 60, bottom: 90),
                      child: Text(
                        "customize your profile",
                        style: Theme.of(context).primaryTextTheme.titleLarge
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: GestureDetector(
                        onTap: () => showModalBottomSheet(
                          context: context, 
                          enableDrag: true,
                          backgroundColor: const Color(0xFF181A1E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                          builder: (context) => SizedBox(
                            height: MediaQuery.of(context).size.height * .28,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height * .28 * .068,
                                    bottom: MediaQuery.of(context).size.height * .28 * .136),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      height: 10,
                                      width: MediaQuery.of(context).size.width * .248,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF262930),
                                        borderRadius: BorderRadius.circular(100)
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * .28 * .274,
                                  width: MediaQuery.of(context).size.width * .905,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      getImage(ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                    style: OutlinedButton.styleFrom(
                                      splashFactory: NoSplash.splashFactory,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      side: BorderSide(color: Colors.white.withOpacity(0.2), width: 1)     
                                    ),
                                    child: Text(
                                      "take picture",
                                      style: Theme.of(context).primaryTextTheme.labelMedium
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .28 * .025)),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * .28 * .274,
                                  width: MediaQuery.of(context).size.width * .905,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      getImage(ImageSource.gallery);
                                      Navigator.of(context).pop();
                                    },
                                    style: OutlinedButton.styleFrom(
                                      splashFactory: NoSplash.splashFactory,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      side: BorderSide(color: Colors.white.withOpacity(0.2), width: 1)    
                                    ),
                                    child: Text(
                                      "upload from library",
                                      style: Theme.of(context).primaryTextTheme.labelMedium
                                    ),
                                  ),
                                )
                              ]
                            ),
                          )
                        ),
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * .195,
                          backgroundImage: AssetImage(image1?.path ?? 'assets/icons/create_profile.png')
                        ),
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: QFTextFormField(
                        autofillHints: const [AutofillHints.newUsername],
                        controller: usernameController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a unique username';
                          } else if (value.length > 30) {
                            return 'Username must have at most 30 characters';
                          } else if (!RegExp(r'^[a-z0-9._]*[a-z]+[a-z0-9._]*$')
                                  .hasMatch(value.toLowerCase().trim())
                          ) {
                            return 'Username must only have letters, numbers, ".", and "_" with at least one letter and no space in between';
                          }
                          return null; // TODO: return something
                        },
                        decoration: QFInputDecoration.large(context: context, hintText: 'username', errorText: _usernameErrMsg),
                      ),
                        // in this validator have it so that this only accepts
                        // a username with a-z 0-9 . _ characters, and there must be at LEAST one a-z character (regex)
                        // and limit it to 30 characters (instagram's char limit)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: QFTextFormField(
                        autofillHints: const [AutofillHints.givenName],
                        controller: firstNameController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          } else if (value.length > 50) {
                            return 'First name must only have 50 letters or less';
                          } else if (!RegExp(r'^[A-za-z]+$').hasMatch(value.trim())) {
                            return 'First name must only have letters';
                          }
                          return null;
                        },
                        decoration: QFInputDecoration.large(context: context, hintText: 'first name'),
                      ),
                        // in this validator have it so that this only accepts
                        // a first name with only letters, and consider limiting char length to 50 (twitter standard)
                        // https://ux.stackexchange.com/questions/55529/what-should-the-character-limits-for-first-last-name-inputs-be
                    ),
                    QFTextFormField(
                      autofillHints: const [AutofillHints.familyName],
                      controller: lastNameController,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        } else if (value.length > 50) {
                          return 'Last name must only have 50 letters or less';
                        } else if (!RegExp(r'^[A-za-z]+$').hasMatch(value.trim())) {
                          return 'Last name must only have letters';
                        }
                        return null;
                      },
                      decoration: QFInputDecoration.large(context: context, hintText: 'last name'),
                    ),
                      // in this validator have it so that this only accepts 
                      // a first name with only letters, and consider limiting char length to 50(twitter standard)
                      // https://ux.stackexchange.com/questions/55529/what-should-the-character-limits-for-first-last-name-inputs-be
                  ],
                ),
              )),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 45, left: MediaQuery.of(context).size.width * .05, right: MediaQuery.of(context).size.width * .05 ),
            child: TextButton(
              onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  _usernameErrMsg = null;
                  ApiService()
                      .isUsernameUnique(usernameController.text)
                      .then((unique) {
                        if(unique) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Interests(
                                    email: widget.email,
                                    password: widget.email,
                                    username: usernameController.text,
                                    firstName: firstNameController.text.trim(),
                                    lastName: lastNameController.text.trim(),
                                    avatarImagePath: image1?.path ?? ""
                                );
                              })
                          );
                        } else {
                          setState(() {
                            _usernameErrMsg = "Username not unique";
                          });
                        }
                      })
                      .catchError((err) {
                        print("Failed to check username is unique: $err");
                      });
                }
              },
              style: QFButtonStyle.medium(),
              child: Text(
                "create profile", 
                style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(color: Colors.black)
              ),
            )
          ),
        );
      }
  //   );
  // }
}

