import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp(functions.config().firebase);

export const company = functions.https.onRequest((request, response) => {    
    const companyId = request.path;

    admin.firestore().collection('company').doc(companyId).get().then(result => {
        response.send(result.data());
    }).catch(error => {
        response.send(error);
    });
});