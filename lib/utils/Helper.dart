

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

var APP_URL_BASE  = "http://188.166.8.72:9019/api/";
var APP_URL_FILE  = "http://188.166.8.72:9019/files/";


var skip_verification = true;

var mainColorDark = Color(0xFFd1711a);
var subColor = Color(0xFF9747FF);
var minorColor = Color(0xFF203868);
var headerColor = Color(0xFFFABA4A);
var otibeeBlue = Color(0xFF2980b9);


var mainColor = Color(0xff151515);
var bgColor = Color(0xffdfdfdf);
var popColor = Color(0xffdd1e1e);

//measurements
var smallMargin = 5.0;

void showSnackBar(BuildContext context, String message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

void logoutPerson(context) async {
  var preferences = await SharedPreferences.getInstance();
  preferences.setBool("is_user_logged_in", false);
  Navigator.pushNamedAndRemoveUntil(context, "/splash", (route) => false);
}

Future<String> getSharedPreference(String key) async {
  var preferences =  await SharedPreferences.getInstance();
  return preferences.getString(key) ?? "";
}

void savePersonInPreference(person) async {
  print("Saving person in preference");
  var preferences = await SharedPreferences.getInstance();
  preferences.setBool("is_user_logged_in", true);
  preferences.setString("user", jsonEncode(person));
  preferences.setString("user_id", "${person["id"] as int}");
  preferences.setString("user_name", person["name"] as String? ?? "");
  preferences.setString("user_email", person["email"] as String? ?? "");
  preferences.setString("user_type", person["type"] as String? ?? "");
  preferences.setString("user_phone", person["phone"] as String? ?? "");
  preferences.setString("user_address", person["address"] as String? ?? "");
  preferences.setString("user_country", person["country"] as String? ?? "");
}

void saveShopInPreference(shop) async {
  var preferences = await SharedPreferences.getInstance();
  preferences.setBool("is_shop_logged_in", true);
  preferences.setString("shop", jsonEncode(shop));
  preferences.setString("shop_id", "${shop["id"] as int}");
  preferences.setString("shop_name", shop["name"] as String? ?? "");
  preferences.setString("shop_color", shop["color"] as String? ?? "");
}

getShopFromPreference() async {
  var preferences = await SharedPreferences.getInstance();
  var shop = preferences.getString("shop");
  if(shop != null){
    return jsonDecode(shop);
  }else{
    return null;
  }
}

void saveToken(token,token_type) async {
  print("Saving person in preference");
  var preferences = await SharedPreferences.getInstance();
  preferences.setBool("is_user_logged_in", true);

  preferences.setString("token", token);
  preferences.setString("token_type", token_type);
}

String formatLaravelTime(String created_at){
  var date = DateTime.parse(created_at);
  return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
}


String formatNumberWithCommas(String number) {
  final formatter = NumberFormat('#,###');
  return formatter.format(int.parse(number));
}


computeProductDiscountPercentage( product) {
  var price = double.parse(product['price']);
  var oldPrice = product['old_price'];
  var discount = 0.0;

  if (oldPrice > price) {
    discount = ((oldPrice - price) / oldPrice) * 100;
  }

  return discount.round();

}

var boxDecoration = BoxDecoration(border: Border.all(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(5),);
InputDecoration inputDecoration(String hintText){
  return InputDecoration(
    contentPadding: const EdgeInsets.all(6),
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.normal),
    isDense: true,
    border: const OutlineInputBorder( borderSide: BorderSide.none, ), filled: false, // Needed to respect the background color
  );
}

String getDurationFromNow(String dateTimeString) {
  // Define the date format
  DateFormat dateTimeFormatter = DateFormat("yyyy-MM-dd HH:mm:ss");

  // Parse the input date string
  DateTime pastDateTime = dateTimeFormatter.parse(dateTimeString);
  DateTime now = DateTime.now();

  // Calculate the duration
  Duration duration = now.difference(pastDateTime);

  // Return appropriate time ago string
  if (duration.inDays >= 30) {
    int months = (duration.inDays / 30).floor();
    return "$months months ago";
  } else if (duration.inDays >= 1) {
    return "${duration.inDays} days ago";
  } else if (duration.inHours >= 1) {
    return "${duration.inHours} hours ago";
  } else if (duration.inMinutes >= 1) {
    return "${duration.inMinutes} minutes ago";
  } else {
    return "${duration.inSeconds} seconds ago";
  }
}




Widget artyTechButtonFilled(String text, Function() onPressed){
  return GestureDetector(
    onTap: onPressed,
    child: Container(
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(13),
        margin: EdgeInsets.all(smallMargin),
        child: Center(child: Text(text, style: TextStyle( color: Colors.white,fontWeight: FontWeight.bold, fontSize: 17),))),
  );
}

Widget artyTechButtonOvalFilled(String text, Function() onPressed){
  return GestureDetector(
    onTap: onPressed,
    child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: mainColor,
          border: Border.all(color: mainColor, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.all(10),
        child: Text(text, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)),
  );
}

artyTechPickPicture( BuildContext context, Function(String) onSuccess) async {

      /*
        <activity
            android:name="com.yalantis.ucrop.UCropActivity"
            android:screenOrientation="portrait"
            android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>

            //add ios permissions
            */

      finishPicking(String path) async {
        if(path == ""){
          onSuccess("");
          return;
        }

        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          uiSettings: [
            AndroidUiSettings( toolbarTitle: 'Cropper', toolbarColor: mainColor, toolbarWidgetColor: Colors.white, aspectRatioPresets: [CropAspectRatioPreset.square]),
            IOSUiSettings( title: 'Cropper', aspectRatioPresets: [CropAspectRatioPreset.square] ),
          ],
        );

        if (croppedFile != null) {
          onSuccess(croppedFile.path);
        } else {
          onSuccess("");
        }

      }

      final ImagePicker _picker = ImagePicker();

      showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Take a Picture'),
                  onTap: () async {
                    Navigator.pop(context);
                    final XFile? image =
                    await _picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      finishPicking(image.path);
                    } else {
                      finishPicking("");
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Choose from Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      finishPicking(image.path);
                    } else {
                      finishPicking("");
                    }
                  },
                ),
              ],
            ),
          );
        },
      );
    }


Widget artyTechTextInput(String text,  Function(String) onSaved,{ IconData? prefixIcon, keyboardType = TextInputType.text}){
  return Container(
    margin: EdgeInsets.all(smallMargin),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
          child: Text("$text", style: TextStyle(color: mainColor, fontSize: 15, fontWeight: FontWeight.bold),),
        ),
        Container(
          decoration: boxDecoration,
          width: double.infinity,
          child: TextFormField(
            decoration: inputDecoration("Type $text here").copyWith(
              prefixIcon: prefixIcon != null ? Icon(prefixIcon,) : null,
            ),
            keyboardType: keyboardType,
            onSaved: (value){
              onSaved(value!);
            },
          ),
        ),
      ],
    ),
  );
}

Widget artyTechTextArea(String text,  Function(String) onSaved){
  return Container(
    height: 100,
    margin: EdgeInsets.all(smallMargin),
    decoration: boxDecoration,
    width: double.infinity,
    child: TextFormField(
      
      maxLines: 5,
      decoration: inputDecoration(text),
      onSaved: (value){
        onSaved(value!);
      },
    ),
  );
}

Widget artyTechErrorWidget(String text){
  return Center(child: Text(text, style: TextStyle(color: Colors.red),),);
}

Widget artyTechButtonOvalStroke(String text, Function() onPressed){
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: mainColor, width: 2),
      ),
      padding: EdgeInsets.all(10),
      child: Text(text, style: TextStyle(color: mainColor, fontWeight: FontWeight.bold, fontSize: 16),), alignment: Alignment.center,),
  );
}


String requestFile(String path){
  if(path.startsWith("http")){
    return path;
  }
  return APP_URL_FILE + path;
}

Future<void> requestAPI( String path, data, Function(bool) onProgress, Function(dynamic) onSuccess, Function(dynamic) onError, {String method = "POST"}) async {
  var dio;
  var full_path = "";

  //if path starts with http
  if (path.startsWith("http")) {
    full_path = path;
  } else {
    full_path = APP_URL_BASE + path;
  }

  var pref = await SharedPreferences.getInstance();
  var token = pref.getString("token") ?? "";
  var options = Options(
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
    headers: {
      "Authorization": "Bearer $token",
    },);

  try {
    onProgress(true);
    if (method == "POST") {
      dio = Dio().post(
        full_path, data: FormData.fromMap(data), options: options,);
    } else if (method == "GET") {
      dio = Dio().get(full_path, queryParameters: data, options: options);
    } else if (method == "PUT") {
      dio = Dio().put(full_path, data: data, options: options);
    } else if (method == "DELETE") {
      dio = Dio().delete(full_path, data: data, options: options);
    }

    var response = await dio;

      //print(response.data);
      onProgress(false);
      print(response.data);
      onSuccess(response.data);

  } on DioException catch (error) {
    onProgress(false);
    //print(error.message);
    print(error.type);
    print(error.response?.data);
    onError(error.response?.data);

  }
}

Color hexToColor(String color) {
  String hexColor = color.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor; // Add default alpha value
  }
  return Color(int.parse(hexColor, radix: 16));
}

BoxDecoration borderBoxDecoration(){
  return BoxDecoration(
    border: Border.all(color: Colors.grey, width: 1),
    borderRadius: BorderRadius.circular(5),
  );
}

helperSelectDate(BuildContext context, Function(String) onDate ) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );

  if (pickedDate != null) {
    String _date = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
    onDate(_date);
  }
}
