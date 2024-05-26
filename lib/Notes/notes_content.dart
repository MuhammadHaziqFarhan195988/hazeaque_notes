//this is the data model


class NotesContent {
 final String title;
 final String? content;
 String? id;

DateTime dateCreated;

 NotesContent({
  this.id,
  required this.title,
  required this.content,
  required this.dateCreated
  });

  Map<String, Object?> packageForLaunch(){

    return {
      'title': title,
      'content': content,
      'date_created':dateCreated.toString(),
    };
  }

}