import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/enums/message_node_type.dart';
import 'package:tencent_im_plugin/enums/message_status_enum.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';
import 'package:tencent_im_plugin/message_node/text_message_node.dart';
import '../../../public/public.dart';
import '../../mine/mine_homepage.dart';

class ChartMessageCell extends StatelessWidget {
  MessageEntity message;
  kVoidFunctionBlock resendHandle;
  kVoidFunctionBlock deleteHandle;
  String messageDate = "";
  ChartMessageCell({
    Key key,
    this.message,
    this.resendHandle,
    this.deleteHandle,
    this.messageDate,
  }) : super(key: key);

  GlobalKey _deleteKey = GlobalKey();

  //处理消息内容
  String _handleMessageContent() {
    List<MessageNode> elems = message.elemList;
    if (elems == null || elems.length == 0) {
      return "";
    }

    // 只取第一个
    TextMessageNode node = elems[0];
    if (node == null) {
      return "";
    }

    String _content = "";
    switch (node.nodeType) {
      case MessageNodeType.Text:
        TextMessageNode value = node;
        _content = value.content;
        break;
      case MessageNodeType.Image:
        _content = "[图片消息]";
        break;
      case MessageNodeType.Sound:
        _content = "[声音消息]";
        break;
      case MessageNodeType.Custom:
        _content = "[自定义节点，未指定解析规则]";
        break;
      case MessageNodeType.Video:
        _content = "[视频消息]";
        break;
      case MessageNodeType.Location:
        _content = "[定位消息]";
        break;
      case MessageNodeType.GroupTips:
        _content = "[群提示节点，未指定解析规则]";
        break;
      case MessageNodeType.Other:
      case MessageNodeType.SnsTips:
        _content = "[不支持的消息节点]";
        break;
      default:
    }

    return _content;
  }

  @override
  Widget build(BuildContext context) {
    return message == null
        ? Container()
        : Container(
            padding: EdgeInsets.fromLTRB(15, 12.5, 15, 12.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //时间
                ObjectUtil.isEmptyString(messageDate) == false
                    ? Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 16.5),
                        alignment: Alignment.center,
                        child: Text(
                          messageDate,
                          style: TextStyle(
                            fontSize: 11,
                            color: rgba(172, 172, 172, 1),
                          ),
                        ),
                      )
                    : Container(),
                //内容
                // type == 0
                //     ? Container(
                //         alignment: Alignment.center,
                //         child: Container(
                //           padding: EdgeInsets.fromLTRB(10.5, 3.5, 10.5, 3.5),
                //           decoration: BoxDecoration(
                //             color: rgba(0, 0, 0, 0.2),
                //             borderRadius: BorderRadius.circular(22 / 2),
                //           ),
                //           child: Text(
                //             "通过附近的人向你打招呼",
                //             textAlign: TextAlign.center,
                //             overflow: TextOverflow.ellipsis,
                //             style: TextStyle(
                //               fontSize: 11,
                //               color: rgba(255, 255, 255, 0.9),
                //             ),
                //           ),
                //         ),
                //       )
                //     :
                Container(
                  child: message.self == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            //发送状态
                            message.status == MessageStatusEnum.Sending
                                ? Container(
                                    width: 10,
                                    height: 10,
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                    ),
                                  )
                                : message.status == MessageStatusEnum.SendFail
                                    ? Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 10),
                                        child: InkWell(
                                          onTap: () {
                                            if (this.resendHandle != null) {
                                              this.resendHandle();
                                            }
                                          },
                                          borderRadius:
                                              BorderRadius.circular(12 / 2),
                                          child: Image.asset(
                                            "images/tishi@3x.png",
                                            width: 12,
                                            height: 12,
                                          ),
                                        ),
                                      )
                                    : Container(),
                            SizedBox(
                              width: 10,
                            ),
                            //本人消息内容
                            InkWell(
                              key: _deleteKey,
                              borderRadius: BorderRadius.circular(10),
                              onLongPress: () {
                                PopupMenu menu = PopupMenu(
                                  items: [
                                    MenuItem(
                                      title: "删除",
                                      image: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                  onClickMenu: (item) {
                                    if (item.menuTitle == "删除") {
                                      if (deleteHandle != null) {
                                        deleteHandle();
                                      }
                                    }
                                  },
                                );

                                PopupMenu.context = context;
                                menu.show(
                                  widgetKey: _deleteKey,
                                );
                              },
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: 200,
                                  minHeight: 46,
                                ),
                                padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                                decoration: BoxDecoration(
                                  color: rgba(255, 233, 146, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        this._handleMessageContent(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: rgba(0, 0, 0, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            //消息读取状态 chat_message_readed@3x.png chat_message_unreaded@3x.png
                            Image.asset(
                              message.peerReaded == true
                                  ? "images/chat_message_unreaded@3x.png"
                                  : "images/chat_message_unread@3x.png",
                              width: 15,
                              height: 15,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            //非本人头像
                            InkWell(
                              child: ClipRRect(
                                child: CachedNetworkImage(
                                  placeholder: (context, url) {
                                    return Image.asset(
                                      "images/placeholder_mini@3x.png",
                                      width: 46,
                                      height: 46,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                  imageUrl: (message.userInfo != null &&
                                          message.userInfo.faceUrl != null)
                                      ? message.userInfo.faceUrl
                                      : "",
                                  width: 46,
                                  height: 46,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(46 / 2),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return MineHomePage(
                                      userId: message.sessionId,
                                    );
                                  }),
                                );
                              },
                              borderRadius: BorderRadius.circular(67 / 2),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            //消息内容
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: 200,
                                minHeight: 46,
                              ),
                              padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                              decoration: BoxDecoration(
                                color: rgba(255, 255, 255, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      this._handleMessageContent(),
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: rgba(51, 51, 51, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          );
  }
}
