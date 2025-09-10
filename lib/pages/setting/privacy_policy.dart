import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("隐私政策"),
      ),
      body:Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              "隐私政策",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text("生效日期：2025年9月10日\n"),
            Text(
              "本应用（以下简称「记事本」）尊重并保护所有用户的个人隐私。为了向您提供更好的服务，本应用在使用过程中会涉及必要的数据处理。请您仔细阅读本隐私政策。\n",
            ),

            _sectionTitle("一、我们收集的信息"),
            Text("1. 设备信息：通过 package_info_plus 获取应用版本号、应用包名，用于问题排查和版本更新提示。\n"
                "2. 本地存储数据：通过 get_storage 保存您的笔记内容、应用设置，所有数据仅存储在您本地设备，不会上传至服务器。\n"
                "3. 网络请求：如您启用 DeepSeek API 相关功能，应用会调用 deepseek_api 进行网络请求，本应用不会收集或存储您的内容。\n"),

            _sectionTitle("二、我们如何使用信息"),
            Text("提供核心功能（笔记记录与分类）、改进用户体验（如界面刷新、加载动画）、以及应用运行所需的依赖库支持。\n"),

            _sectionTitle("三、信息存储与安全"),
            Text("应用数据主要存储在本地，除非您主动分享，否则不会上传至任何服务器。若使用第三方服务（如 DeepSeek API），请参考其隐私政策。\n"),

            _sectionTitle("四、第三方服务说明"),
            Text("• DeepSeek API：可能涉及您的笔记内容，请参考该服务的隐私政策。\n"
                "• 其他依赖库（get_storage、get、pull_to_refresh 等）仅用于功能实现，不涉及个人数据收集。\n"),

            _sectionTitle("五、您的权利"),
            Text("您可随时清空或删除笔记数据，卸载应用即可彻底清除所有本地存储数据。\n"),

            _sectionTitle("六、变更"),
            Text("我们可能会根据功能优化或法律法规要求更新隐私政策。更新后的隐私政策将在应用内或应用商店页面公示。\n"),

            _sectionTitle("七、联系我们"),
            Text("如您对本隐私政策有任何疑问或建议，请通过以下方式联系我们：\n"
                "📧 邮箱：your_email@example.com\n"),
          ],
        ),
      ),
    );
  }
}

class _sectionTitle extends StatelessWidget {
  final String text;
  const _sectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
