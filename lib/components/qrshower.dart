


import 'dart:io';
import 'dart:typed_data';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;



String qrData = "";

class QRShower extends StatefulWidget{

  QRShower(String data){
    qrData = data;
  }

  @override
  State<StatefulWidget> createState() {
    return QRShowerState();
  }

}

class QRShowerState extends State<QRShower>{
  Future<Directory> _getDownloadsPath =
      DownloadsPathProvider.downloadsDirectory;
  Uint8List _imageFile;

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                child: Text('Save QR code', style: TextStyle(color: Colors.white),),
                color: Colors.lightGreen,
                onPressed: () async{

                  screenshotController
                      .capture(delay: Duration(milliseconds: 10))
                      .then((Uint8List image) async {
                    _imageFile = image;
                    onCheckPermission();
                  }

                  ).catchError((onError) {
                    print(onError);
                  });



                },
              ),
              Screenshot(
                controller: screenshotController,
                child: PrettyQr(
                    image: NetworkImage("https://i.ibb.co/TqSqLS9/forest-1.png"),
                    typeNumber: 15,
                    size: 350,
                    data: qrData.trim(),
                    roundEdges: true
                ),
              ),
            ],
          )
      )
    );
  }
  void createSave() async{
    final image = pw.MemoryImage(
      _imageFile,
    );
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Image(image),
        ),
      ),
    );
    final file = await _localFile;
    await file.writeAsBytes(await pdf.save(),flush: true);
   

  }
  void onCheckPermission() async{
    var status = await Permission.storage.status;
    if(status.isDenied || status.isUndetermined){
      if(await Permission.storage.isPermanentlyDenied){
        openAppSettings();

      }else{
        var status1 = await Permission.storage.request();
        if(status1.isGranted){

          createSave();
        }
      }

    }else{

      createSave();
    }
  }
  Future<File> get _localFile async {

    final path=await _localPath;

    return File('$path/counter.pdf');
  }

  Future<String> get _localPath async {

    final downloadsDir = await _getDownloadsPath;

    return downloadsDir.path;
  }

}

