import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rushikesh_engg/widgets/Custom_Text_Field.dart';
import 'package:rushikesh_engg/Firebase/AppMethods.dart';
import 'package:rushikesh_engg/Firebase/FirebaseMethods.dart';
import 'package:rushikesh_engg/Firebase/app_constants.dart';
import 'package:rushikesh_engg/widgets/myValidation.dart';
import 'package:rushikesh_engg/theme.dart';
import 'package:rushikesh_engg/widgets/Dialog.dart';

class AddNewClient extends StatefulWidget {
  @override
  _AddNewClientState createState() => _AddNewClientState();
}

class _AddNewClientState extends State<AddNewClient> {
  AppMethods appMethod = FirebaseMethods();
  final _formKey = GlobalKey<FormState>();
  TextEditingController client_name = TextEditingController();
  TextEditingController client_address = TextEditingController();
  TextEditingController client_country = TextEditingController();
  TextEditingController client_state = TextEditingController();
  TextEditingController client_city = TextEditingController();
  TextEditingController client_contact = TextEditingController();
  TextEditingController client_email = TextEditingController();
  TextEditingController client_fax = TextEditingController();

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
                      'Add New Client',
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
                        controller: client_name,
                        hintText: 'Full Name',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z]+|\s"),
                          )
                        ],
                        validator: (val) {
                          if (val!.isNotEmpty) {
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
                        controller: client_address,
                        hintText: 'Address',
                        maxLineCount: 3,
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
                        controller: client_country,
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
                        controller: client_state,
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
                        controller: client_city,
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
                        controller: client_contact,
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
                        controller: client_email,
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
                      CustomFormField(
                        controller: client_fax,
                        hintText: 'Fax No.(91-123-1234567)',
                        // validator: (val) {
                        //   if (val!.isValidFax) {
                        //     return null;
                        //   } else {
                        //     return 'Enter valid fax No';
                        //   }
                        // },
                      ),
                      const SizedBox(
                        height: 20,
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
                          if (_formKey.currentState!.validate()) {
                            addClient(context);
                          }
                        },
                        borderRadius: BorderRadius.circular(14.0),
                        child: Center(
                          child: Text(
                            'Confirm',
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

  addClient(BuildContext context) async {
    String res = await appMethod.AddNewClient(
        client_name: client_name.text,
        client_address: client_address.text,
        client_country: client_country.text,
        client_state: client_state.text,
        client_city: client_city.text,
        client_contact: client_contact.text,
        client_email: client_email.text,
        client_fax: client_fax.text);
    if (res == successful) {
      showSuccessDialog(context, "Client Added", res);
    } else {
      showErrorDialog(context, "Failed to Add client", res);
    }
  }
}
