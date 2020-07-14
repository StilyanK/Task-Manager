part of auth.gui;

class InputPassword extends cl_form.Input<String> {
  RegExp pattern = RegExp(r''
      r'^'
      r'(?=.*[A-Z].*[A-Z])' //Ensure string has two uppercase letters.
      r'(?=.*[!@#$&*])' //Ensure string has one special case letter.
      r'(?=.*[0-9].*[0-9])' //Ensure string has two digits.
      r'(?=.*[a-z].*[a-z].*[a-z])' //Ensure string has three lowercase letters.
      r'.{8,}' //Ensure string is of length 8.
      r'$');

  InputPassword() : super() {
    field.dom.type = $User.password;
    addValidationOnValue((v) {
      //if (v == null || pattern.hasMatch(v)) {
      removeWarning('pass');
      return true;
      //} else {
      //  setWarning(cl.DataWarning('pass', intl.Password_warning()));
      //  return false;
      //}
    });
  }
}
