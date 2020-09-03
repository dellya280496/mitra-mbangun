/// newsid : "1"
/// newstitle : "Covid 19 Sudah mulai hilang"
/// newsdeskripsi : "Kabar dari WHO covid 19 sudah tidak lagi merupakan senuah pandemi"
/// newscreate : "2020-06-01 09:21:31"
/// newsaktif : "1"
/// newsupdate : null
/// newsdelete : null
/// newsthumbnail : null

class NewsM {
  String newsid;
  String newstitle;
  String newsdeskripsi;
  String newscreate;
  String newsaktif;
  dynamic newsupdate;
  dynamic newsdelete;
  dynamic newsthumbnail;

  static NewsM fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    NewsM newsMBean = NewsM();
    newsMBean.newsid = map['newsid'];
    newsMBean.newstitle = map['newstitle'];
    newsMBean.newsdeskripsi = map['newsdeskripsi'];
    newsMBean.newscreate = map['newscreate'];
    newsMBean.newsaktif = map['newsaktif'];
    newsMBean.newsupdate = map['newsupdate'];
    newsMBean.newsdelete = map['newsdelete'];
    newsMBean.newsthumbnail = map['newsthumbnail'];
    return newsMBean;
  }

  Map toJson() => {
        "newsid": newsid,
        "newstitle": newstitle,
        "newsdeskripsi": newsdeskripsi,
        "newscreate": newscreate,
        "newsaktif": newsaktif,
        "newsupdate": newsupdate,
        "newsdelete": newsdelete,
        "newsthumbnail": newsthumbnail,
      };
}
