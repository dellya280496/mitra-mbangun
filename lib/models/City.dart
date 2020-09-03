/// rajaongkir : {"query":{"province":"11"},"status":{"code":200,"description":"OK"},"results":[{"city_id":"31","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Bangkalan","postal_code":"69118"},{"city_id":"42","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Banyuwangi","postal_code":"68416"},{"city_id":"51","province_id":"11","province":"Jawa Timur","type":"Kota","city_name":"Batu","postal_code":"65311"},{"city_id":"74","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Blitar","postal_code":"66171"},{"city_id":"75","province_id":"11","province":"Jawa Timur","type":"Kota","city_name":"Blitar","postal_code":"66124"},{"city_id":"80","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Bojonegoro","postal_code":"62119"},{"city_id":"86","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Bondowoso","postal_code":"68219"},{"city_id":"133","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Gresik","postal_code":"61115"},{"city_id":"160","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Jember","postal_code":"68113"},{"city_id":"164","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Jombang","postal_code":"61415"},{"city_id":"178","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Kediri","postal_code":"64184"},{"city_id":"179","province_id":"11","province":"Jawa Timur","type":"Kota","city_name":"Kediri","postal_code":"64125"},{"city_id":"222","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Lamongan","postal_code":"64125"},{"city_id":"243","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Lumajang","postal_code":"67319"},{"city_id":"247","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Madiun","postal_code":"63153"},{"city_id":"248","province_id":"11","province":"Jawa Timur","type":"Kota","city_name":"Madiun","postal_code":"63122"},{"city_id":"251","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Magetan","postal_code":"63314"},{"city_id":"256","province_id":"11","province":"Jawa Timur","type":"Kota","city_name":"Malang","postal_code":"65112"},{"city_id":"255","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Malang","postal_code":"65163"},{"city_id":"289","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Mojokerto","postal_code":"61382"},{"city_id":"290","province_id":"11","province":"Jawa Timur","type":"Kota","city_name":"Mojokerto","postal_code":"61316"},{"city_id":"305","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Nganjuk","postal_code":"64414"},{"city_id":"306","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Ngawi","postal_code":"63219"},{"city_id":"317","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Pacitan","postal_code":"63512"},{"city_id":"330","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Pamekasan","postal_code":"69319"},{"city_id":"342","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Pasuruan","postal_code":"67153"},{"city_id":"343","province_id":"11","province":"Jawa Timur","type":"Kota","city_name":"Pasuruan","postal_code":"67118"},{"city_id":"363","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Ponorogo","postal_code":"63411"},{"city_id":"369","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Probolinggo","postal_code":"67282"},{"city_id":"370","province_id":"11","province":"Jawa Timur","type":"Kota","city_name":"Probolinggo","postal_code":"67215"},{"city_id":"390","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Sampang","postal_code":"69219"},{"city_id":"409","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Sidoarjo","postal_code":"61219"},{"city_id":"418","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Situbondo","postal_code":"68316"},{"city_id":"441","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Sumenep","postal_code":"69413"},{"city_id":"444","province_id":"11","province":"Jawa Timur","type":"Kota","city_name":"Surabaya","postal_code":"60119"},{"city_id":"487","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Trenggalek","postal_code":"66312"},{"city_id":"489","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Tuban","postal_code":"62319"},{"city_id":"492","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Tulungagung","postal_code":"66212"}]}

class City {
  RajaongkirBean rajaongkir;

  static City fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    City cityBean = City();
    cityBean.rajaongkir = RajaongkirBean.fromMap(map['rajaongkir']);
    return cityBean;
  }

  Map toJson() => {
        "rajaongkir": rajaongkir,
      };
}

/// query : {"province":"11"}
/// status : {"code":200,"description":"OK"}
/// results : [{"city_id":"31","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Bangkalan","postal_code":"69118"},{"city_id":"42","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Banyuwangi","postal_code":"68416"},{"city_id":"51","province_id":"11","province":"Jawa Timur","type":"Kota","city_name":"Batu","postal_code":"65311"},{"city_id":"74","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Blitar","postal_code":"66171"},{"city_id":"75","province_id":"11","province":"Jawa Timur","type":"Kota","city_name":"Blitar","postal_code":"66124"},{"city_id":"80","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Bojonegoro","postal_code":"62119"},{"city_id":"86","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Bondowoso","postal_code":"68219"},{"city_id":"133","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Gresik","postal_code":"61115"},{"city_id":"160","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Jember","postal_code":"68113"},{"city_id":"164","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Jombang","postal_code":"61415"},{"city_id":"178","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Kediri","postal_code":"64184"},{"city_id":"179","province_id":"11","province":"Jawa Timur","type":"Kota","city_name":"Kediri","postal_code":"64125"},{"city_id":"222","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Lamongan","postal_code":"64125"},{"city_id":"243","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Lumajang","postal_code":"67319"},{"city_id":"247","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Madiun","postal_code":"63153"},{"city_id":"248","province_id":"11","province":"Jawa Timur","type":"Kota","city_name":"Madiun","postal_code":"63122"},{"city_id":"251","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Magetan","postal_code":"63314"},{"city_id":"256","province_id":"11","province":"Jawa Timur","type":"Kota","city_name":"Malang","postal_code":"65112"},{"city_id":"255","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Malang","postal_code":"65163"},{"city_id":"289","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Mojokerto","postal_code":"61382"},{"city_id":"290","province_id":"11","province":"Jawa Timur","type":"Kota","city_name":"Mojokerto","postal_code":"61316"},{"city_id":"305","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Nganjuk","postal_code":"64414"},{"city_id":"306","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Ngawi","postal_code":"63219"},{"city_id":"317","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Pacitan","postal_code":"63512"},{"city_id":"330","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Pamekasan","postal_code":"69319"},{"city_id":"342","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Pasuruan","postal_code":"67153"},{"city_id":"343","province_id":"11","province":"Jawa Timur","type":"Kota","city_name":"Pasuruan","postal_code":"67118"},{"city_id":"363","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Ponorogo","postal_code":"63411"},{"city_id":"369","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Probolinggo","postal_code":"67282"},{"city_id":"370","province_id":"11","province":"Jawa Timur","type":"Kota","city_name":"Probolinggo","postal_code":"67215"},{"city_id":"390","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Sampang","postal_code":"69219"},{"city_id":"409","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Sidoarjo","postal_code":"61219"},{"city_id":"418","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Situbondo","postal_code":"68316"},{"city_id":"441","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Sumenep","postal_code":"69413"},{"city_id":"444","province_id":"11","province":"Jawa Timur","type":"Kota","city_name":"Surabaya","postal_code":"60119"},{"city_id":"487","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Trenggalek","postal_code":"66312"},{"city_id":"489","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Tuban","postal_code":"62319"},{"city_id":"492","province_id":"11","province":"Jawa Timur","type":"Kabupaten","city_name":"Tulungagung","postal_code":"66212"}]

class RajaongkirBean {
  QueryBean query;
  StatusBean status;
  List<ResultsBeanCity> results;

  static RajaongkirBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RajaongkirBean rajaongkirBean = RajaongkirBean();
    rajaongkirBean.query = QueryBean.fromMap(map['query']);
    rajaongkirBean.status = StatusBean.fromMap(map['status']);
    rajaongkirBean.results = List()..addAll((map['results'] as List ?? []).map((o) => ResultsBeanCity.fromMap(o)));
    return rajaongkirBean;
  }

  Map toJson() => {
        "query": query,
        "status": status,
        "results": results,
      };
}

/// city_id : "31"
/// province_id : "11"
/// province : "Jawa Timur"
/// type : "Kabupaten"
/// city_name : "Bangkalan"
/// postal_code : "69118"

class ResultsBeanCity {
  String cityId;
  String provinceId;
  String province;
  String type;
  String cityName;
  String postalCode;

  static ResultsBeanCity fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ResultsBeanCity resultsBean = ResultsBeanCity();
    resultsBean.cityId = map['city_id'];
    resultsBean.provinceId = map['province_id'];
    resultsBean.province = map['province'];
    resultsBean.type = map['type'];
    resultsBean.cityName = map['city_name'];
    resultsBean.postalCode = map['postal_code'];
    return resultsBean;
  }

  Map toJson() => {
        "city_id": cityId,
        "province_id": provinceId,
        "province": province,
        "type": type,
        "city_name": cityName,
        "postal_code": postalCode,
      };
}

/// code : 200
/// description : "OK"

class StatusBean {
  int code;
  String description;

  static StatusBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    StatusBean statusBean = StatusBean();
    statusBean.code = map['code'];
    statusBean.description = map['description'];
    return statusBean;
  }

  Map toJson() => {
        "code": code,
        "description": description,
      };
}

/// province : "11"

class QueryBean {
  String province;

  static QueryBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    QueryBean queryBean = QueryBean();
    queryBean.province = map['province'];
    return queryBean;
  }

  Map toJson() => {
        "province": province,
      };
}
