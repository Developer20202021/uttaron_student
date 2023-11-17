
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:uttarons/DeveloperAccess/DeveloperAccess.dart';
import 'package:uttarons/HomePage/HomePage.dart';
import 'package:uttarons/LogIn/AdminNotApprove.dart';
import 'package:uttarons/LogIn/EmailNotVerified.dart';
import 'package:uttarons/LogIn/PhoneNumberNotVerify.dart';
import 'package:uttarons/Settings/ResetPassword.dart';





class AdminLogInScreen extends StatefulWidget {
  const AdminLogInScreen({super.key});

  @override
  State<AdminLogInScreen> createState() => _AdminLogInScreenState();
}

class _AdminLogInScreenState extends State<AdminLogInScreen> {
  TextEditingController myEmailController = TextEditingController();
  TextEditingController myPassController = TextEditingController();

bool _passVisibility = true;

   var createUserErrorCode = "";

   bool loading = false;

   
  String errorTxt = "";

   // hive database

  final _mybox = Hive.box("uttaronBox");



  Future StudentLogOut () async{

    
                          FirebaseAuth.instance
                            .authStateChanges()
                            .listen((User? user) async{
                              if (user == null) {
                                
                   
                                print('User is currently signed out!');
                              } else {
                                print('User is signed in!');
                                await FirebaseAuth.instance.signOut();
                                          
            
                              }
                            });
                  



  }







   @override
  void initState() {
    // TODO: implement initState
    FlutterNativeSplash.remove();

    StudentLogOut();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    FocusNode myFocusNode = new FocusNode();
 

    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
      
      systemOverlayStyle: SystemUiOverlayStyle(
      // Navigation bar
      statusBarColor: ColorName().appColor, // Status bar
    ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        automaticallyImplyLeading: false,
        title: const Text("Log In",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: SingleChildScrollView(

        child: loading?Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: const Color(0xFF1A1A3F),
                        secondRingColor: Theme.of(context).primaryColor,
                        thirdRingColor: Colors.white,
                        size: 100,
                      ),
                    ),
              ): AutofillGroup(
                child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                


                
                    
                   errorTxt.isNotEmpty?  Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
             
                         color: Colors.red.shade400,
                         
                         
                         child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${errorTxt}", style: TextStyle(color: Colors.white),),
                         )),
             ):Text(""),




            
          SizedBox(height: 15,),




                      
              
     
              
                          
                
                // Center(
                //   child: Lottie.asset(
                //   'lib/images/animation_lk8fkoa8.json',
                //     fit: BoxFit.cover,
                //     width: 200,
                //     height: 200
                //   ),
                // ),
                          
                          // SizedBox(
                          //           height: 20,
                          //         ),


                           
                    Center(
                      child: Lottie.asset(
                      'lib/images/animation_lk8fkoa8.json',
                        fit: BoxFit.cover,
                        width: 200,
                        height: 200
                      ),
                    ),
            
            SizedBox(
                      height: 20,
                    ),
                          
                          
                          
                TextField(
                  autofillHints: [AutofillHints.email],
                  
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Email',
                       labelStyle: TextStyle(
                      color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                          ),
                      hintText: 'Enter Your Email',
                          
                      //  enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                      //     ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                          ),
                      
                      
                      ),
                  controller: myEmailController,
                ),
                          
                          
                          
                          
                SizedBox(
                  height: 20,
                ),
                          
                          
                          
                          
                          
                TextField(
                   autofillHints: [AutofillHints.password],
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _passVisibility,
                  obscuringCharacter:"*",
                  decoration: InputDecoration(

                  suffixIcon: IconButton(
                      icon: _passVisibility
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        _passVisibility = !_passVisibility;

                        setState(() {});
                      },
                    ),
                    
                      border: OutlineInputBorder(),
                      labelText: 'Enter Password',
                       labelStyle: TextStyle(
                      color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                          ),
                      hintText: 'Enter Your Password',
                      //  enabledBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                      //   ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                        ),

                        
                      
                      
                      ),
                  controller: myPassController,
                ),
                          
                SizedBox(
                  height: 10,
                ),
                          
                          
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 150, child:TextButton(onPressed: () async{
              
              
                      setState(() {
                        loading = true;
                      });
              
                      try {
                        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: myEmailController.text.trim(),
                          password: myPassController.text.trim()
                        );
              
                        var userName = credential.user!.displayName;
                        var userEmail = credential.user!.email;
                        var userVerified = credential.user!.emailVerified;
              
              
                   
              
              
                    List  AllData = [];
              
              
                      CollectionReference _collectionRef =
                        FirebaseFirestore.instance.collection('StudentInfo');
              
                        Query query = _collectionRef.where("StudentEmail", isEqualTo: myEmailController.text.trim());
                      QuerySnapshot querySnapshot = await query.get();
              
                  
                        // Get docs from collection reference
                       
              
                        // Get data from docs and convert map to List
                        AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
                        setState(() {
                          
                          AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
                        });
              
              
              
              
              
                        print(AllData);
                          
              
              
                 

                 if (AllData[0]["PhoneVerify"]=="true") {




                    if (AllData.isNotEmpty && AllData[0]["AdminApprove"] == "true") {

                        _mybox.delete("StudentPhotoUrl");
                        _mybox.delete("StudentName");
                        _mybox.delete("StudentEmail");
                        _mybox.delete("StudentType");
                        _mybox.delete("DueAmount");
                        _mybox.delete("CourseFee");


                      _mybox.put("StudentPhotoUrl",AllData[0]["StudentImageUrl"]);
                      _mybox.put("StudentName", AllData[0]["StudentName"]);
                      _mybox.put("StudentEmail", AllData[0]["StudentEmail"]);
                      _mybox.put("StudentType", AllData[0]["StudentType"]);
                      _mybox.put("DueAmount", AllData[0]["DueAmount"]);
                      _mybox.put("CourseFee", AllData[0]["CourseFee"]);
              
                      
              
              
                             Navigator.push(context, MaterialPageRoute(builder: (context) => StudentHomePage(indexNumber: "")),);
              
                             setState(() {
                            loading=false;
                          });
              
                      
                    }

                    
                    else{
              
                      setState(() {
                            loading=false;
                          });
              
              
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminNotApprove()),);
              
              
                    }





                   
                 } else {




                          setState(() {
                            loading=false;
                          });
              
              
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneNumberNotVerified(StudentEmail: AllData[0]["StudentEmail"], StudentPhoneNumber: AllData[0]["StudentPhoneNumber"])),);






                   
                 }
              
              
              
 
              
              
                      } on FirebaseAuthException catch (e) {




               

                        setState(() {

                          errorTxt = e.code.toString();
                          
                        });


                                 
                  setState(() {
                    loading = false;
                  });
                     



                      }
              
              
              
              
              
              
              
                    }, child: Text("Log in", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                     
                        backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
                      ),),),
              
             
              
              
              
              
              
                  ],
                ),




                SizedBox(
                  height: 50,
                ),



                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [


                        Container(width: 150, child:TextButton(onPressed: (){
              
                       Navigator.push(
                    context,
              
                           MaterialPageRoute(builder: (context) => const ResetPassword()),
                  );
              
              
              
              
                }, child: Text("Reset Password", style: TextStyle(color: Colors.white, fontSize: 13),), style: ButtonStyle(
                     
                        backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
                      ),),),
              
              
              



                  ],
                )






                          
                          
                          
                          ],
                        ),
                      ),
              ),
        ),
      
      
    );
  }
}



class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xff8f00ff);
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}