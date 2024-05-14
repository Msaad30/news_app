import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {

  final sendApi = "https://reqres.in/api/users";
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter Name",
                suffixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextField(
              controller: jobController,
              decoration: InputDecoration(
                  hintText: "Enter Job",
                  suffixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
              ),
            ),
          ),
          ElevatedButton(
              onPressed: (){
                sendData(
                    name: nameController.text.toString(),
                    job: jobController.text.toString()
                );
              },
              child: Text("Send To Server"))
        ],
      ),
    );
  }

  sendData({required String name, required String job}) async {
    if(name == null || job == null) {
      log("please insert data");
    } else {

      final response = await http.post(Uri.parse(sendApi),
        headers: {
          "Content-Type" : "application/json"
        },
        body: jsonEncode({
          "name": name,
          "job" : job
        })
      );

      if(response.statusCode == 201){
        Map<String, dynamic> mapData = jsonDecode(response.body);
        log(mapData.toString());
      } else {
        log(response.statusCode.toString());
      }

    }
  }
}
