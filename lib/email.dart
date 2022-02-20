import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmailApp extends StatefulWidget {
  const EmailApp({Key? key}) : super(key: key);

  @override
  _EmailAppState createState() => _EmailAppState();
}

class _EmailAppState extends State<EmailApp> {
  final sendto = TextEditingController();
  final sendsubject = TextEditingController();
  final sendmessage = TextEditingController();
  final emailcontroller = TextEditingController();

  Widget buildTextField(
          {required String title,
          required TextEditingController controller,
          int maxline = 1}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: controller,
            maxLines: maxline,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          )
        ],
      );

  Future Sendemail(
      {required String name,
      required String email,
      required String subject,
      required String message}) async {
    // const service_id = 'service_o159jcd';
    // ignore: constant_identifier_names
    // const template_id = 'template_mqgcbbr';

    // ignore: constant_identifier_names
    // const user_id = 'user_4VKUK4GVaSc7e0A7C3uzl';
    try {
      var url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      final response = await http.post(url,
          headers: {
            'origin': 'http:localhost',
            'Content-Type': 'application/json'
          },
          body: json.encode({
            'service_id': 'default_service',
            'template_id': 'template_mqgcbbr',
            'user_id': 'user_4VKUK4GVaSc7e0A7C3uzl',
            'template_params': {
              'from_name': 'Danyal',
              'subject': 'Test Subject',
              'message': 'This is ,essage...',
              'user_email': 'rajadanyal.fui@gmail.com'
            }
          }));
      print(response.body);
    } catch (error) {
      print('[SEND FEEDBACK MAIL ERROR]');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildTextField(title: 'Name', controller: sendto),
            const SizedBox(
              height: 16,
            ),
            buildTextField(title: 'Email', controller: emailcontroller),
            const SizedBox(
              height: 16,
            ),
            buildTextField(title: 'Subject', controller: sendsubject),
            const SizedBox(
              height: 16,
            ),
            buildTextField(
                title: 'Message', controller: sendmessage, maxline: 8),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () => Sendemail(
                  name: sendto.text.toString(),
                  email: emailcontroller.text.toString(),
                  subject: sendsubject.text.toString(),
                  message: sendmessage.text.toString()),
              child: const Text("Send"),
            ),
          ],
        ),
      ),
    );
  }
}
