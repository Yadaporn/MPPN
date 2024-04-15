import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_farm_app/screens/profile_page.dart';
import '../../animations/fade_in.dart';
import '../../widgets/app_card.dart';
import '../../widgets/increasing_text.dart';
import '../../widgets/progress_with_text.dart';
import '../profile_page.dart';


class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    if (auth.currentUser != null)
    {
      user= auth.currentUser;
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = (MediaQuery.sizeOf(context).width / 2) - 35;
    return Scaffold(
      appBar: AppBar(
        title: const Text('MPPN 2024'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () async{
            await FirebaseAuth.instance.signOut();
            // Navigator.pop(context);
            Navigator.pushNamed(context, '/');
          },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 70),
            FadeInAnimation(
              delay: 1,
              child: Row(
                children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tue 24',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Welcome ${user?.displayName}",
                        style: TextStyle(fontSize: 34),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                    ],

                  ),
                  const Spacer(),
                  GestureDetector(
                    onLongPress: () {
                      log('triggered');
                      setState(() {});
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => const ProfilePage(),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 70,
                      width: 70,
                      child: Hero(
                        tag: const Key('image'),
                        child: Container(
                          decoration: const ShapeDecoration(
                            shape: StarBorder(
                              innerRadiusRatio: .9,
                              pointRounding: .2,
                              points: 10,
                            ),
                            image: DecorationImage(
                              image: AssetImage('images/model.jpg'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInAnimation(
                        delay: 1.5,
                        child: AppCard(
                          height: 250,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "TEMP",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Image.asset(
                                      'images/temp.png',
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                              const Expanded(
                                child: ProgressWithText(
                                  value: 2232,
                                  indicatorValue: .78,
                                  title: 'celcius',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      FadeInAnimation(
                        delay: 2,
                        child: AppCard(
                          height: w,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Sleep",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Iconsax.moon,
                                    color: Colors.deepPurple,
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IncreasingText(
                                      7.21,
                                      isSingle: false,
                                      style: TextStyle(fontSize: 28),
                                    ),
                                    Text(
                                      "hours",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      FadeInAnimation(
                        delay: 2.5,
                        child: AppCard(
                          height: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text("Water"),
                                  const Spacer(),
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Image.asset(
                                      'images/icons/waterdrop.png',
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Center(
                                  child: Image.asset(
                                    'images/icons/glass-of-water.png',
                                    height: 50,
                                  ),
                                ),
                              ),
                              const IncreasingText(
                                2,
                                isSingle: true,
                                style: TextStyle(
                                  fontSize: 32,
                                ),
                              ),
                              const Text(
                                "bottles",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      FadeInAnimation(
                        delay: 3,
                        child: AppCard(
                          height: 250,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "TEMP",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Image.asset(
                                      'images/temp.png',
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                              const Expanded(
                                child: ProgressWithText(
                                  value: 2232,
                                  indicatorValue: .78,
                                  title: 'steps',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      FadeInAnimation(
                        delay: 3.5,
                        child: AppCard(
                          height: w,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Sleep",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Iconsax.moon,
                                    color: Colors.deepPurple,
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IncreasingText(
                                      7.21,
                                      isSingle: false,
                                      style: TextStyle(fontSize: 28),
                                    ),
                                    Text(
                                      "hours",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                const Spacer(),
                SizedBox(
                  width: w,
                  child: Column(
                    children: [
                      FadeInAnimation(
                        delay: 1.5,
                        child: AppCard(
                          height: 300,
                          color: Colors.deepPurple,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    "Heart",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Iconsax.heart, color: Colors.white),
                                ],
                              ),
                              Expanded(
                                child: Image.asset(
                                  'images/graph.png',
                                  color: Colors.white,
                                ),
                              ),
                              const IncreasingText(
                                98,
                                isSingle: true,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  height: .9,
                                ),
                              ),
                              const Text(
                                "bmp",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      FadeInAnimation(
                        delay: 2,
                        child: AppCard(
                          height: 225,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Calories",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Image.asset(
                                      'images/icons/thunderbolt.png',
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                              const Expanded(
                                child: ProgressWithText(
                                  indicatorValue: .78,
                                  title: 'kcal',
                                  value: 553,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const FadeInAnimation(
                        delay: 2.5,
                        child: AppCard(
                          height: 155,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Gym",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Iconsax.speedometer5,
                                    color: Colors.deepPurple,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Text(
                                "0",
                                style: TextStyle(fontSize: 32),
                              ),
                              Text(
                                "min",
                                style: TextStyle(color: Colors.grey),
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
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}