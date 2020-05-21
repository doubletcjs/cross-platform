import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hksy_flutter/public/public.dart';

class AgreenMentPage extends StatelessWidget {
  const AgreenMentPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "用户协议",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
            12, 39, 12, MediaQuery.of(context).padding.bottom),
        children: <Widget>[
          HtmlWidget(
            "欢迎您使用华科闪云的服务！<br>为使用华科闪云的服务，您应当阅读并遵守《华科闪云服务协议》（以下简称“本协议”）和《华科闪云隐私政策》。请您务必审慎阅读、充分理解各条款内容，特别是免除或者限制华科闪云责任的条款、对用户权利进行限制的条款、约定争议解决方式和司法管辖的条款（如第十八条相关约定）等，以及开通或使用某项服务的单独协议或规则。限制、免责条款或者其他涉及您重大权益的条款可能以加粗、加下划线等形式提示您重点注意。除非您已充分阅读、完全理解并接受本协议所有条款，否则您无权使用华科闪云服务。您点击“同意”或“下一步”，或您使用华科闪云服务，或者以其他任何明示或者默示方式表示接受本协议的，均视为您已阅读并同意签署本协议。本协议即在您与华科闪云之间产生法律效力，成为对双方均具有约束力的法律文件。 <br><span class=span'></span>如果您因年龄、智力等因素而不具有完全民事行为能力，请在法定监护人（以下简称'监护人'）的陪同下阅读和判断是否同意本协议，并特别注意未成年人使用条款。 <br><span class='span'></span>如果您是中国大陆地区以外的用户，您订立或履行本协议还需要同时遵守您所属和/或所处国家或地区的法律。",
            webView: true,
            textStyle: TextStyle(
              color: rgba(255, 255, 255, 1),
              fontSize: 13,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
