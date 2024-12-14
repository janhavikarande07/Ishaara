import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors.dart';
import 'Profile.dart';

class UpdateProfileScreen extends StatefulWidget{

  final Map<String, dynamic> profileData;
  const UpdateProfileScreen({Key? key, required this.profileData}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  TextEditingController? nameController;
  TextEditingController? numberController;
  TextEditingController? patientNameController ;
  TextEditingController? patientAgeController;

  String gender = "";
  String? blood_group;

  User? user = FirebaseAuth.instance.currentUser;
  
  @override
  void initState() {
    nameController = TextEditingController(text : widget.profileData["name"]);
    numberController = TextEditingController(text : widget.profileData["phone_number"]);
    patientAgeController = TextEditingController(text : widget.profileData["patient_age"]);
    patientNameController = TextEditingController(text : widget.profileData["patient_name"]);
    blood_group = widget.profileData["patient_blood_type"];
    gender = widget.profileData["patient_gender"];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: widget.profileData["role"] == "Caretaker" ? CareTaker(user:user, nameController:nameController, numberController:numberController, patientNameController:patientNameController, patientAgeController:patientAgeController, blood_group:blood_group, gender:gender)
          : SingleChildScrollView(
        child : Container(
          decoration: BoxDecoration(

          ),
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              const Text(
                "Update Details",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 30, fontFamily: "Cooper", fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 20,),
              Stack(
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/profile.png",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: ' Name ',
                  labelStyle: TextStyle(
                    color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500,
                    fontFamily: "Cooper",
                    fontStyle: FontStyle.normal,
                  ),
                  prefixIcon: Icon(Icons.person, color: Colors.black,),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: numberController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10), // Limit to 10 digits
                ],
                decoration: const InputDecoration(
                  labelText: ' Phone Number ',
                  labelStyle: TextStyle(
                    color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500,
                    fontFamily: "Cooper",
                    fontStyle: FontStyle.normal,
                  ),
                  prefixIcon: Icon(Icons.phone, color: Colors.black,),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: patientNameController,
                decoration: const InputDecoration(
                  labelText: ' Patient Name ',
                  labelStyle: TextStyle(
                    color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500,
                    fontFamily: "Cooper",
                    fontStyle: FontStyle.normal,
                  ),
                  prefixIcon: Icon(Icons.person, color: Colors.black,),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: patientAgeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: ' Patient\'s Age ',
                  labelStyle: TextStyle(
                    color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500,
                    fontFamily: "Cooper",
                    fontStyle: FontStyle.normal,
                  ),
                  prefixIcon: Icon(Icons.person, color: Colors.black,),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter age';
                  }
                  final age = int.tryParse(value);
                  if (age == null || age <= 0) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              DropdownButtonFormField<String>(
                value: blood_group,
                hint: Text('Select Blood Group'),
                onChanged: (String? newValue) {
                  setState(() {
                    blood_group = newValue;
                  });
                },
                decoration: const InputDecoration(
                  labelText: ' Patient\'s Blood Group ',
                  labelStyle: TextStyle(
                    color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500,
                    fontFamily: "Cooper",
                    fontStyle: FontStyle.normal,
                  ),
                  prefixIcon: Icon(Icons.bloodtype, color: Colors.black,),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                validator: (value) => value == null ? 'Please select blood group' : null,
                items: <String>['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Patient\'s Gender:',
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<String>(
                        value: 'Male',
                        groupValue: gender,
                        activeColor: themeColor,
                        onChanged: (String? value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                      Text('Male', style: TextStyle(fontSize: 16),),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<String>(
                        value: 'Female',
                        groupValue: gender,
                        activeColor: themeColor,
                        onChanged: (String? value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                      Text('Female', style: TextStyle(fontSize: 16),),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () async {
                  Map<String, dynamic> data = {
                    "name": nameController!.text,
                    "phone_number" : numberController!.text,
                    "patient_name" : patientNameController!.text,
                    "patient_blood_type" : blood_group,
                    "patient_age" : patientAgeController!.text,
                    "patient_gender" : gender
                  };

                  try {
                    await FirebaseFirestore.instance
                        .collection("Users")
                        .doc(user!.uid)
                        .update(data);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Updated Successfully"),
                        action: SnackBarAction(
                          label: 'Dismiss',
                          onPressed: () {
                            // Code to execute.
                          },
                        ),
                      ),
                    );

                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Profile(),
                      ),
                    );
                  }
                  on Exception catch(e){
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Error Updating"),
                          action: SnackBarAction(
                            label: 'Dismiss',
                            onPressed: () {
                              // Code to execute.
                            },
                          ),
                        )
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  minimumSize: const Size(double.infinity, 50),
                  // textStyle: TextStyle(fontSize: 14),
                  shadowColor: yellowishOrange,
                  elevation: 5,
                ),
                child: const Text("Update",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: "Cooper",
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CareTaker extends StatelessWidget{

  final dynamic user;
  final dynamic nameController;
  final dynamic numberController;
  final dynamic patientAgeController;
  final dynamic patientNameController;
  final dynamic blood_group;
  final dynamic gender;

  CareTaker({required this.user, required this.nameController, required this.numberController, required this.patientNameController, required this.patientAgeController, required this.blood_group, required this.gender});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  SingleChildScrollView(
      child : Container(
        decoration: BoxDecoration(

        ),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            const Text(
              "Update Details",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 30, fontFamily: "Cooper", fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 20,),
            Stack(
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      "assets/profile.png",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: ' Name ',
                labelStyle: TextStyle(
                  color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500,
                  fontFamily: "Cooper",
                  fontStyle: FontStyle.normal,
                ),
                prefixIcon: Icon(Icons.person, color: Colors.black,),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: numberController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10), // Limit to 10 digits
              ],
              decoration: const InputDecoration(
                labelText: ' Phone Number ',
                labelStyle: TextStyle(
                  color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500,
                  fontFamily: "Cooper",
                  fontStyle: FontStyle.normal,
                ),
                prefixIcon: Icon(Icons.phone, color: Colors.black,),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: patientNameController,
              decoration: const InputDecoration(
                labelText: ' Patient Name ',
                labelStyle: TextStyle(
                  color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500,
                  fontFamily: "Cooper",
                  fontStyle: FontStyle.normal,
                ),
                prefixIcon: Icon(Icons.person, color: Colors.black,),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: patientAgeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: ' Patient\'s Age ',
                labelStyle: TextStyle(
                  color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500,
                  fontFamily: "Cooper",
                  fontStyle: FontStyle.normal,
                ),
                prefixIcon: Icon(Icons.person, color: Colors.black,),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter age';
                }
                final age = int.tryParse(value);
                if (age == null || age <= 0) {
                  return 'Please enter a valid age';
                }
                return null;
              },
            ),
            SizedBox(height: 20,),

            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> data = {
                  "name": nameController!.text,
                  "phone_number" : numberController!.text,
                  "patient_name" : patientNameController!.text,
                  "patient_blood_type" : blood_group,
                  "patient_age" : patientAgeController!.text,
                  "patient_gender" : gender
                };

                try {
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(user!.uid)
                      .update(data);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Updated Successfully"),
                      action: SnackBarAction(
                        label: 'Dismiss',
                        onPressed: () {
                          // Code to execute.
                        },
                      ),
                    ),
                  );

                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ),
                  );

                }
                on Exception catch(e){
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Error Updating"),
                        action: SnackBarAction(
                          label: 'Dismiss',
                          onPressed: () {
                            // Code to execute.
                          },
                        ),
                      )
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                minimumSize: const Size(double.infinity, 50),
                // textStyle: TextStyle(fontSize: 14),
                shadowColor: yellowishOrange,
                elevation: 5,
              ),
              child: const Text("Update",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: "Cooper",
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
