// ignore_for_file: always_declare_return_types, type_annotate_public_apis
import 'package:intl/intl.dart';

export 'package:cl_base/intl/client.dart';

Never() => Intl.message('Never', name: 'Never');
Access_control() => Intl.message('Access Control', name: 'Access_control');
Access() => Intl.message('Access', name: 'Access');
Address() => Intl.message('Address', name: 'Address');
Password_warning() => Intl.message(
    'The password should have at least two '
    'uppercase letters, one special case letter, '
    'two digits and three lowercase letters.',
    name: 'Password_warning');
Denied() => Intl.message('Denied', name: 'Denied');
Save_and_apply() => Intl.message('Save and Apply', name:'Save_and_apply');
Logout() => Intl.message('Logout', name:'Logout');
Session_data() => Intl.message('Session Data', name:'Session_data');