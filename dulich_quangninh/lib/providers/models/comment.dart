class Comment {
  String content;
  String fullName;
  String type;
  String uid;
  int createAt = DateTime.now().millisecondsSinceEpoch;
  int updateAt = DateTime.now().millisecondsSinceEpoch;
  int like;
  String avatar;
  String id;

  DateTime get createDateTime =>
      createAt != null ? DateTime.fromMillisecondsSinceEpoch(createAt) : null;

  DateTime get updateDateTime =>
      createAt != null ? DateTime.fromMillisecondsSinceEpoch(updateAt) : null;

  Comment(
      {this.content,
      this.fullName,
      this.type = 'text',
      this.uid,
      this.like = 0,
      this.avatar}) {
    createAt = DateTime.now().millisecondsSinceEpoch;
    updateAt = DateTime.now().millisecondsSinceEpoch;
  }

  Comment.fromJson(Map<String, dynamic> json, [String id]) {
    this.id = id;
    content = json['content'];
    fullName = json['full-name'];
    type = json['type'];
    uid = json['uid'];
    createAt = json['create-at'];
    updateAt = json['update-at'];
    like = json['like'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['full-name'] = this.fullName;
    data['type'] = this.type;
    data['uid'] = this.uid;
    data['create-at'] = this.createAt;
    data['update-at'] = this.updateAt;
    data['like'] = this.like;
    data['avatar'] = this.avatar;
    return data;
  }
}
