import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Me extends StatelessWidget {
	@override
	Widget build(BuildContext context) {

		return GestureDetector(
				child: Scaffold(
				body: SingleChildScrollView(
					child: Column(
						children: [
							Container(
								padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
								margin: EdgeInsets.only(top: 25),
								child: Row(
									mainAxisAlignment: MainAxisAlignment.end,
									children: [
										IconButton(
											onPressed: () => Get.back(),
											icon: Icon(
												Icons.close,
												size: 30,
												color: Colors.orange
											),
										),
									],
								),
							),
							Container(
								padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
								margin: EdgeInsets.only(top: 10),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.stretch,
									children: [
										Text(
											'--- Contact the developer Langford Kwabena ---',
											style: TextStyle(
												fontSize: 23,
												color: Colors.grey.withOpacity(0.6),
												fontWeight: FontWeight.bold,
												fontFamily: 'OpenSans-Regular'
											),
										),
										SizedBox(height: 25),
										Row(
											children: [
												Icon(
													Icons.phone,
													//color: Colors.grey.withOpacity(0.6)
													color: Colors.orange
												),
												SizedBox(width: 10),
												Text(
													'+233 (550) 202871',
													style: TextStyle(
														fontSize: 16,
														color: Colors.grey.withOpacity(0.6),
														fontFamily: 'OpenSans-Regular'
													),
												),
											],
										),
										SizedBox(height: 10),
										Row(
											children: [
												Icon(
													Icons.mail,
													//color: Colors.grey.withOpacity(0.6)
													color: Colors.orange
												),
												SizedBox(width: 10),
												Text(
													'langfordquarshie21@gmail.com',
													style: TextStyle(
														fontSize: 16,
														color: Colors.grey.withOpacity(0.6),
														fontFamily: 'OpenSans-Regular'
													),
												),
											],
										),
									],
								),
							),
						]
					),
				),
			),
		);
	}
}