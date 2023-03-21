import 'dart:io';

import 'package:firebase_demo/Home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? _imageFile;
  String _uploadMessage = '';
  bool _isUploading = false;

  final picker = ImagePicker();

  Future getImage({ImageSource source = ImageSource.camera}) async {
    //await showImageSourceDialog();
    
      await showImageSourceDialog();
      final pickedFile = await picker.getImage(source: source);

      setState(() {
        _imageFile = File(pickedFile!.path);
      });
    }
  

  Future uploadImage() async {
    setState(() {
      _isUploading = true;
    });

    try {
      // Get the application documents directory
      final appDocDir = await getApplicationDocumentsDirectory();

      // Create the file path and reference
      final filePath =
          "${appDocDir.absolute}/images/${DateTime.now().millisecondsSinceEpoch}.jpg";
      final storageRef = FirebaseStorage.instance.ref().child(filePath);

      // Create the file metadata
      final metadata = SettableMetadata(contentType: "image/jpeg");

      // Upload file and metadata to the path
      final uploadTask = storageRef.putFile(_imageFile!, metadata);

      // Listen for state changes, errors, and completion of the upload
      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
        final progress =
            100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
        setState(() {
          _uploadMessage = "Upload is $progress% complete.";
        });
      }, onError: (error) {
        setState(() {
          _uploadMessage = "Error uploading image: $error";
          _isUploading = false;
        });
      }, onDone: () {
        setState(() {
          _isUploading = false;
          _uploadMessage = "Image uploaded successfully!";
          _imageFile = null;
          //_isUploading = false;
          
        });
      });
    } catch (e) {
      setState(() {
        _uploadMessage = "Error uploading image: $e";
        _isUploading = false;
      });
    }
  }

  Future<void> showImageSourceDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('Camera'),
                  onTap: () {
                    Navigator.of(context).pop();
                    getImage(source: ImageSource.camera);
                    //getImage(source: ImageSource.gallery);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Gallery'),
                  onTap: () {
                    Navigator.of(context).pop();
                    getImage(source: ImageSource.gallery);
                    //getImage(source: ImageSource.camera); // fixed this line
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(_imageFile!)
                : Text("No image selected."),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: getImage,
              child: Text("Select Image"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed:
                  _imageFile == null || _isUploading ? null : uploadImage,
              child: _isUploading
                  ? CircularProgressIndicator()
                  : Text("Upload Image"),
            ),
            SizedBox(height: 16),
            _uploadMessage != null ? Text(_uploadMessage) : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
