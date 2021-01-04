import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/tools/formatting.dart';
import 'package:eliud_pkg_notifications/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_notifications/model/notification_list_bloc.dart';
import 'package:eliud_pkg_notifications/model/notification_list_event.dart';
import 'package:eliud_pkg_notifications/model/notification_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyNotificationListItem extends StatelessWidget {
  final NotificationModel value;

  MyNotificationListItem({
    Key key,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var app = AccessBloc.app(context);
    var style = ((value.read == null) || (value.read)) ? null : new TextStyle(fontWeight: FontWeight.bold);
    return Dismissible(
      key: Key('__Notification_item_${value.documentID}'),
      onDismissed: (_) {
        BlocProvider.of<NotificationListBloc>(context)
            .add(UpdateNotificationList(value: value.copyWith(status: NotificationStatus.Closed)));
      },
      child: ListTile(
        onTap: () {},
        trailing: Text(value.timestamp, style: style),
        title: Text(value.description, style: style,))
      );
  }
}
