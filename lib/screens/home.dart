import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SearchController searchController = SearchController();
  String eventSearchKey = '';
  
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.075),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Padding(
            padding: EdgeInsets.only(top: deviceSize.height * .024),
            child: Image(
              image: AssetImage('assets/logos/foodality_text_logo.png'),
              width: deviceSize.width / 3.5
            )
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 15),),
          SearchBar(
            overlayColor:
                const WidgetStatePropertyAll(Colors.transparent),
            backgroundColor:
                const WidgetStatePropertyAll(Color(0xFFF4F5F7)),
            controller: searchController,
            elevation: const WidgetStatePropertyAll(0),
            hintStyle: WidgetStatePropertyAll(Theme.of(context)
                .primaryTextTheme
                .bodyMedium!
                .copyWith(color: const Color(0xFF8A8A8A))),
            hintText: 'discover your foodality',
            leading: const Icon(Icons.search,
                color: Color(0xFF272727), size: 24),
            trailing: eventSearchKey.isNotEmpty
                ? [
                    IconButton(
                      icon: const Icon(Icons.cancel,
                          color: Color(0xFF272727), size: 24),
                      onPressed: () {
                        setState(() {
                          searchController.text = '';
                          eventSearchKey = '';
                        });
                      },
                    )
                  ]
                : null,
            textStyle: WidgetStatePropertyAll(Theme.of(context)
                .primaryTextTheme
                .bodyMedium!
                .copyWith(color: const Color(0xFF8A8A8A))),
            onChanged: (value) {
              setState(() {
                eventSearchKey = value;
              });
            },
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 15),),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 5
            ),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: 8,
            itemBuilder:(context, index) {
              return Column(children:[
                ClipRRect(
                borderRadius: BorderRadius.circular(20),
                  child: Image.network('https://placehold.co/150/png', fit: BoxFit.fill)
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 1)),
                const Text('Cafe Kacao',),
              ]);
            },
          )
        
        ])
      )
    );
  }
}