import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key, required this.inputCatatan});
final void Function(String title, String content) inputCatatan;

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final TextEditingController _textEditingController = TextEditingController();
  final _titleEditingController = TextEditingController();
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
  widget.inputCatatan(_titleEditingController.text, _textEditingController.text);

}
else {

}
}


}
