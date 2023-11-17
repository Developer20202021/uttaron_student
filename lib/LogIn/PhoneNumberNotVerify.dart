
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uttarons/DeveloperAccess/DeveloperAccess.dart';
import 'package:uttarons/LogIn/OtpPage.dart';

class PhoneNumberNotVerified extends StatefulWidget {

  final StudentEmail;
  final StudentPhoneNumber;




  const PhoneNumberNotVerified({super.key, required this.StudentEmail, required this.StudentPhoneNumber});

  @override
  State<PhoneNumberNotVerified> createState() => _PhoneNumberNotVerifiedState();
}

class _PhoneNumberNotVerifiedState extends State<PhoneNumberNotVerified> {






bool loading = false;

var rng = new Random();
var code = Random().nextInt(900000) + 100000;






Future ResendOTPSend() async{


                setState(() {

                  loading = true;
                  
                });



      var OtpMsg ="Your OTP ${code} Uttaron. InanSoft";

                  final response = await http
                      .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=${widget.StudentPhoneNumber}&message=${OtpMsg}'));

                  if (response.statusCode == 200) {




                    final docUser = FirebaseFirestore.instance.collection("StudentInfo").doc(widget.StudentEmail);

                  final UpadateData ={

                    "OtpCode":code.toString()

                
                };





                // user Data Update and show snackbar

                  docUser.update(UpadateData).then((value) => setState((){


                    setState(() {
                      loading = false;
                      // resend = true;
                    });



                    print("Done");


                    Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(StudentPhoneNumber: widget.StudentPhoneNumber, StudentEmail: widget.StudentEmail)),);

                   

               


                       final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'OTP sent',
                      message:
                          'OTP sent',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);



                  })).onError((error, stackTrace) => setState((){

                    print(error);

                  }));






                    print("");
                    
                  } else {

                    setState(() {
                      loading = false;
                    });
                    // If the server did not return a 200 OK response,
                    // then throw an exception.
                    throw Exception('Failed to load album');
                  }





}
















  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorName().appColor),
        automaticallyImplyLeading: false,
        title: const Text("Phone No Not Verified",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: SingleChildScrollView(child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text("আপনার Phone Number টি Verify করেননি। তাই আপনাকে App এর ভিতরে প্রবেশের অনুমতি দেওয়া যাচ্ছে না। দয়া করে Verify Button এ Click করুন এবং আপনার Phone Number টি Verify করুন।")),
          ),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(width: 80, child:TextButton(onPressed: () async{
                  
                  
                        setState(() {
                          loading = true;
                        });
                  
                  
                        ResendOTPSend();
                  
                  
                  
                  
                   
                  
                  
                  
                  
                  
                      }, child: Text("Resend", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                       
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.pink.shade400),
            ),),),
                  
                  
                  
                  
                  
                  
                  
                  
                    ],
                  ),
          ),





        ],
      )));

  }
}