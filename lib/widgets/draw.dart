import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/views/auth/sign_in_screen.dart';
import 'package:medical_app/views/landing_screen.dart';
import 'package:medical_app/views/news/news_screen.dart';
import 'package:medical_app/widgets/colors.dart';

import '../blocs/auth/auth_bloc.dart';

// ignore: camel_case_types
class buildDrawer extends StatelessWidget {
  const buildDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // LOGOUT FUNC
    void _logout(context) {
      BlocProvider.of<AuthBloc>(context).add(
        SignOutRequested(),
      );
    }

    void _buildShowLogoutDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: Image.asset(
              'assets/icons/sad.png',
              width: 44,
              height: 44,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: AppColors.highLightColor,
            title: const Text(
              'Are you leaving?',
              style: TextStyle(
                color: AppColors.primaryColor,
              ),
            ),
            content: const Text(
              'Are you sure you want to log out?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  _logout(context);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                ),
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UnAuthenticated) {
          return const SignInScreen();
        }
        return Drawer(
          backgroundColor: AppColors.highLightColor,
          child: Column(
            children: [
              // TOP INFOMATIONS
              Container(
                width: double.infinity,
                height: 240,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(top: 86),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          width: 68,
                          height: 68,
                          // margin: const EdgeInsets.only(bottom: 0),
                          child: Image.network(
                            'https://i.pinimg.com/564x/ec/fd/c0/ecfdc07b30149c927956fe5bb6126e2c.jpg',
                          ),
                        ),
                      ),
                      //
                      Container(
                        margin: const EdgeInsets.only(bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Nguyen Hoang Vi",
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "0907656399",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          print('Okey, Click cai qq');
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // FUNC ICONS
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LandingScreen(),
                                ));
                              },
                              leading: const Icon(Icons.home),
                              title: const Text('Home'),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const NewsScreen(),
                                ));
                              },
                              leading: const Icon(Icons.newspaper),
                              title: const Text('Newspaper'),
                            ),
                            ListTile(
                              onTap: () {
                                print('Okey, Click cai qq');
                              },
                              leading: const Icon(Icons.shopping_bag),
                              title: const Text('My Card'),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 40,
                        thickness: 1,
                      ),
                      const ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Setting'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text('Log Out'),
                        onTap: () {
                          _buildShowLogoutDialog(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
