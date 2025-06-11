// Use este código. Copie e cole, substituindo todo o conteúdo do index.js
const functions = require("firebase-functions");

exports.onAlertaCriado = functions.firestore
    .document("alertas/{alertaId}")
    .onCreate((snap, context) => {
      const dadosDoAlerta = snap.data();
      const nome = dadosDoAlerta.nome;

      functions.logger.info(
          `!!! NOVO ALERTA RECEBIDO NA NUVEM para ${nome} !!!`,
          {structuredData: true},
      );

      // Futuramente, aqui adicionaremos o código do Twilio.
      return null;
    });
