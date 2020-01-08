class Tile{
  String title;
  String description;
  String image;
  bool priority;
  int id;
  bool completed;

  Tile({this.title, this.description, this.image, this.priority,this.completed});
  Tile.withId({this.title,this.description,this.image,this.priority,this.id,this.completed});


    factory Tile.fromMap(Map<String, dynamic> data) => Tile.withId(
        id: data["id"],
        title: data["title"],
        description: data["description"],
        image: data["image"],
        priority: data["priority"]==1?true:false,
        completed: data["completed"]==1?true:false,

    );

    Map<String, dynamic> toMap() => {
      "id":id,
        "title": title,
        "description": description,
        "image": image,
        "priority":priority,
        "completed":completed
    };
}