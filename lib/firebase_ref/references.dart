import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;

final questionPaperRF = firestore.collection('questionPapers');

DocumentReference questionRF(
        {required String paperID, required String questionID}) =>
    questionPaperRF.doc(paperID).collection("questions").doc(questionID);
