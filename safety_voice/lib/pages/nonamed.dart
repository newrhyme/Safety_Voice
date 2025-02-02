import 'package:flutter/material.dart';




class Nonamed extends StatelessWidget {
  const Nonamed({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), // AppBar 높이를 80으로 설정
        child: AppBar(
          backgroundColor: Colors.white,
          title: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/listhome'),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/back.png', // back.png 이미지
                  height: 24, // 이미지 높이
                ),
                const SizedBox(width: 8), // 이미지와 텍스트 사이 간격
                Text(
                  "이름 없는 파일",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.07,
                  ),
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
        ),
      ),


      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 99.0, // 빈 상자 높이
              color: Colors.transparent, // 상자 투명
              child: GestureDetector(
                onTap: () {
                },
                child: Align(
                  alignment: Alignment.topLeft, // 왼쪽 위 정렬
                  child: Container(
                    margin: EdgeInsets.only(top: 22.0, left: 15.0),
                    child: Text(
                      '20241106_2mp3',
                      style: TextStyle(
                        color: Colors.black, // 텍스트 색상
                        fontSize: 20.0, // 텍스트 크기
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              // margin: const EdgeInsets.symmetric(vertical: 8.0), // 여백 추가
              width: double.infinity,
              height: 1.0, // 실선 두께
              color: Color(0xFFCACACA), // 실선 색상
            ),
            Container(
              width: double.infinity,
              height: 99.0, // 빈 상자 높이
              color: Colors.transparent, // 상자 투명
            ),
            Container(
              // margin: const EdgeInsets.symmetric(vertical: 8.0), // 여백 추가
              width: double.infinity,
              height: 1.0, // 실선 두께
              color: Color(0xFFCACACA), // 실선 색상
            ),
            Container(
              width: double.infinity,
              height: 99.0, // 빈 상자 높이
              color: Colors.transparent, // 상자 투명
            ),
            Container(
              // margin: const EdgeInsets.symmetric(vertical: 8.0), // 여백 추가
              width: double.infinity,
              height: 1.0, // 실선 두께
              color: Color(0xFFCACACA), // 실선 색상
            ),
            Container(
              width: double.infinity,
              height: 99.0, // 빈 상자 높이
              color: Colors.transparent, // 상자 투명
            ),
            Container(
              // margin: const EdgeInsets.symmetric(vertical: 8.0), // 여백 추가
              width: double.infinity,
              height: 1.0, // 실선 두께
              color: Color(0xFFCACACA), // 실선 색상
            ),
            Container(
              width: double.infinity,
              height: 99.0, // 빈 상자 높이
              color: Colors.transparent, // 상자 투명
            ),
            Container(
              // margin: const EdgeInsets.symmetric(vertical: 8.0), // 여백 추가
              width: double.infinity,
              height: 1.0, // 실선 두께
              color: Color(0xFFCACACA), // 실선 색상
            ),
          ],
        ),
      ),

    );
  }
}