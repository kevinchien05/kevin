import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pertemuan10/camera.dart';
import 'package:pertemuan10/contact.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: contact, child: Text('Contact')),
            ElevatedButton(onPressed: camera, child: Text('Camera')),
          ],
        ),
      ),
    );
  }

  void contact() async {
    if (await Permission.contacts.status.isGranted){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactScreen()));
    } else {
      var status = await Permission.contacts.request();
      print(status);
      if(status == PermissionStatus.granted){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactScreen()));
      } else if (status == PermissionStatus.permanentlyDenied){
        openAppSettings();
      }
    }
  }

  void camera() async {
    if(await Permission.camera.status.isGranted){
      Navigator.of(context).push(MaterialPageRoute(builder: (context )=> CameraScreen()));
    } else {
      var status = await Permission.camera.request();
      print(status);
      if(status == PermissionStatus.granted){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CameraScreen()));
      } else if(status == PermissionStatus.permanentlyDenied){
        openAppSettings();
      }
    }
  }
}
