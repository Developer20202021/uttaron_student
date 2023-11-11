
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';








// class FetchDataRealtime extends StatefulWidget {








//   const FetchDataRealtime({super.key});

//   @override
//   State<FetchDataRealtime> createState() => _FetchDataRealtimeState();
// }

// class _FetchDataRealtimeState extends State<FetchDataRealtime> {
//   TextEditingController AdminEmailController = TextEditingController();
 

//   bool loading = false;

//   var PasswordChangeSuccess = "";
//   var updateValue = "";








//   // late DatabaseReference realDBRef;


//   Future getData() async{


//      var realDBRef = FirebaseDatabase.instance.ref().child("student").child("01767298388").push().set({"name":"mahadi", "age":"23"});

     
 







//   }




// Query realDataQuery = FirebaseDatabase.instance.ref().child("student");



// @override
//   void initState() {


//     Future.delayed(Duration(seconds: 4), () async{

//       getData();

//     });


//     super.initState();
//   }

















//   @override
//   Widget build(BuildContext context) {

    
 

//     return Scaffold(
      
//       backgroundColor: Colors.white,
      
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
//         leading: IconButton(onPressed: () async{
//                   getData();

//         }, icon: Icon(Icons.chevron_left)),
//         title: const Text("Realtime",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
//         backgroundColor: Colors.transparent,
//         bottomOpacity: 0.0,
//         elevation: 0.0,
//         centerTitle: true,
        
//       ),
//       body: 
//         FirebaseAnimatedList(itemBuilder: (context, snapshot, animation, index) {


//          Map StudentData = snapshot.value as Map;
          
//           StudentData["key"] = snapshot.key;

//           print(StudentData["name"]);

//           return ListTile(title: Text("${StudentData["name"]}"),);
//         },
        
//         query: realDataQuery,
        
//         ),
    
      
      
//     );
//   }
// }



// class CurvePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint();
//     paint.color = Color(0xf08f00ff);
//     paint.style = PaintingStyle.fill;

//     var path = Path();

//     path.moveTo(0, size.height * 0.9167);
//     path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
//         size.width * 0.5, size.height * 0.9167);
//     path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
//         size.width * 1.0, size.height * 0.9167);
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }