import 'dart:io';

import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../controllers/home_controller.dart';
import 'package:http/http.dart' as http;

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  static List myHiveData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      /*body: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (context, index) {
             // var listitem = controller.getHiveData()[index];
              return ListTile(
                //title: Text(listitem['name'].toString()),
               // subtitle: Text(listitem['email']),
                trailing: Row(),
              );
            },

          )),*/
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //  show_bottom_sheet(this);
          loginAipi();
          controller.showForm(null, context);
        },
        label: Text('Add'),
        icon: Icon(Icons.add),
      ),
    );
  }

  getHiveData() {
    //   myHiveData = HiveFunctions.getAllUsers();
  }

  void show_bottom_sheet(context) {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.all(15),
            ));
  }

  Future<void> loginAipi() async {
    //final url = 'http://10.88.29.179:8080/api/Stock/LoginUser'; //local
    final url = 'http://117.239.177.202/trackntraceapi/api/Stock/LoginUser'; //prod

    final body = {
      "UserID": 'op11003',
      "Password": EncryptionService.encryptUsingMD5('test@123')
    };
    var headers = {'Content-Type': 'application/json'};
    var payload = json.encode(body);
    final response = await http.post(
      Uri.parse(url),
      body: payload,
      headers: headers,
    ).timeout(const Duration(seconds: 180));

    if (response.statusCode == 200) {
      print('Response_data: ${response.body}');
    } else {
      HomeController.logger.d('${response.statusCode}');
      print('Error: ${response.statusCode}');
    }
  }
}

class EncryptionService {
  static String encryptUsingMD5(String value) {
    var bytes = utf8.encode(value); // data being hashed
    var digest = md5.convert(bytes);
    return digest.toString();
  }
}
