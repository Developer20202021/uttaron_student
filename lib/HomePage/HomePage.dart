import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:uttarons/DeveloperAccess/DeveloperAccess.dart';
import 'package:uttarons/DeveloperAccess/DeveloperInfo.dart';
import 'package:uttarons/LogIn/AdminLogIn.dart';
import 'package:uttarons/Notice/AllNotice.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:uttarons/Settings/ChangePassword.dart';
import 'package:uttarons/myHistory/CourseFeeHistory.dart';
import 'package:uttarons/myHistory/ExamFeeHistory.dart';
import 'package:uttarons/myHistory/ShowAttendance.dart';
import 'package:uttarons/myHistory/StudentProfile.dart';

class StudentHomePage extends StatefulWidget {

  final indexNumber;




  const StudentHomePage({super.key, required this.indexNumber});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {




  // hive database

final _mybox = Hive.box("uttaronBox");


bool shouldScaleDown = true;


final width = 200.0;
final height = 300.0;

double firstValue = 0.25;
double secondValue = 0.25;


  List<DateTime> PresenceDate =[];

  List<DateTime> AbsenceDate = [];

  // Firebase All Customer Data Load

List  AllPresenceData = [];

int totalPresence =0;

var Dataload = "";

bool loading = false;


  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('Attendance');


Future<void> getSpecificPresenceData(String StudentEmail, String SelectedMonth) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();
          setState(() {
                loading= true;
              });

    Query query = _collectionRef.where("StudentEmail", isEqualTo: StudentEmail).where("type", isEqualTo: "presence").where("month", isEqualTo: SelectedMonth);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllPresenceData = querySnapshot.docs.map((doc) => doc.data()).toList();
     
      setState(() {
       totalPresence = AllPresenceData.length;
     });



     if (AllPresenceData.isEmpty) {

    setState(() {
      
      Dataload ="0";

      loading = false;
     });



       
     } else {


      for (var i = 0; i < AllPresenceData.length; i++) {


        var AttendanceDate = AllPresenceData[i]["Date"];

       var AttendanceSplit = AttendanceDate.toString().split("/");


       setState(() {

        PresenceDate.insert(PresenceDate.length, DateTime(int.parse(AttendanceSplit[2]), int.parse(AttendanceSplit[1]), int.parse(AttendanceSplit[0])));
         
       });


        
      }



    setState(() {
       AllPresenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

      loading = false;
     });

    
     }


    print(AllPresenceData);
}









List AllAbsenceData =[];

int totalAbsence = 0;



Future<void> getSpecificAbsenceData(String StudentEmail, String SelectedMonth) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    setState(() {
      loading= true;
    });


    Query query = _collectionRef.where("StudentEmail", isEqualTo: StudentEmail).where("type", isEqualTo: "absence").where("month", isEqualTo: SelectedMonth);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllAbsenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

      setState(() {
            totalAbsence = AllAbsenceData.length;
          });

     if (AllAbsenceData.isEmpty) {

    setState(() {
      
      Dataload ="0";

      loading = false;
     });



       
     } else {


      for (var i = 0; i < AllAbsenceData.length; i++) {


        var AttendanceDate = AllAbsenceData[i]["Date"];

       var AttendanceSplit = AttendanceDate.toString().split("/");


       setState(() {

        AbsenceDate.insert(AbsenceDate.length, DateTime(int.parse(AttendanceSplit[2]), int.parse(AttendanceSplit[1]), int.parse(AttendanceSplit[0])));
         
       });


        
      }



    setState(() {
       AllAbsenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

      loading = false;
     });




       
     }








    print(AllAbsenceData);
}









List NewNotice =[];



Future<void> getNewNotice() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();
          setState(() {
                loading= true;
              });

      
      
  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('Notice');

    Query query = _collectionRef.where("Date", isEqualTo: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     NewNotice = querySnapshot.docs.map((doc) => doc.data()).toList();
     
     



     if (NewNotice.isEmpty) {

    setState(() {
      
      Dataload ="0";

      loading = false;
     });



       
     } else {


    



    setState(() {
       NewNotice = querySnapshot.docs.map((doc) => doc.data()).toList();

      loading = false;
     });

    
     }


}

























  
var photoUrl ="";
var StudentName ="";
var StudentEmail = "";
var StudentType = "";
var DueAmount = "";
var CourseFee ="";
















@override
  void initState() {







 
    super.initState();



      setState(() {
        photoUrl = _mybox.get("StudentPhotoUrl");
        StudentName = _mybox.get("StudentName");
        StudentEmail = _mybox.get("StudentEmail");
        StudentType = _mybox.get("StudentType");
        DueAmount = _mybox.get("DueAmount");
        CourseFee = _mybox.get("CourseFee");
      });



        getSpecificPresenceData(StudentEmail, "${DateTime.now().month}/${DateTime.now().year}");
        

         getSpecificAbsenceData(StudentEmail, "${DateTime.now().month}/${DateTime.now().year}");

         getNewNotice();





          Future.delayed(const Duration(milliseconds: 500), () {



              setState(() {

                firstValue = 0.45;
                secondValue = 0.45;
               
              });

            });



            Future.delayed(const Duration(milliseconds: 1000), () {



              setState(() {

                firstValue = 0.75;
                secondValue = 0.75;
               
              });

            });




            Future.delayed(const Duration(milliseconds: 1500), () {



              setState(() {

                firstValue = 0.95;
                secondValue = 0.95;
               
              });

            });



  
    
  
  
  }











  
  Future refresh() async{


    setState(() {
      
    // getPaidStudentData();
    // getAllStudent();
    // getAllDueStudent();


    });




  }























  @override
  Widget build(BuildContext context) {
    return Scaffold(



      



        // Drawer section 
    drawer: Drawer(
      child: ListView(children: [
        UserAccountsDrawerHeader(
              accountName: Text("${StudentName}", style: TextStyle(color:Colors.white),),
              accountEmail: Text("${StudentEmail}",style: TextStyle(color: Colors.white),),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "${photoUrl}"),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              
            ),


            
        ListTile(title: Text("Show A/P"),leading: Icon(Icons.fingerprint, color: ColorName().appColor,size: 16,),

          onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowAttendance(StudentEmail: StudentEmail)));
        },
        
        
        ),
        Divider(height: 3,thickness: 2,),

       
        ListTile(title: Text("My profile"),leading: Icon(Icons.person, color: ColorName().appColor,size: 16,),
        
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => StudentProfile(StudentEmail: StudentEmail)));
        },
        
        ),
        Divider(height: 3,thickness: 2,),
        ListTile(title: Text("Exam Fee History"),leading: Icon(Icons.history, color: ColorName().appColor,size: 16,),

             onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ExamFeeHistory(StudentEmail: StudentEmail)));
        },
        
        
        ),
        Divider(height: 3,thickness: 2,),
        ListTile(title: Text("Course Fee History"),leading: Icon(Icons.history, color: ColorName().appColor,size: 16,),
                onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CourseFeeHistory(StudentEmail: StudentEmail)));
        },
        
        
        ),
        Divider(height: 3,thickness: 2,),
        ListTile(title: Text("Notice"),leading: Icon(Icons.notifications, color: ColorName().appColor,size: 16,),

               onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllNotice(indexNumber: "1")));
        },
        
        
        ),
        Divider(height: 3,thickness: 2,),



        ListTile(title: Text("Change Password"),leading: Icon(Icons.password, color: ColorName().appColor,size: 16,),
        
           onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePassword()));
        },
        
        ),


        ListTile(title: Text("Developer Info"),leading: Icon(Icons.developer_board, color: ColorName().appColor,size: 16,),
        
           onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeveloperInfo()));
        },
        
        ),


           ListTile(title: Text("Log Out"),leading: Icon(Icons.logout, color: ColorName().appColor,size: 16,),
        
        onTap: () async{

                          FirebaseAuth.instance
                            .authStateChanges()
                            .listen((User? user) async{
                              if (user == null) {
                                
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AdminLogInScreen()),
                      );
                                print('User is currently signed out!');
                              } else {
                                print('User is signed in!');
                                await FirebaseAuth.instance.signOut();
                                          
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AdminLogInScreen()),
                      );
                              }
                            });
                  




                },
        
        ),


    
      ]),
     
    ), 










      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(92, 107, 192, 1)),
        title: const Text("Home",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
    
        
      ),





      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
      
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                  
                  
                 
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  
                  child: DefaultTextStyle(
                    style:  TextStyle(
                      fontSize: 15.0,
                      color: ColorName().appColor,
                      fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
                      fontWeight: FontWeight.bold
                    ),
                    child: AnimatedTextKit(
                      
                      repeatForever: true,
                      animatedTexts: [
                        TypewriterAnimatedText('Hi...'),
                        TypewriterAnimatedText('${StudentName.toUpperCase()}'),
                        TypewriterAnimatedText('Welcome to Uttaron Polytechnic Institute'),
                        
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                ),
              ),






                  
                  StudentType=="Due"?AnimatedContainer(
                    
                      transform: (shouldScaleDown
                      ? (Matrix4.identity()
                        ..translate(0.035 * width, 0.025 * height)// translate towards right and down
                        ..scale(firstValue, secondValue))// scale with to 95% anchorred at topleft of the AnimatedContainer
                      : Matrix4.identity()),
                     duration: Duration(seconds: 3),
                     curve: Curves.fastOutSlowIn,
                     height: 40,
                     
                     child: Center(
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                   children: [

                      Icon(Icons.warning, color: Colors.white,),


                      Text("Please, pay your course fee",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),


                  
                   ],
                 ),
               ),
                          
                 decoration: BoxDecoration(
                     color: Colors.orange.shade300,
                
                     border: Border.all(
                               width: 2,
                               color: Colors.orange.shade300
                             ),
                     borderRadius: BorderRadius.circular(10)      
                 ),):Text(""),





                 
                 SizedBox(height: 10,),






                    // New Notice 
                   AnimatedContainer(
                    
                      transform: (shouldScaleDown
                      ? (Matrix4.identity()
                        ..translate(0.035 * width, 0.025 * height)// translate towards right and down
                        ..scale(firstValue, secondValue))// scale with to 95% anchorred at topleft of the AnimatedContainer
                      : Matrix4.identity()),
                     duration: Duration(seconds: 3),
                     curve: Curves.fastOutSlowIn,
                     height: 90,
                     
                     child: Center(
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                   children: [

                  NewNotice.isEmpty? Text("No New Notice Available Today", style: TextStyle(color: Colors.red.shade300, fontWeight: FontWeight.bold),):Text("1 New Notice Available", style: TextStyle(color: Colors.green.shade300, fontWeight: FontWeight.bold),),


                   Container(width: 70, child:TextButton(onPressed: (){
      
      
                                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllNotice(indexNumber: "2")));
      
      
                           
      
      
      
      
      
                          }, child: Text("View", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                           
                  backgroundColor: MaterialStatePropertyAll<Color>(NewNotice.isEmpty?Colors.red.shade300:Colors.green.shade300),
                ),),),
                  
                   ],
                 ),
               ),
                          
                 decoration: BoxDecoration(
                     color: Colors.white,
                
                     border: Border.all(
                               width: 2,
                               color: NewNotice.isEmpty?Colors.red.shade300:Colors.green.shade300
                             ),
                     borderRadius: BorderRadius.circular(10)      
                 ),),





                 
                 SizedBox(height: 10,),





                 
                
                     AnimatedContainer(
                    
                      transform: (shouldScaleDown
                      ? (Matrix4.identity()
                        ..translate(0.035 * width, 0.025 * height)// translate towards right and down
                        ..scale(firstValue, secondValue))// scale with to 95% anchorred at topleft of the AnimatedContainer
                      : Matrix4.identity()),
                     duration: Duration(seconds: 3),
                     curve: Curves.fastOutSlowIn,
                     height: height,
                     
                     child: Center(
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                      Text("You have given ${(100-((double.parse(DueAmount))/(double.parse(CourseFee))*100)).toStringAsFixed(2)}% Course Fee",style: TextStyle(color: (100-((double.parse(DueAmount))/(double.parse(CourseFee))*100))>=80.0?Colors.green.shade300:Colors.red.shade300, fontWeight: FontWeight.bold)),

                      SizedBox(height: 10,),



                     CircularPercentIndicator(
                       animation: true,
                       animationDuration: 2500,
                      
                       radius: 75.0,
                       lineWidth: 15.0,
                       percent: (1-(double.parse(DueAmount))/(double.parse(CourseFee))),
                       center: Text(
                         "${(100-((double.parse(DueAmount))/(double.parse(CourseFee))*100)).toStringAsFixed(2)}%",
                         style: new TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
                       ),
                       
                       
                       
                       progressColor: (100-((double.parse(DueAmount))/(double.parse(CourseFee))*100))>=80.0?Colors.green.shade300:Colors.red.shade300,
                     ),

                     SizedBox(height: 20,),


                    StudentType=="Due"? Text("Due: ${DueAmount}৳",style: TextStyle(color: Colors.red.shade300, fontWeight: FontWeight.bold)):Text(""),

                      




                   ],
                 ),
               ),
                          
                 decoration: BoxDecoration(
                     color: Colors.white,
                
                     border: Border.all(
                               width: 1,
                               color: Colors.grey.shade300
                             ),
                     borderRadius: BorderRadius.circular(10)      
                 ),),





                 SizedBox(height: 10,),





                 
                      AnimatedContainer(
                    
                      transform: (shouldScaleDown
                      ? (Matrix4.identity()
                        ..translate(0.035 * width, 0.025 * height)// translate towards right and down
                        ..scale(firstValue, secondValue))// scale with to 95% anchorred at topleft of the AnimatedContainer
                      : Matrix4.identity()),
                     duration: Duration(seconds: 3),
                     curve: Curves.fastOutSlowIn,
                     height: 90,
                     
                     child: Center(
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                      Text("Your Profile"),


                   Container(width: 100, child:TextButton(onPressed: (){
      
      
                                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => StudentProfile(StudentEmail: StudentEmail)));
      
      
                           
      
      
      
      
      
                          }, child: Text("Profile", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                           
                  backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
                ),),),
                  
                   ],
                 ),
               ),
                          
                 decoration: BoxDecoration(
                     color: Colors.white,
                
                     border: Border.all(
                               width: 2,
                               color: Colors.grey.shade300
                             ),
                     borderRadius: BorderRadius.circular(10)      
                 ),),





                 
                 SizedBox(height: 10,),










                
                
                     AnimatedContainer(
                    
                      transform: (shouldScaleDown
                      ? (Matrix4.identity()
                        ..translate(0.035 * width, 0.025 * height)// translate towards right and down
                        ..scale(firstValue, secondValue))// scale with to 95% anchorred at topleft of the AnimatedContainer
                      : Matrix4.identity()),
                     duration: Duration(seconds: 3),
                     curve: Curves.fastOutSlowIn,
                     height: height,
                     
                     child: Center(
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                      Text("Your Presence ${DateTime.now().month}/${DateTime.now().year}"),
                     CircularPercentIndicator(
                       animation: true,
                       animationDuration: 2500,
                      
                       radius: 75.0,
                       lineWidth: 15.0,
                       percent: (totalPresence/(totalAbsence+totalPresence)).isNaN?0.0:totalPresence/(totalAbsence+totalPresence),
                       center: Text(
                         "${(totalPresence/(totalAbsence+totalPresence)).isNaN?"0.0":((totalPresence/(totalAbsence+totalPresence))*100).toStringAsFixed(2)}%",
                         style: new TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
                       ),
                       
                       
                       
                       progressColor: Colors.green.shade400,
                     ),
                   ],
                 ),
               ),
                          
                 decoration: BoxDecoration(
                     color: Colors.white,
                
                     border: Border.all(
                               width: 1,
                               color: Colors.grey.shade300
                             ),
                     borderRadius: BorderRadius.circular(10)      
                 ),),





                 SizedBox(height: 10,),

                 
                
                     AnimatedContainer(
                    
                      transform: (shouldScaleDown
                      ? (Matrix4.identity()
                        ..translate(0.035 * width, 0.025 * height)// translate towards right and down
                        ..scale(firstValue, secondValue))// scale with to 95% anchorred at topleft of the AnimatedContainer
                      : Matrix4.identity()),
                     duration: Duration(seconds: 3),
                     curve: Curves.fastOutSlowIn,
                     height: height,
                     
                     child: Center(
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                      Text("Your Absence ${DateTime.now().month}/${DateTime.now().year}"),
                     CircularPercentIndicator(
                       animation: true,
                       animationDuration: 2500,
                      
                       radius: 75.0,
                       lineWidth: 15.0,
                       percent: (totalPresence/(totalAbsence+totalPresence)).isNaN?0.0:1.0-(totalPresence/(totalAbsence+totalPresence)),
                       center: Text(
                         "${(totalPresence/(totalAbsence+totalPresence)).isNaN?"0.0":((1.0-totalPresence/(totalAbsence+totalPresence))*100).toStringAsFixed(2)}%",
                         style: new TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
                       ),
                       
                       
                       
                       progressColor: Colors.red.shade400,
                     ),
                   ],
                 ),
               ),
                          
                 decoration: BoxDecoration(
                     color: Colors.white,
                
                     border: Border.all(
                               width: 1,
                               color: Colors.grey.shade300
                             ),
                     borderRadius: BorderRadius.circular(10)      
                 ),),





                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 ]))))





    );
  }
}