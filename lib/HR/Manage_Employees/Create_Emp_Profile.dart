import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rushikesh_engg/widgets/Custom_Text_Field.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/appData.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/theme.dart';
import 'package:rushikesh_engg/widgets/Dialog.dart';

class CreateEmpProfile extends StatefulWidget {
  final DocumentSnapshot post;
  CreateEmpProfile({required this.post});
  @override
  _CreateEmpProfileState createState() => _CreateEmpProfileState();
}

class _CreateEmpProfileState extends State<CreateEmpProfile> {
  AppMethods appMethod = FirebaseMethods();

  TextEditingController empId = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController contactNo = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController dob = TextEditingController();

  String? employeeType = empTypeList[0];
  String? dept = deptList[0];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    empId.text = widget.post[candidateId];
    name.text = widget.post[candidateName];
    address.text = widget.post[candidateAddr];
    country.text = widget.post[candidateCountry];
    state.text = widget.post[candidateState];
    city.text = widget.post[candidateCity];
    contactNo.text = widget.post[candidateContact];
    emailId.text = widget.post[candidateEmail];
    dob.text = widget.post[candidateDOB];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Create Employee Profile',
                      style: heading2.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/images/accent.png',
                      width: 99,
                      height: 4,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 48,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomFormField(
                        controller: name,
                        hintText: 'Full Name',
                        isReadOnly: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: name,
                        hintText: 'Full Name',
                        isReadOnly: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: address,
                        hintText: 'Address',
                        isReadOnly: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: country,
                        hintText: 'Country',
                        isReadOnly: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: state,
                        hintText: 'State',
                        isReadOnly: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: city,
                        hintText: 'City',
                        isReadOnly: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: contactNo,
                        hintText: 'Contact No.',
                        isReadOnly: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: emailId,
                        hintText: 'Email',
                        isReadOnly: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: dob,
                        hintText: 'Birth Date',
                        isReadOnly: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            value: employeeType,
                            items: empTypeList.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                employeeType = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            value: dept,
                            items: deptList.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dept = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Material(
                  borderRadius: BorderRadius.circular(14.0),
                  elevation: 0,
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: primaryBlue,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate() &&
                              employeeType != "Select Employee Type" &&
                              dept != "Select Department") {
                            createUser(context);
                          } else if (employeeType == "Select Login Type") {
                            Fluttertoast.showToast(
                                msg: "Select valid employee type");
                          } else if (dept == "Select Department") {
                            Fluttertoast.showToast(
                                msg: "Select valid department");
                          }
                        },
                        borderRadius: BorderRadius.circular(14.0),
                        child: Center(
                          child: Text(
                            'Save',
                            style: heading5.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  createUser(BuildContext context) async {
    String res = await appMethod.createUserAccount(
      id: empId.text,
      name: name.text,
      address: address.text,
      country: country.text,
      state: state.text,
      city: city.text,
      contactNo: contactNo.text,
      email: emailId.text,
      employeeType: employeeType!,
      deptName: dept!,
      dob: dob.text,
      password: defaultPassword,
    );

    if (res == successful) {
      showSuccessDialog(context, "User Created", res);
    } else {
      showErrorDialog(context, "Failed to create user", res);
    }
  }
}
