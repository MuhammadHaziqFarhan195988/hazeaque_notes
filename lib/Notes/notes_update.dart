import 'package:flutter/material.dart';
import 'package:hazeaque_note/Notes/notes_content.dart';

// ignore: must_be_immutable
class NotesUpdate extends StatefulWidget {
  NotesUpdate({super.key, required this.updateNotes, required this.existingContent, required this.existingTitle, required this.notes});
  final String existingContent, existingTitle;
final void Function( String id, NotesContent updatedData) updateNotes;
NotesContent notes;

  @override
  State<NotesUpdate> createState() => _NotesUpdateState();
}

class _NotesUpdateState extends State<NotesUpdate> {
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _titleEditingController = TextEditingController();
    final FocusNode _focusNode = FocusNode();

    @override
  void initState() {
    super.initState();
    // Request focus when the widget initializes
    _focusNode.requestFocus();
  }

    @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose(); // Dispose the focus node when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

_textEditingController = TextEditingController(text: widget.existingContent);
 _titleEditingController = TextEditingController(text: widget.existingTitle);
 return PopScope(
  onPopInvoked: _willPop,
   child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: SizedBox(
            width: 270,
            child: TextField(
                focusNode: _focusNode,
                controller: _titleEditingController,
                decoration:const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter your Title here',
                ),
                          ),
          ),
          flexibleSpace: Container(
            height: 110,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
                colors: [Colors.black, Colors.teal])
            ),
          ),
         
        ),
        body:  Container(
          height: 390,
          padding:const EdgeInsets.all(20.0),
          child: TextField(
            controller: _textEditingController,
            decoration:const InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Enter your note here',
              border: OutlineInputBorder(),
            ),
            maxLines: 100, // Allow multiline input
            keyboardType: TextInputType.multiline,
          ),
        ),
      ),
 );
  }


Future<void> _willPop(bool pop) async {
if(_textEditingController.text.isNotEmpty && _titleEditingController.text.isNotEmpty){
  widget.updateNotes(widget.notes.id! ,NotesContent(title: _titleEditingController.text,content: _textEditingController.text,dateCreated: widget.notes.dateCreated));

}
else {

}
}


}
