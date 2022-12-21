import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rushikesh_engg/widgets/Custom_Text_Field.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/appData.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/widgets/myValidation.dart';
import 'package:rushikesh_engg/theme.dart';
import 'package:rushikesh_engg/widgets/Dialog.dart';

class UpdateEmpDetails_HR extends StatefulWidget {
  final DocumentSnapshot post;
  UpdateEmpDetails_HR({required this.post});
  @override
  _UpdateEmpDetails_HRState createState() => _UpdateEmpDetails_HRState();
}

class _UpdateEmpDetails_HRState extends State<UpdateEmpDetails_HR> {
  AppMethods appMethod = FirebaseMethods();
  final _formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController contactNo = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController dob = TextEditingController();
  String? employeeType;
  String? dept;
  DateTime birthDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    id.text = widget.post[empId];
    name.text = widget.post[empName];
    address.text = widget.post[empAddr];
    country.text = widget.post[empCountry];
    state.text = widget.post[empState];
    city.text = widget.post[empCity];
    contactNo.text = widget.post[empContact];
    emailId.text = widget.post[empEmail];
    employeeType = widget.post[empType];
    dept = widget.post[empDept];
    dob.text = widget.post[empDOB];
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
                      'Update Employee Details',
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
                  child: Column(
                    children: [
                      CustomFormField(
                        controller: id,
                        isReadOnly: true,
                        hintText: 'ID',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: name,
                        hintText: 'Full Name',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z]+|\s"),
                          )
                        ],
                        validator: (val) {
                          if (val!.isValidName) {
                            return null;
                          } else {
                            return 'Enter valid name';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: address,
                        hintText: 'Address',
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Enter valid Address';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: country,
                        hintText: 'Country',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z]+|\s"),
                          )
                        ],
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Enter valid country name';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: state,
                        hintText: 'State',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z]+|\s"),
                          )
                        ],
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Enter valid state name';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: city,
                        hintText: 'City',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z]+|\s"),
                          ),
                        ],
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Enter valid city name';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: contactNo,
                        hintText: 'Contact No.',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[0-9]"),
                          )
                        ],
                        validator: (val) {
                          if (val!.isValidPhone) {
                            return null;
                          } else {
                            return 'Enter valid phone';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        controller: emailId,
                        hintText: 'Email',
                        validator: (val) {
                          if (val!.isValidEmail) {
                            return null;
                          } else {
                            return 'Enter valid email';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          onTap: () => _selectBirthDate(context),
                          readOnly: true,
                          controller: dob,
                          decoration: InputDecoration(
                            label: Text(
                              "Birth Date",
                              style: regular12pt,
                            ),
                            hintStyle: heading6.copyWith(color: textGrey),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
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
                            UpdateUserDetails(context);
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
                            'Update',
                            style: heading5.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(1970),
        firstDate: DateTime(1970),
        lastDate: DateTime(2010));
    if (pickedDate != null) {
      setState(() {
        birthDate = pickedDate;
        dob.text = formatter.format(pickedDate).toString();
      });
    }
  }

  UpdateUserDetails(BuildContext context) async {
    String res = await appMethod.updateUserAccount(
      userId: widget.post[empId],
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
    );

    if (res == successful) {
      showSuccessDialog(context, "Update Successful", res);
    } else {
      showErrorDialog(context, "Failed to update information", res);
    }
  }
}
