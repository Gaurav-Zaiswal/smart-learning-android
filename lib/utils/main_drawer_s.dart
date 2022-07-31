import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aithon/api/api_service.dart';
import 'package:aithon/utils/secure_storage.dart';

class MainDrawerStudent extends StatelessWidget {
  MainDrawerStudent({ Key? key }) : super(key: key);
  
  final APIService _apiService = APIService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical:30),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children:const [
                  Text(
                    'Welcome back!',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              'Profile',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Get.toNamed("/profile-student"); // navigate to profile 
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text(
              'For you', // recommendation
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Get.toNamed("/recommendation"); //navigate to recommendation page
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              UserSecureStorage.removeUserToken("token");
              // remove data preferences stored
              _apiService.removeUserDetails();
              Get.offAllNamed("/splash");
            },
          ),
        ],
      ),
    );
  }
}