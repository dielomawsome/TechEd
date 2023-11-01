/* eslint-disable no-undef */
sap.ui.define([
    "sap/m/Button",
    "sap/m/Dialog",
    "sap/m/FormattedText"
], function(Button, Dialog, FormattedText) {
    'use strict';

    return {
        onPress: async function(oEvent) {
            try {
                const title = oEvent.getProperty('title'); //could be 'descr' too if you prefer
                this._view.setBusy(true)

                const headers = new Headers();
                headers.append("Content-Type", "application/json");
                
                const body = JSON.stringify({
                  "Question": title
                });
   
                const response = await fetch('https://w2n1b8qko7.execute-api.us-east-1.amazonaws.com/v2/fix', {
                    method: 'POST',
                    headers,
                    body,
                    redirect: 'follow'
                  });
    
                const htmlText = (await response.text()).replace(/\\n/g, "<br/>").replace(/^"[\s]*|\s*"$/gi, "");

                const dialog = new Dialog({
                    title: "Solution",
                    content: new FormattedText({htmlText}),
                    beginButton: new Button({
                        text: "Close",
                        press: function() {
                            dialog.close();
                        }
                    }),
                    afterClose: function() {
                        dialog.destroy();
                    }
                });

                dialog.addStyleClass("sapUiResponsivePadding--content sapUiResponsivePadding--header sapUiResponsivePadding--footer sapUiResponsivePadding--subHeader")
                this._view.setBusy(false)
                dialog.open();
            } catch(e) {
                console.log(e);
            }
        }
    };
});
