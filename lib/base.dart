import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

abstract class BaseConnector {
  void hideDialog();

  void showMessage(String message);

  void showLoading();
}

class BaseViewModel<CON extends BaseConnector> extends ChangeNotifier {
  CON? connector;
}

abstract class BaseView<VM extends BaseViewModel, T extends StatefulWidget>
    extends State<T> implements BaseConnector {
  late VM viewModel;

  VM initViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = initViewModel();
  }

  @override
  void hideDialog() {
    Navigator.pop(context);
  }

  @override
  void showLoading() {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  @override
  void showMessage(String message) {
    hideDialog();
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: DialogType.error,
      title: "Error",
      desc: "The email address or password you entered is invalid",
      dialogBorderRadius: BorderRadius.circular(20),
      btnOkOnPress: () {},
    ).show();
  }
}
