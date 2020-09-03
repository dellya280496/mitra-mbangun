/// data : {"id":"17","username":"denifrahman@gmail.com","password":"cdc873eb53394edd5376fca3d599be03","foto":"https://lh3.googleusercontent.com/a-/AOh14GgJnQsEqeBcW14PgwxZpMLLhaYz3b12T9jgXw_icQ=s1337","status_user":"user","aktif":"1","token":null,"id_user":"21","id_mitra":null,"id_google":"105606415908453146944"}
/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE3IiwidXNlcm5hbWUiOiJkZW5pZnJhaG1hbkBnbWFpbC5jb20iLCJpYXQiOjE1OTYwMzY5NjcsImV4cCI6MTU5NjA1NDk2N30.PI15ovmsseceP6S-oS5EUBX6R2tsEHxwBNwGLhdLp3o"
/// expiresIn : 18000

class Auth {
  DataBean data;
  String token;
  int expiresIn;

  static Auth fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Auth authBean = Auth();
    authBean.data = DataBean.fromMap(map['data']);
    authBean.token = map['token'];
    authBean.expiresIn = map['expiresIn'];
    return authBean;
  }

  Map toJson() => {
        "data": data,
        "token": token,
        "expiresIn": expiresIn,
      };
}

/// id : "17"
/// username : "denifrahman@gmail.com"
/// password : "cdc873eb53394edd5376fca3d599be03"
/// foto : "https://lh3.googleusercontent.com/a-/AOh14GgJnQsEqeBcW14PgwxZpMLLhaYz3b12T9jgXw_icQ=s1337"
/// status_user : "user"
/// aktif : "1"
/// token : null
/// id_user : "21"
/// id_mitra : null
/// id_google : "105606415908453146944"

class DataBean {
  String id;
  String username;
  String password;
  String foto;
  String statusUser;
  String aktif;
  dynamic token;
  String idUser;
  dynamic idMitra;
  String idGoogle;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.id = map['id'];
    dataBean.username = map['username'];
    dataBean.password = map['password'];
    dataBean.foto = map['foto'];
    dataBean.statusUser = map['status_user'];
    dataBean.aktif = map['aktif'];
    dataBean.token = map['token'];
    dataBean.idUser = map['id_user'];
    dataBean.idMitra = map['id_mitra'];
    dataBean.idGoogle = map['id_google'];
    return dataBean;
  }

  Map toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "foto": foto,
        "status_user": statusUser,
        "aktif": aktif,
        "token": token,
        "id_user": idUser,
        "id_mitra": idMitra,
        "id_google": idGoogle,
      };
}
