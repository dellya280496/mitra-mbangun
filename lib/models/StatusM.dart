/// status_kesehatan : "ODP"

class StatusM {
  String statusKesehatan;

  static StatusM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    StatusM statusMBean = StatusM();
    statusMBean.statusKesehatan = map['status_kesehatan'];
    return statusMBean;
  }

  Map toJson() => {
        "status_kesehatan": statusKesehatan,
      };
}
