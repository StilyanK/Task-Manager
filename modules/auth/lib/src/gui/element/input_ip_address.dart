part of auth.gui;

class InputIPAddress extends cl_form.Input<String> {
  RegExp pattern = RegExp(
      r'^([1-9]|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])(\.(\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])){3}(\/\d+)?$');

  InputIPAddress() : super() {
    addValidationOnValue((v) {
      if (v == null || pattern.hasMatch(v)) {
        removeWarning('pass');
        return true;
      } else {
        setWarning(cl.DataWarning('pass', intl.Password_warning()));
        return false;
      }
    });
  }
}
