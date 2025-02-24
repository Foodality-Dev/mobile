// import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import '../nav.dart';
import '../widgets/text_button.dart';
import 'congrats.dart';
import 'login.dart';

class Interests extends StatefulWidget {
  const Interests({
    super.key,
    required this.email,
    required this.password,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.avatarImagePath
  });

  final String? email;
  final String? password;
  final String username;
  final String firstName;
  final String lastName;
  final String avatarImagePath;

  @override
  State<Interests> createState() => _InterestsState();

  // --> NOTE this! <--
  // ignore: library_private_types_in_public_api
  static _InterestsState? of(BuildContext context) =>
    context.findAncestorStateOfType<_InterestsState>();
}

class _InterestsState extends State<Interests> {
  bool selected0 = false;
  bool selected1 = false;
  bool selected2 = false;

  bool selected3 = false;
  bool selected4 = false;
  bool selected5 = false;

  bool selected6 = false;
  bool selected7 = false;
  bool selected8 = false;

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser); 
    // return StreamBuilder(
    //   stream: FirebaseAuth.instance.userChanges(),
    //   initialData: FirebaseAuth.instance.currentUser,
    //   builder: (context, snapshot) {
    //     // EYE ICON CLICK CAUSES THIS TO APPEAR AND IT'S WEIRD. 
    //     // if (snapshot.connectionState != ConnectionState.active) {
    //     //   return Center(child: CircularProgressIndicator());
    //     // }
    //     final user = snapshot.data;
    //     if (user != null) {
    //       log("user is logged in! this is from interests.dart");
    //       return const Nav();
    //     }
        
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 30,
            title: Align(alignment: Alignment.centerRight, child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login())
                );
              },
              child: Text(
                textAlign: TextAlign.center,
                "sign in",
                style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: Colors.white.withOpacity(0.75)),
              ),
            )
          )),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 60, bottom: 60),
                child: Center(
                  child: Text(
                    "i'm interested in...",
                    style: Theme.of(context).primaryTextTheme.titleLarge
                  ),
                )
              ),
              // this may not be responsive on all devices. let's see lol
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.25, // this specifically with the text below it
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 30,
                  children: [
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        setState(() {
                          selected0 = !selected0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected0 ? const Color(0xFF5372FF) : const Color(0xFF262930),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1)
                        ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          const Icon(Icons.music_note_rounded, color: Colors.white, size: 50),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'arts',
                              style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(fontSize: 12, color: Colors.white)
                            )
                          )
                        ])
                      )
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        setState(() {
                          selected1 = !selected1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected1 ? const Color(0xFF5372FF) : const Color(0xFF262930),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1)
                        ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          const Icon(Icons.diversity_1_rounded, color: Colors.white, size: 50),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'cultural',
                              style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(fontSize: 12, color: Colors.white)
                            )
                          )
                        ])
                      )
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        setState(() {
                          selected2 = !selected2;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected2 ? const Color(0xFF5372FF) : const Color(0xFF262930),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1)
                        ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          const Icon(Icons.attach_money_rounded, color: Colors.white, size: 50),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'finance',
                              style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(fontSize: 12, color: Colors.white)
                            )
                          )
                        ])
                      )
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        setState(() {
                          selected3 = !selected3;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected3 ? const Color(0xFF5372FF): const Color(0xFF262930),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1)
                        ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          const Icon(Icons.gamepad_rounded, color: Colors.white, size: 50),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'gaming',
                              style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(fontSize: 12, color: Colors.white)
                            )
                          )
                        ])
                      )
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        setState(() {
                          selected4 = !selected4;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected4 ? const Color(0xFF5372FF) : const Color(0xFF262930),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1)
                        ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          const Icon(Icons.medical_services_rounded, color: Colors.white, size: 50),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'medical',
                              style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(fontSize: 12, color: Colors.white)
                            )
                          )
                        ])
                      )
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        setState(() {
                          selected5 = !selected5;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected5 ? const Color(0xFF5372FF) : const Color(0xFF262930),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1)
                        ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          const Icon(Icons.business_center_sharp, color: Colors.white, size: 50),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'startups',
                              style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(fontSize: 12, color: Colors.white)
                            )
                          )
                        ])
                      )
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        setState(() {
                          selected6 = !selected6;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected6 ? const Color(0xFF5372FF) : const Color(0xFF262930),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1)
                        ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          const Icon(Icons.volunteer_activism_rounded, color: Colors.white, size: 50),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'religious',
                              style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(fontSize: 12, color: Colors.white)
                            )
                          )
                        ])
                      )
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        setState(() {
                          selected7 = !selected7;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected7 ? const Color(0xFF5372FF) : const Color(0xFF262930),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1)
                        ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          const Icon(Icons.school_rounded, color: Colors.white, size: 50),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'research',
                              style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(fontSize: 12, color: Colors.white)
                            )
                          )
                        ])
                      )
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        setState(() {
                          selected8 = !selected8;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected8 ? const Color(0xFF5372FF) : const Color(0xFF262930),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1)
                        ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          const Icon(Icons.laptop_mac_rounded, color: Colors.white, size: 50),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'tech',
                              style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(fontSize: 12, color: Colors.white)
                            )
                          )
                        ])
                      )
                    ),
                  ]
                ),
              ),
              Text(
                'adding your interests help us generate custom event and task recommendations!',
                textAlign: TextAlign.center,
                style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(fontSize: 12, color: Colors.white.withOpacity(0.25))
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(padding: const EdgeInsets.only(bottom: 45.0), child: TextButton(
                    onPressed: () async {
                      Map<String, bool> interestsMap = {
                        'tech': selected0, 
                        'finances': selected1,
                        'startups': selected2,
                        'engineering': selected3,
                        'programming': selected4,
                        'networking': selected5,
                        'medical': selected6,
                        'gaming': selected7,
                        'ai': selected8
                      };
                      List<String> interests = [];
                      
                      interestsMap.forEach((k, v) {
                        if(v == true){
                          interests.add(k);
                        }
                      });
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return Congrats(
                            email: widget.email,
                            password: widget.email,
                            username: widget.username,
                            firstName: widget.firstName,
                            lastName: widget.lastName,
                            avatarImagePath: widget.avatarImagePath,
                            interests: interests
                          );
                        })
                      );
                    },
                    style: QFButtonStyle.medium(),
                    child: Text(
                      "add interests", 
                      style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(color: Colors.black)
                    )
                  )),
                ),
              ),
            ]),
          )
        );
      }
  //   );
  // }
}

// TODO MAKE THIS ACTUALLY WORK
// // ignore: must_be_immutable
// class InterestCard extends StatefulWidget {
//   InterestCard({
//     super.key,
//     required this.name,
//     required this.selected
//   });

//   final String name;
//   bool selected;

//   @override
//   State<InterestCard> createState() => _InterestCardState();
// }

// class _InterestCardState extends State<InterestCard> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           widget.selected = !widget.selected;
//         });
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: widget.selected ? const Color(0xFFB6CAFF).withOpacity(0.9) : const Color(0xFF262930),
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(color: Colors.white.withOpacity(0.2), width: 1)
//         ),
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           ImageIcon(AssetImage('assets/icons/interests/${widget.name}.png'), color: widget.selected ? const Color(0xFF262930) : Colors.white, size: 50),
//           Padding(
//             padding: const EdgeInsets.only(top: 5),
//             child: Text(
//               widget.name,
//               style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(fontSize: 12, color: widget.selected ? const Color(0xFF262930) : Colors.white)
//             )
//           )
//         ])
//       )
//     );
//   }
// }