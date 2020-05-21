import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hksy_flutter/public/public.dart';

class AboutusPage extends StatelessWidget {
  const AboutusPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "关于我们",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: ListView(
        // physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
            12, 0, 12, MediaQuery.of(context).padding.bottom),
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 48, 0, 46),
            alignment: Alignment.center,
            child: Image.asset(
              "images/logo_guanyuwomen@3x.png",
              height: 60.64,
              fit: BoxFit.fitHeight,
            ),
          ),
          HtmlWidget(
            "&nbsp;&nbsp;&nbsp;&nbsp;华科闪云（广东）科技有限公司（简称华科闪云）,总部位于广州市，是国内首批IPFS生态布道者，专业的分布式存储服务整体方案提供商，业界领先的IPFS & Filecoin终端服务提供商。<br>&nbsp;&nbsp;&nbsp;&nbsp;华科闪云目前拥有包括IPFS硬件技术研发,IPFS协议研究,IPFS底层程序开发，IPFS应用程序研发，IDC建设及运维等在内的数十名专业IPFS技术研发人才。<br>&nbsp;&nbsp;&nbsp;&nbsp;					    华科闪云技术研发团队在研究IPFS底层协议的基础上，全力以赴跟踪和研究Filecoin的运行机制，优化IDC机房配置，参与IPFS生态建设；并积极布局和拓展人工智能硬件及软件产品，探索为人工智能领域注入多元化的应用，为边缘计算提供可靠有效的市场策略。<br>&nbsp;&nbsp;&nbsp;&nbsp;华科闪云凭借丰富的行业垂直领域技术经验，从存储器研发、网络运营合作、机房选址、到人员运维，每个环节都经过严格的把控和精心设计，华科闪云数据中心以为IPFS生态提供安全、高效、可靠的保障支持为使命，为IPFS生态体系的各层次参与者提供存储器、数据支持、知识服务、应用开发、以及高效的分布式存储解决方案等一体化服务。",
            webView: true,
            textStyle: TextStyle(
              color: rgba(255, 255, 255, 1),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
