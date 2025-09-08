import '../../common/common.dart';

class AddNoteLogic extends GetxController {
  static AddNoteLogic? get logic => DependencyTool.capture(Get.find);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    // TODO: implement onReady
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    AddNoteLogic logic = Get.put(AddNoteLogic());
    final TextEditingController _controller = TextEditingController();
    final FocusNode _focusNode = FocusNode();

    return Scaffold(
      appBar: AppBar(
        title: const Text('添加笔记'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // 保存逻辑
              // 例如：logic.saveNote(_controller.text);
            },
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _focusNode.requestFocus();
        },
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: '请输入笔记内容',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
