import 'package:doctor_app/model/video.dart';
import 'package:doctor_app/screens/find_doctor.dart';
import 'package:doctor_app/screens/search_location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/categoris.dart';
import '../model/channel.dart';
import '../services/api_service.dart';
import '../widgets/drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  Channel? _channel;

  @override
  void initState() {
    super.initState();

    _initChannel();
  }

  _initChannel() async {
    Channel channel = await APIService.instance.fetchChannel(channelId: 'UC7HAzXWJi2EgqMuBlpJ22iQ');
    setState(() {
      _channel = channel;
    });
  }

  final List<CategoryListItems> items = [
    CategoryListItems(categoryName: 'Gynecologist', imageUrl: 'assets/images/pregnent.png', id: '1'),
    CategoryListItems(categoryName: 'Skin Specialist', imageUrl: 'assets/images/hand.png', id: '2'),
    CategoryListItems(categoryName: 'Urologist', imageUrl: 'assets/images/pregnent.png', id: '3'),
    CategoryListItems(categoryName: 'Skin Specialist', imageUrl: 'assets/images/pregnent.png', id: '4'),
  ];

  final List<CategoryListItems> hospitals = [
    CategoryListItems(categoryName: 'Jinnah Postgraduate Medical Centre', imageUrl: 'assets/images/hospitals/jpmc.jfif', id: '5'),
    CategoryListItems(categoryName: 'Jacobabad Institute of Medical Sciences', imageUrl: 'assets/images/hospitals/jims.jpg', id: '6'),
    CategoryListItems(categoryName: 'Aga Khan University Hospital', imageUrl: 'assets/images/hospitals/aga.jpg', id: '7'),
    CategoryListItems(categoryName: 'Lahore University of Management Sciences', imageUrl: 'assets/images/hospitals/lums.jpg', id: '8'),
  ];

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final userStatus = FirebaseAuth.instance.currentUser;

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: SizedBox(
          width: 150,
          child: Builder(builder: (context) {
            return TextButton(
              onPressed: () {
                // Check if the user is logged in
                if (userStatus != null) {
                  Scaffold.of(context).openDrawer();
                } else {
                  Navigator.of(context).pushNamed('/phoneAuthPage');
                }
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: userStatus != null
                  ? const Icon(
                      Icons.menu,
                      color: Colors.white,
                    )
                  : Text(
                      'Sign up',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                    ),
            );
          }),
        ),
        title: const Text(
          'Welcome',
        ),
        actions: [
          Row(
            children: [
              const Text('Location'),
              IconButton(
                icon: const Icon(Icons.arrow_drop_down),
                onPressed: () => Navigator.of(context).push(_createRoute(const LocationPage())),
              )
            ],
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'I want to book',
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context).pushNamed('/findDoctor');
                                    Navigator.of(context).push(_createRoute(const FindDoctor()));
                                  },
                                  child: Card(
                                    color: const Color.fromARGB(255, 255, 174, 98),
                                    elevation: 0,
                                    child: Column(
                                      // for label and image
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Align(alignment: Alignment.topLeft, child: Text('Doctor \nAppointment')),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomCenter,
                                          height: 150,
                                          width: 120,
                                          child: Image.asset('assets/images/doctor.png'),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ), // appiont
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(_createRoute(const FindDoctor())),
                                child: Card(
                                  color: const Color.fromARGB(255, 144, 160, 255),
                                  elevation: 0,
                                  child: Column(
                                    // for label and image
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 8),
                                              child: Text('Video \nConsultation'),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 5),
                                              child: Icon(
                                                Icons.video_chat,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        height: 150,
                                        width: 120,
                                        child: Image.asset('assets/images/doctorm.png'),
                                      )
                                    ],
                                  ),
                                ),
                              ), // video
                            ],
                          ), // 2 cards 1 for appointment and 2 for video
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Card(
                                color: const Color.fromARGB(255, 244, 244, 244),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomCenter,
                                      height: 80,
                                      width: 50,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(13.0),
                                        child: Image.asset(
                                          'assets/images/lab.png',
                                          height: 70,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const Text('Lab Test'),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Card(
                                        elevation: 0,
                                        color: const Color.fromARGB(255, 144, 160, 255),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: const [
                                              Icon(
                                                Icons.discount,
                                                size: 15,
                                              ),
                                              Text('20 %Off')
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Search for Doctors',
                                  style: Theme.of(context).textTheme.headlineSmall,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onTap: () => Navigator.of(context).push(_createRoute(const FindDoctor())),
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(color: Colors.grey),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Card(
                                  color: const Color.fromARGB(255, 245, 245, 245),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: const Color.fromARGB(255, 237, 237, 237),
                                          child: ClipOval(
                                            child: Image.asset('assets/images/maledoc2.png', width: 60, height: 60),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Assist. Prof. Dr.Ishaque'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  color: const Color.fromARGB(255, 245, 245, 245),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: const Color.fromARGB(255, 237, 237, 237),
                                          child: ClipOval(
                                            child: Image.asset('assets/images/maledoc.png', width: 60, height: 60),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Assist. Prof. Dr. Ahmed'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'I\'m looking for',
                                  style: Theme.of(context).textTheme.headlineSmall,
                                )),
                          ),
                          SizedBox(
                            height: 60,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: SizedBox(
                                    width: 200,
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: const Color.fromARGB(255, 237, 237, 237),
                                        child: ClipOval(
                                          child: Image.asset(items[index].imageUrl, width: 60, height: 60),
                                        ),
                                      ),
                                      title: Text(items[index].categoryName),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 40),
                                backgroundColor: const Color.fromARGB(255, 243, 243, 243), // set background color here
                              ),
                              child: const Text(
                                'All Specializations',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(13.0),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    'assets/images/family.jpg',
                                    width: width / 1.2,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.7),
                                              Colors.transparent,
                                            ],
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              'Healthy lifestyle',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24.0,
                                              ),
                                            ),
                                            Text(
                                              'Healthzone',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            )), // for Image
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Latest on Health'),
                              TextButton(
                                onPressed: () {},
                                child: const Text('View All'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 120,
                          child: _channel != null
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _channel!.videos!.length,
                                  itemBuilder: (context, index) {
                                    Video video = _channel!.videos![index];
                                    return SizedBox(
                                      width: 200,
                                      child: ListTile(
                                        title: ClipRRect(
                                          borderRadius: BorderRadius.circular(13.0),
                                          child: Image.network(
                                            video.thumbnailUrl,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          const ListTile(
                            leading: Icon(
                              Icons.health_and_safety,
                              color: Colors.green,
                              size: 40,
                            ),
                            title: Text('Have Corporate Insurance?'),
                          ),
                          Text(
                            '• Free Unlimited Video Consultations',
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 40),
                              backgroundColor: const Color.fromARGB(255, 255, 174, 98), // set background color here
                            ),
                            child: const Text(
                              'Connect Now',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: hospitals.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 200,
                              child: ListTile(
                                title: ClipRRect(
                                  borderRadius: BorderRadius.circular(13.0),
                                  child: SizedBox(
                                    height: 100,
                                    width: 120,
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          hospitals[index].imageUrl,
                                          width: width / 1.2,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            padding: const EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [
                                                  Colors.black.withOpacity(0.8),
                                                  Colors.transparent,
                                                ],
                                              ),
                                            ),
                                            child: Text(
                                              hospitals[index].categoryName,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      'v.0.0.1',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
