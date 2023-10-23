sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/incidents/test/integration/FirstJourney',
		'ns/incidents/test/integration/pages/IncidentsList',
		'ns/incidents/test/integration/pages/IncidentsObjectPage',
		'ns/incidents/test/integration/pages/MitigationsObjectPage'
    ],
    function(JourneyRunner, opaJourney, IncidentsList, IncidentsObjectPage, MitigationsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/incidents') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheIncidentsList: IncidentsList,
					onTheIncidentsObjectPage: IncidentsObjectPage,
					onTheMitigationsObjectPage: MitigationsObjectPage
                }
            },
            opaJourney.run
        );
    }
);