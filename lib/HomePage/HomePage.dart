import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class StudentHomePage extends StatefulWidget {

  final indexNumber;




  const StudentHomePage({super.key, required this.indexNumber});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {


  // hive database

  final _mybox = Hive.box("uttaronBox");




























  
var photoUrl ="";
var StudentName ="";
var StudentEmail = "";




@override
  void initState() {
    // TODO: implement initState
    // getPaidStudentData();
    // getAllStudent();
    // getAllDueStudent();
    super.initState();



      setState(() {
        photoUrl = _mybox.get("StudentPhotoUrl");
        StudentName = _mybox.get("StudentName");
        StudentEmail = _mybox.get("StudentEmail");
      });


  
    

  // FlutterNativeSplash.remove();
  
  
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



      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 9),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
      
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [


           widget.indexNumber == "1"?
              IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.home_sharp,
                  color: Colors.white,
                  size: 55,
                  fill: 1.0,
                ),
              ): IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.home_sharp,
                  color: Colors.white,
                  size: 25,
                ),
              ),




              IconButton(
                enableFeedback: false,
                onPressed: () {


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllNotice(indexNumber: "2")));


                },
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 25,
                ),
              ),




              IconButton(
                enableFeedback: false,
                onPressed: () {


                  //  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MonthlyCourseFeeCollection()));



                },
                icon: const Icon(
                  Icons.account_balance,
                  color: Colors.white,
                  size: 25,
                ),
              ),



              IconButton(
                enableFeedback: false,
                onPressed: () {

                  //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllDepartment()));




                },
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ],
          ),),
      ),

      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(92, 107, 192, 1)),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
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
                  child: Container(
                  height: 200,
                  child: Center(
                    child: Text("Total Student:", style: TextStyle(
                    
                            fontSize: 20,
                            color: Colors.white,
                            overflow: TextOverflow.clip
                          ),),
                
                
                  ),
                       
                 decoration: BoxDecoration(
                  color: Color(0xF0B75CFF),
                
                  border: Border.all(
                            width: 2,
                            color: Color(0xF0B75CFF)
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),]))))





    );
  }
}