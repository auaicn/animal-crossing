import 'package:animal_crossing/common/d_text.kor.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

enum Source {
  insectCollection,
  beachWalking,
  fishing,
  diving,
  unknown;

  String get korean => switch (this) {
        Source.insectCollection => '곤충 채집',
        Source.beachWalking => '해변 산책',
        Source.fishing => '낚시',
        Source.diving => '다이빙',
        Source.unknown => '알수없음',
      };

  int get id => switch (this) {
        Source.insectCollection => 1,
        Source.beachWalking => 2,
        Source.fishing => 3,
        Source.diving => 4,
        Source.unknown => 0,
      };

  static Source fromId(int id) => switch (id) {
        1 => Source.insectCollection,
        2 => Source.beachWalking,
        3 => Source.fishing,
        4 => Source.diving,
        _ => Source.unknown,
      };
}

class Item {
  Item({
    required this.time,
    required this.location,
    required this.name,
    required this.source,
    required this.price,
  });

  final Source source;
  final int price;
  final String name;
  final String location;
  final String time;

  Item.fromDynamic(List<dynamic> data)
      : name = data[0].toString(),
        price = data[1],
        location = data[2].toString(),
        time = data[3].toString(),
        source = Source.fromId(data[4]);
}

class PricingSection extends StatefulWidget {
  const PricingSection({
    super.key,
  });

  @override
  State<PricingSection> createState() => _PricingSectionState();
}

class _PricingSectionState extends State<PricingSection> {
  final TextEditingController controller = TextEditingController();

  List<Item> fields$original = [];
  List<Item> fields$filtered = [];

  @override
  void initState() {
    super.initState();

    _loadCsv();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: '이름명',
              hintText: '이름을 입력해주세용',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
                borderSide: BorderSide(color: Colors.black),
              ),
              prefixIcon: Icon(Icons.search),
            ),
            onSubmitted: (text) {
              final trimmedText = text.replaceAll(' ', '').trim();

              if (trimmedText.isEmpty) {
                setState(() {
                  fields$filtered = fields$original;
                });

                return;
              }

              setState(() {
                fields$filtered = fields$original.where((field) {
                  bool name$has = field.name
                      .replaceAll(' ', '')
                      .trim()
                      .contains(trimmedText);
                  // bool name$location = field.location
                  //     .replaceAll(' ', '')
                  //     .trim()
                  //     .contains(trimmedText);
                  // bool time$has =
                  //     field.time.replaceAll(' ', '').trim().contains(trimmedText);

                  return name$has; // || name$location // || time$has;
                }).toList();
              });
            },
          ),
          SizedBox(height: 20),
          Expanded(
            child: fields$original.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : fields$filtered.isEmpty
                    ? Center(
                        child: DText$Kor(text: 'No results found'),
                      )
                    : InteractiveViewer(
                        constrained: false,
                        child: DataTable(
                          headingRowHeight: 40,
                          columnSpacing: 12,
                          horizontalMargin: 8,
                          headingRowColor:
                              WidgetStatePropertyAll(Colors.black12),
                          columns: const [
                            DataColumn(
                              label: SizedBox(
                                child: DText$Kor(bold: true, text: '획득 방법'),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                child: DText$Kor(bold: true, text: '이름'),
                              ),
                            ),
                            DataColumn(
                                label: SizedBox(
                                  child: DText$Kor(bold: true, text: '가격'),
                                ),
                                numeric: true),
                            DataColumn(
                              label: SizedBox(
                                child: DText$Kor(
                                  bold: true,
                                  text: '획득 방법 (출몰 장소)',
                                ),
                              ),
                            ),
                            DataColumn(
                              label: DText$Kor(
                                bold: true,
                                text: '출몰 시간',
                              ),
                            ),
                          ],
                          rows: [
                            ...fields$filtered.map(
                              (field) => DataRow(
                                onLongPress: () => {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: DText$Kor(
                                        text: field.name,
                                        fontSize: 20,
                                        bold: true,
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          DText$Kor(
                                            text:
                                                '획득 방법: ${field.source.korean}',
                                          ),
                                          DText$Kor(
                                            text: '가격: ${field.price} 벨',
                                          ),
                                          DText$Kor(
                                            text:
                                                '획득 방법 (출몰 장소): ${field.location}',
                                          ),
                                          DText$Kor(
                                            text:
                                                '출몰 시간 \n${field.time.replaceAll('\n\n', '\n')}',
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: DText$Kor(text: '닫기'),
                                        ),
                                      ],
                                    ),
                                  ),
                                },
                                cells: [
                                  DataCell(
                                    DText$Kor(
                                      text: field.source.korean,
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 80,
                                      child: DText$Kor(
                                        text: field.name,
                                        bold: true,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: DText$Kor(
                                          text:
                                              '${field.price > 1000 ? '${(field.price / 1000).floor()}, ${(field.price % 1000).toString().padLeft(3, '0')}' : field.price} 벨'),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 120,
                                      child: DText$Kor(
                                        text: field.location
                                            .replaceAll('\n', ' '),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 120,
                                      child: Builder(builder: (context) {
                                        // Regular expression to match the pattern "<digit> AM/PM ~ <digit> AM/PM"
                                        final pattern = RegExp(
                                            r'(\d{1,2} (?:AM|PM) ~ \d{1,2} (?:AM|PM))');

                                        // Insert newline before the matched pattern
                                        String result = field.time
                                            .replaceAll('\n', ' ')
                                            .replaceAll('모든', '\n모든')
                                            .replaceAllMapped(pattern,
                                                (match) => '\n${match[0]}');

                                        return DText$Kor(
                                          text: result,
                                          // .time
                                          //     .replaceAll(r'\d PM', 'ㅋㅋ'),
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
          )
        ],
      ),
    );
  }

  _loadCsv() async {
    final rawData = await rootBundle.loadString('assets/csvs/price.csv');

    List<List<dynamic>> listData = const CsvToListConverter().convert(
      rawData,
      eol: '\n',
    );

    setState(() {
      fields$original = listData
          .map(
            (field) => Item.fromDynamic(field),
          )
          .toList();

      fields$filtered = fields$original;
    });
  }
}
