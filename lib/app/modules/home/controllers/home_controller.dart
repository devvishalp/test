import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../data/hive_class/HiveFunctions.dart';

class HomeController extends GetxController {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  final count = 0.obs;
  static List myHiveData = [];
 static late Logger logger;
  @override
  void onInit() {
    super.onInit();
    logger = Logger(printer: PrettyPrinter());
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    myHiveData = HiveFunctions.getAllUsers();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // dialog box to create or update the data in hive
  void showForm(int? itemKey, context) async {
    // itemKey == null -> create new item
    // itemKey != null -> update an existing item
/*     if (itemKey != null) {
       // To find the existing item
       // in our local database
       final existingItem =
       myHiveData.firstWhere((element) => element['key'] == itemKey);
       _nameController.text = existingItem['name'];
       _emailController.text = existingItem['email'];
     }*/

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  top: 15,
                  left: 15,
                  right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    itemKey == null ? 'Create New' : 'Update',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  )),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(hintText: 'Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Email'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {

                      print('input_filed:${_nameController.text}');
                      // Save new item
                      if (itemKey == null) {
                        HiveFunctions.createUser({
                          "email": _emailController.text,
                          "name": _nameController.text
                        });

                      }
                      // update an existing item
                         if (itemKey != null) {
                     HiveFunctions.updateUser(itemKey, {
                       "email": _emailController.text,
                       "name": _nameController.text
                     });
                   }
                      // Clear the text fields
                      _nameController.text = '';
                      _emailController.text = '';

                      Navigator.of(context).pop(); // Close the bottom sheet
                      // To refresh the Data stored in Hive after updation
                      List list = HiveFunctions.getAllUsers();
                      if(list.length>0){
                        print('listofdata${list.length}');
                      }

                    },
                    child: Text(itemKey == null ? 'Create New' : 'Update'),
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            ));
  }
  List getHiveData() {
    myHiveData = HiveFunctions.getAllUsers();
    return myHiveData;

  }
  void increment() => count.value++;
}
