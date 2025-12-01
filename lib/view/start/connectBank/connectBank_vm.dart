import 'package:flutter/material.dart';
import 'package:zakat/data/base_vm.dart';

class ConnectbankVm extends BaseVm {
  TextEditingController name = TextEditingController();
  TextEditingController iban = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
}
