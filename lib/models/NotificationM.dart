/// id : "12"
/// title : "Pembelian"
/// body : "Pembelian anda telah batal."
/// navigate_to : "pageName"
/// create_at : "2020-10-03 15:49:40.671193"
/// id_user : "49"
/// status : "unread"

class NotificationM {
  String id;
  String title;
  String body;
  String navigateTo;
  String createAt;
  String idMitra;
  String status;

  static NotificationM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    NotificationM notificationMBean = NotificationM();
    notificationMBean.id = map['id'];
    notificationMBean.title = map['title'];
    notificationMBean.body = map['body'];
    notificationMBean.navigateTo = map['navigate_to'];
    notificationMBean.createAt = map['create_at'];
    notificationMBean.idMitra = map['id_user'];
    notificationMBean.status = map['status'];
    return notificationMBean;
  }

  Map toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "navigate_to": navigateTo,
        "create_at": createAt,
        "id_user": idMitra,
        "status": status,
      };
}
