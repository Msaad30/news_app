/*

we are getting this data by using API
    => https://jsonplaceholder.typicode.com/todos/1

  {
    "userId": 1,
    "id": 1,
    "title": "delectus aut autem",
    "completed": false
  }

*/

class UserModel{

  int userId;
  int id;
  String title;
  bool completed;

  UserModel({required this.userId, required this.id,  required this.title, required this.completed});

  factory UserModel.fromJson(Map<String, dynamic>mapData){
    return UserModel(
      title : mapData['title'],
      completed: mapData['completed'],
      id: mapData['id'],
      userId: mapData['userId'],
    );
  }

  Map<String, dynamic>toJson(){
    return {
      "id" : id,
      "title" : title,
      "userId" : userId,
      "completed" : completed,
    };
  }

}