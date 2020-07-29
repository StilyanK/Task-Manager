library auth.gui;

import 'dart:async';
import 'dart:html';

import 'package:cl/action.dart' as cl_action;
import 'package:cl/app.dart' as cl_app;
import 'package:cl/base.dart' as cl;
import 'package:cl/calendar.dart' as cl_calendar;
import 'package:cl/chat.dart' as chat;
import 'package:cl/forms.dart' as cl_form;
import 'package:cl/gui.dart' as cl_gui;
import 'package:cl/utils.dart' as cl_util;
import 'package:cl_base/client.dart';
import 'package:communicator/client.dart';
import 'package:icon/icon.dart' as icon;

import '../intl/client.dart' as intl;
import 'entity.dart';
import 'path.dart';

part 'gui/calendar.dart';

part 'gui/element/group_select.dart';

part 'gui/element/input_ip_address.dart';

part 'gui/element/input_password.dart';

part 'gui/element/input_user.dart';

part 'gui/element/user_select.dart';

part 'gui/group.dart';

part 'gui/group_list.dart';

part 'gui/user.dart';

part 'gui/user_home.dart';

part 'gui/user_list.dart';

part 'gui/user_list_choose.dart';

part 'gui/user_settings.dart';

abstract class Icon {
  static const String Calendar = cl.Icon.schedule;
  static const String UserMain = icon.Icon.fingerprint;
  static const String User = cl.Icon.person;
  static const String Settings = cl.Icon.settings;
  static const String UserGroup = icon.Icon.group;
}

class Client extends cl_app.Client {
  UserSessionDTO sessionDto;
  List<FormSettingsPair> formSettings = [];
  String settingsSaveRoute = RoutesU.settings.reverse([]);

  Client(Map data) : super(data.cast<String, dynamic>()) {
    sessionDto = UserSessionDTO.fromMap(data['client']);
    set();
  }

  void set() {
    addApp(cl_app.ClientApp()
      ..init = (ap) {
        final cc = chat.ChatController();
        final chat.Chat ch = chat.Chat(ap, ap.fieldRight,
            chat.RoomListContext(ap, cc), chat.RoomContext(ap, cc), cc);

        cc
          ..loadRooms = () async {
            final rooms =
                await ap.serverCall(RoutesChat.loadRooms.reverse([]), null);
            return rooms
                .map<chat.Room>((room) => chat.Room.fromMap(room))
                .toList();
          }
          ..loadRoomMessages = (room) async {
            final messages = await ap.serverCall(
                RoutesChat.loadRoomMessages.reverse([]), room.toJson());
            return messages
                .map<chat.Message>(
                    (message) => chat.Message.fromMap(message))
                .toList();
          }
          ..loadRoomMessagesNew = (room) async {
            final messages = await ap.serverCall(
                RoutesChat.loadRoomMessagesNew.reverse([]), room.toJson());
            return messages
                .map<chat.Message>(
                    (message) => chat.Message.fromMap(message))
                .toList();
          }
          ..persistMessage = ((message) => ap.serverCall(
              RoutesChat.messagePersist.reverse([]), message.toJson()))
          ..markMessageAsSeen = ((message) async => ap.serverCall(
              RoutesChat.messageSeen.reverse([]), message.toJson()))
          ..createRoom = () async {
            UserListChoose((obj) async {
              if (ap.client.userId == obj['user_id']) return;
              await ap.serverCall(
                  RoutesChat.createRoom.reverse([]),
                  ChatRoomCreateDTO()
                    ..members = [
                      ChatMemberDTO()..user_id = ap.client.userId,
                      ChatMemberDTO()..user_id = obj['user_id']
                    ]);
            }, ap);
            // return ap.serverCall(RoutesChat.createRoom.reverse([]),
            // room.toJson());
            return true;
          };

        ap.onServerCall.filter(EVENT_CHATMESSAGECREATED).listen((r) {
          final cm = ChatMessageChangeEventDTO.fromMap(r);
          if (cm.room_context != null) return;
          if (!ch.focused && cm.user_id != ap.client.userId)
            ap.notify.add(cl_app.NotificationMessage()
              ..persist = false
              ..text = '${cm.name} : ${cm.message}'
              ..date = DateTime.now());
          cc.notifierMessage.add(chat.Room()
            ..room_id = cm.room_id
            ..unseen = cm.unseen);
        });
        ap.onServerCall.filter(EVENT_CHATROOMCREATED).listen((r) {
          final cm = ChatMessageChangeEventDTO.fromMap(r);
          if (cm.room_context != null) return;
          cc.notifierRoom.add(chat.Room()..room_id = cm.room_id);
        });
        ap.onServerCall.filter(EVENT_CHATMESSAGEUPDATED).listen((res) async {
          // TODO
        });
        ap.addons.append(ch.chatDom());
      });
    addApp(cl_app.ClientApp()
      ..init = (ap) => ap.addons.append(cl_action.Button()
        ..setIcon(cl.Icon.schedule)
        ..addAction((e) => ap.run('user/calendar'))
        ..setTip(intl.Calendar(), 'bottom')));
    addApp(cl_app.ClientApp()
      ..init = (ap) {
        final but = cl_action.ButtonOption()
          ..addClass('profile')
          ..addSub(cl_action.Button()
            ..setIcon(cl.Icon.person)
            ..addAction((e) => ap.run('user/profile'))
            ..setTitle(intl.Profile()))
          ..addSub(cl_action.Button()
            ..setIcon(cl.Icon.settings)
            ..addAction((e) => ap.run('user/settings'))
            ..setTitle(intl.Settings()))
          ..addSub(cl_action.Button()
            ..setIcon(cl.Icon.exit_to_app)
            ..addAction((e) => window.location.href = '${ap.baseurl}logout')
            ..setTitle(intl.Logout()))
          ..slider.boxing.offsetTopBottom = 20;
        but.buttonOption
          ..setTip(ap.client.name, 'bottom')
          ..setIcon(null);
        if (ap.client.picture == null) {
          but.buttonOption.setIcon(cl.Icon.person);
        } else {
          but.buttonOption.dom.style.backgroundImage =
              'url(${ap.baseurl + ap.client.picture})';
        }
        ap.addons.append(but);
      });
  }

  String get uin => sessionDto.uin;

  String get medicalCenter => sessionDto.medicalCenter;

  List<Department> get departments => sessionDto.departments;

  int get timeRate => sessionDto.timeRate;

  String get timezone => sessionDto.timezone;

  bool isAdministrator() => sessionDto.isAdministrator();

  bool isUser() => sessionDto.isUser();

  cl_gui.FormElement _getSettingsForm(cl_form.Form form) {
    final f = cl_gui.FormElement(form)
      ..addClass('top')
      ..addRow(intl.Language(), [
        cl_form.Select()
          ..setName('language')
          ..addOption(null, 'Auto')
          ..addOption('en_US', 'English')
          ..addOption('bg_BG', 'Bulgarian')
          ..addOption('ru_RU', 'Russian')
          ..addOption('de_DE', 'German')
          ..addOption('fr_FR', 'French')
          ..addOption('es_ES', 'Spanish')
          ..addOption('it_IT', 'Italian')
          ..addOption('el_EL', 'Greek')
          ..addOption('ro_RO', 'Romanian')
      ])
      ..addRow(intl.Theme(), [
        cl_form.Select()
          ..setName('theme')
          ..addOption('main', 'Default')
          ..addOption('dark', 'Dark')
          ..addOption('color', 'Color')
      ]);
    formSettings.forEach((s) => f.addRow(s.title, [s.element]));
    return f;
  }

  Department getDepartmentByType(String type) =>
      departments.firstWhere((d) => d.type == type, orElse: () => null);
}

class FormSettingsPair {
  String title;
  cl_form.DataElement element;
}