// ignore_for_file: type_annotate_public_apis, always_declare_return_types
import 'package:intl/intl.dart';
export 'package:cl/intl/client.dart'
    hide Delete, Yes, Error, No, Calendar, Total, Warning, All, New_folder;
export 'package:cl_base/intl/client.dart';

Base_on_my_location() =>
    Intl.message('Base on origin location', name: 'Base_on_my_location');

Tax_origin_location() =>
    Intl.message('Tax if origin location', name: 'Tax_origin_location');

In_cash() => Intl.message('In Cash', name: 'In_cash');

Notification_URL() =>
    Intl.message('Notification URL', name: 'Notification_URL');

REST_API_credentials() =>
    Intl.message('REST API Credentials', name: 'REST_API_credentials');

Test_mode() => Intl.message('Test mode', name: 'Test_mode');

Parse_files() => Intl.message('Parse files', name: 'Parse_files');

New_matches(how_many) => Intl.message('$how_many New matches found',
    name: 'New_matches', args: [how_many]);

Translated() => Intl.message('Translated', name: 'Translated');

Choose_country() => Intl.message('Choose Country', name: 'Choose_country');

Rhif() => Intl.message('RHIF', name: 'Rhif');

Region() => Intl.message('Region', name: 'Region');

Select_region() => Intl.message('Select region', name: 'Select_region');

Male() => Intl.message('Male', name: 'Male');

Female() => Intl.message('Female', name: 'Female');

Choose_rhif() =>
    Intl.message('Choose Health Insurance Fund', name: 'Choose_rhif');

Laboratory_unit_title() =>
    Intl.message('Laboratory unit', name: 'Laboratory_unit_title');

Add_Unit() => Intl.message('Add Unit', name: 'Add_Unit');

System() => Intl.message('System', name: 'System');

Demo_mode() => Intl.message('Demo mode', name: 'Demo_mode');

Customer_number() => Intl.message('Customer number', name: 'Customer_number');

Secret_key() => Intl.message('Secret key', name: 'Secret_key');

Client_ID() => Intl.message('Client ID', name: 'Client_ID');

Client_Secret() => Intl.message('Client Secret', name: 'Client_Secret');

IBAN() => Intl.message('IBAN', name: 'IBAN');

BIC() => Intl.message('BIC', name: 'BIC');

ISO() => Intl.message('ISO', name: 'ISO');

Report() => Intl.message('Report', name: 'Report');
