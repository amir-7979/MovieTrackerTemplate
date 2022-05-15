import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/client_model.dart';

class Preferences{
    static FlutterSecureStorage storage = const FlutterSecureStorage();
   static Future<void> writeUser(UserClient userClient) async {
       storage.write(key: 'refreshToken', value: userClient.refreshToken);
       storage.write(key: 'email', value: userClient.email);
       storage.write(key: 'isDarkMode', value: userClient.isDarkMode.toString());
       storage.write(key: 'isVerified', value: userClient.isVerified.toString());
       storage.write(key: 'profileImage', value: userClient.profileImage.toString());
       storage.write(key: 'userId', value: userClient.userId);
       storage.write(key: 'username', value: userClient.username);
  }
   static Future<UserClient> readUser() async {
     Map<String, String> allValues = await storage.readAll();
     return UserClient.fromStorage(allValues['refreshToken'], allValues['username'], allValues['userId'], jsonDecode(allValues['profileImage']!), allValues['email'], allValues['isDarkMode']?.toLowerCase() == 'true', allValues['isVerified']?.toLowerCase() == 'true');
   }
   static Future<bool> userExist(){
     return storage.containsKey(key: 'refreshToken');
   }
    static void deleteUser() async {
      await storage.delete(key: 'refreshToken');
      await storage.delete(key: 'email');
      await storage.delete(key: 'isDarkMode');
      await storage.delete(key: 'isVerified');
      await storage.delete(key: 'profileImage');
      await storage.delete(key: 'userId');
      await storage.delete(key: 'username');
    }
}