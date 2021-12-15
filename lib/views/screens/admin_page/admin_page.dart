import 'dart:math';

import 'package:flutter/material.dart';
import 'package:madrasah_app/globals/controllers/auth_controller.dart';
import 'package:madrasah_app/views/route_management/route_name.dart';
import 'package:madrasah_app/views/styles/colors.dart';
import 'package:madrasah_app/views/styles/styles.dart';

import '../../../constants.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authStateProvider = AuthController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Section',
            style: TextStyle(
              color: CResources.black,
            )),
        actions: [
          TextButton(
              onPressed: () {
                // Methods.showLoadingIndicator(
                //     context: context,
                //     workTodo: Provider.of<AuthState>(context, listen: false)
                //         .logOut());
              },
              child: Text(
                'Log out',
                style: TextStyle(color: CResources.red),
              ))
        ],
        leading: null,
        centerTitle: true,
        shadowColor: CResources.blueGrey,
        backgroundColor: CResources.lightGrey,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: size(context).height * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CResources.teal.withOpacity(0.1),
                          image: DecorationImage(
                              image: NetworkImage(Images.girlProfilePicture),
                              fit: BoxFit.cover),
                          gradient: RadialGradient(
                              stops: [0.2, 0.7],
                              colors: [CResources.black, CResources.orange]),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Admin',
                                style: TextStyle(
                                    color: CResources.red,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Fonts.monserrat),
                              ),
                              Text(
                                authStateProvider
                                        .currentUserLocal?.displayName ??
                                    'User',
                                style: TextStyle(
                                    fontFamily: Fonts.openSans,
                                    fontSize: 25,
                                    shadows: [
                                      Shadow(
                                          color:
                                              CResources.black.withOpacity(0.3),
                                          offset: Offset(0, 2))
                                    ],
                                    fontWeight: FontWeight.bold),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                authStateProvider.currentUserLocal?.email ??
                                    'User',
                                style: TextStyle(
                                    fontFamily: Fonts.openSans,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      tileColor: CResources.black.withOpacity(0.1),
                      title: Text(
                        'Edit or post a notice',
                        style: TextStyle(fontFamily: Fonts.openSans),
                      ),
                      trailing: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ], shape: BoxShape.circle, color: CResources.white),
                        child: Transform.rotate(
                          child: Icon(Icons.arrow_back),
                          angle: pi,
                        ),
                      ),
                      // ),
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouteName.editableNoticeList);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                        tileColor: CResources.black.withOpacity(0.1),
                        title: Text(
                          'Add a student',
                          style: TextStyle(fontFamily: Fonts.openSans),
                        ),
                        trailing: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ], shape: BoxShape.circle, color: CResources.white),
                          child: Icon(Icons.person_add),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
