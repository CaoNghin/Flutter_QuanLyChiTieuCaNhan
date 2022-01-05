import 'package:daily_spending/constants/convert.dart';
import 'package:daily_spending/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListItems extends StatefulWidget {
  final Transaction trx;
  final Function dltTrxItem;

  const TransactionListItems({
    Key key,
    @required this.trx,
    @required this.dltTrxItem,
  }) : super(key: key);
  @override
  _TransactionListItemsState createState() => _TransactionListItemsState();
}

class _TransactionListItemsState extends State<TransactionListItems> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: const EdgeInsets.all(8.0),
              child: Text(

                  Themdaucham(widget.trx.amount) +" VNĐ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorDark,
                  )),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.trx.title}",
                  style: Theme.of(context).textTheme.headline1,


                ),
                Text(
                  "Loại chi tiêu: ${widget.trx.category}",
                  style: TextStyle(color: Color(0xFF031345), fontSize: 14),

                ),
                Text(
                  "Ngày: "+DateFormat('d/M/y'' - EEEE, MMM d, yyyy' ).format(widget.trx.date),
                  style: TextStyle(color: Color(0xFF180407), fontSize: 14),
                )
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () => showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                        title: const Text('Thông báo xác nhận xóa'),
                        content: const Text(
                            'Bạn có chắc chắn là muốn xóa chi tiêu này?'),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                widget.dltTrxItem(widget.trx.id);
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Có, Hãy xóa!',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor),
                              )),
                          FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Không, Trở về!',
                                style: TextStyle(fontSize: 20),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
