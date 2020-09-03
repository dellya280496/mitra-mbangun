/// id : "1"
/// nama : "Bahan Bangunan"
/// parent_id : null
/// slug : "bahan-bangunan"
/// icon : ""
/// show_on_homepage : "1"
/// urutan : "1"
/// created_at : "2020-07-30 10:50:57"
/// aktif : "1"

class Categories {
  String id;
  String nama;
  dynamic parentId;
  String slug;
  String icon;
  String showOnHomepage;
  String urutan;
  String createdAt;
  String aktif;

  static Categories fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Categories categoriesBean = Categories();
    categoriesBean.id = map['id'];
    categoriesBean.nama = map['nama'];
    categoriesBean.parentId = map['parent_id'];
    categoriesBean.slug = map['slug'];
    categoriesBean.icon = map['icon'];
    categoriesBean.showOnHomepage = map['show_on_homepage'];
    categoriesBean.urutan = map['urutan'];
    categoriesBean.createdAt = map['created_at'];
    categoriesBean.aktif = map['aktif'];
    return categoriesBean;
  }

  Map toJson() => {
        "id": id,
        "nama": nama,
        "parent_id": parentId,
        "slug": slug,
        "icon": icon,
        "show_on_homepage": showOnHomepage,
        "urutan": urutan,
        "created_at": createdAt,
        "aktif": aktif,
      };
}
