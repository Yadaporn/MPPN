import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFA600),
        title: Text(
          'MPPN 2024 นโยบายความเป็นส่วนตัว',
          style: GoogleFonts.anuphan(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context); // ใช้ Navigator.pop เพื่อกลับหน้า
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'นโยบายความเป็นส่วนตัว',
                style: GoogleFonts.anuphan(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                'นโยบายการคุ้มครองข้อมูลส่วนบุคคลฉบับนี้ปรับปรุงล่าสุดเมื่อวันที่ 15 กันยายน 2566',
                style: GoogleFonts.anuphan(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              Divider(),
              SizedBox(height: 16.0),
              Text(
                '1. ข้อมูลส่วนบุคคล',
                style: GoogleFonts.anuphan(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '         ข้อมูลส่วนบุคคลที่เรารวบรวมจะใช้เพื่อวัตถุประสงค์เฉพาะเท่านั้น '
                    'และจะไม่ถูกเปิดเผยหรือนำไปใช้งานในทางที่ไม่เกี่ยวข้องกับบริการที่เราให้'
                    ' ข้อมูลที่เกี่ยวข้องอาจรวมถึงชื่อ, ที่อยู่อีเมล, ที่อยู่ที่อาศัย, หรือข้อมูลอื่นๆ'
                    ' ที่ผู้ใช้จัดหาให้',
                style: GoogleFonts.anuphan(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '2. การเก็บข้อมูล',
                style: GoogleFonts.anuphan(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '         เราอาจใช้เทคโนโลยีต่าง ๆ เพื่อเก็บข้อมูลการใช้บริการ เช่น คุกกี้, '
                    'เครื่องมือวิเคราะห์ข้อมูล, และเทคโนโลยีการติดตามอื่น ๆ '
                    'เพื่อเก็บข้อมูลการเข้าถึงและใช้งานบริการของเรา',
                style: GoogleFonts.anuphan(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '3. การใช้ข้อมูล',
                style: GoogleFonts.anuphan(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '         ข้อมูลที่เรารวบรวมอาจถูกใช้เพื่อปรับปรุงและปรับแต่งบริการของเรา, '
                    'การติดต่อผู้ใช้, การสนับสนุน, การวิเคราะห์, และวัตถุประสงค์อื่นๆ'
                    ' ตามที่เกี่ยวข้องกับบริการของเรา',
                style: GoogleFonts.anuphan(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '4. การเปิดเผยข้อมูล',
                style: GoogleFonts.anuphan(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '         เราจะไม่เปิดเผยข้อมูลส่วนบุคคลของคุณกับบุคคลที่สาม'
                    ' ยกเว้นในกรณีที่จำเป็นตามกฎหมายหรือเมื่อมีคำสั่งจากหน่วยงานราชการที่เกี่ยวข้อง',
                style: GoogleFonts.anuphan(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '5. ความปลอดภัยของข้อมูล',
                style: GoogleFonts.anuphan(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '         เราใช้มาตรการที่เหมาะสมเพื่อปกป้องข้อมูลของคุณ '
                    'แต่เราไม่สามารถรับประกันความปลอดภัยของข้อมูลที่ถูกส่งผ่านอินเทอร์เน็ตได้เต็มที่',
                style: GoogleFonts.anuphan(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '6. การเข้าถึงและการแก้ไขข้อมูลส่วนบุคคล',
                style: GoogleFonts.anuphan(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '         คุณสามารถขอเข้าถึงหรือแก้ไขข้อมูลส่วนบุคคลของคุณได้ที่ทุกเวลา'
                    ' โดยติดต่อเราทางอีเมลของเรา',
                style: GoogleFonts.anuphan(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'การติดต่อเรา',
                style: GoogleFonts.anuphan(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Divider(),
              SizedBox(height: 8.0),
              Text(
                'หากมีคำถามหรือข้อสงสัยเกี่ยวกับนโยบายความเป็นส่วนตัวของเรา ติดต่อได้ที่ mppn2024@email.com',
                style: GoogleFonts.anuphan(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
