import 'dart:math';

import 'package:deepseek_api/deepseek_api.dart';
import 'package:memo_for_ohos/deepseek_client/deepseek_client.dart';

import '../../common/common.dart';
import 'dart:convert';
import '../../storage_service/stoage_service.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late final FocusNode _contentFocusNode;
  String? _editingId;

  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    _contentFocusNode = FocusNode();

    final arg = Get.arguments;
    if (arg != null) {
      try {
        Map<String, dynamic>? map;
        if (arg is String && arg.isNotEmpty) {
          map = json.decode(arg) as Map<String, dynamic>;
        } else if (arg is Map<String, dynamic>) {
          map = arg;
        }
        if (map != null) {
          final NoteItem item = NoteItem.fromJson(map);
          _editingId = item.id;
          _titleController.text = item.title;
          _contentController.text = item.content;
        }
      } catch (_) {
        // ignore malformed argument
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  String _generateUuid() {
    final int micros = DateTime.now().microsecondsSinceEpoch;
    final int rand = Random().nextInt(0x7fffffff);
    return '${micros.toRadixString(16)}-${rand.toRadixString(16)}';
  }

  //获得提示内容
  Future<void> _deepSeekTopic(String content) async {
    isLoading = true;
    setState(() {});

    final response = await deepSeekClient.createChatCompletion(
      ChatCompletionRequest(
        model: 'deepseek-chat',
        messages: [ChatMessage(role: 'user', content: "请你帮我续写一下日记：$content",),],
        temperature: 0.7,
        maxTokens: 100,
        // stream: true,
      ),
    );
    _contentController.text=response.choices.first.message.content;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        //帮我写
        onPressed: () async {_deepSeekTopic(_contentController.text);},
        child: isLoading?const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ):const Icon(Icons.rocket_launch,color: Colors.white,size: 24,),
      ),
      appBar: AppBar(
        title: const Text('添加笔记'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _editingId ??= _generateUuid();
              final NoteItem updated = NoteItem(
                id: _editingId,
                title: _titleController.text,
                content: _contentController.text,
              );
              StorageService.instance.replaceNoteItemById(updated).then((ok) {
                if (ok) {
                  Get.back(result: true);
                } else {
                  Get.snackbar('未找到', '未找到对应的笔记');
                }
              });
            },
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _contentFocusNode.requestFocus();
        },
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: '请输入标题',
                  border: InputBorder.none,
                ),
              ),
              const Divider(height: 1),
              const SizedBox(height: 8),
              Expanded(
                child: TextField(
                  controller: _contentController,
                  focusNode: _contentFocusNode,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: '请输入笔记内容',
                    border: InputBorder.none,
                  ),
                  onChanged: (v){

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
