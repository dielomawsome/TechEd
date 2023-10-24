using IncidentsService from './risk-service';

annotate IncidentsService.Incidents with {
    title  @title: 'Title';
    prio   @title: 'Priority';
    descr  @title: 'Description';
    impact @title: 'Impact';
}

annotate IncidentsService.Mitigations with {
    ID            @(
        UI.Hidden,
        Common: {Text: description}
    );
    description   @title: 'Description';
    ownerEmployee @title: 'Owner';
    timeline      @title: 'Timeline';
    incidents     @title: 'Incidents';
}

annotate IncidentsService.Incidents with @(UI: {
    HeaderInfo            : {
        TypeName      : 'Incident',
        TypeNamePlural: 'Incidents',
        Title         : {
            $Type: 'UI.DataField',
            Value: title
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: descr
        },
        TypeImageUrl  : 'sap-icon://alert'
    },
    SelectionFields       : [prio],
    LineItem              : [
        {Value: title},
        {Value: descr},
        {
            Value : mitigations.description,
            Label: 'Mitigation Description'
        },
        {
            Value      : prio,
            Criticality: criticality
        },
        {
            Value      : impact,
            Criticality: criticality
        }
    ],
    Facets                : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Main',
            Target: '@UI.FieldGroup#Main'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Mitigation',
            Target: '@UI.FieldGroup#Mitigation'
        }
    ],
    FieldGroup #Main      : {Data: [
        {Value: prio, },
        {Value: impact, },
        {Value: descr, }
    ]},

    FieldGroup #Mitigation: {Data: [
        {Value: mitigations.ownerEmployee_ID},
        {Value: mitigations.description},
        {Value: mitigations.timeline}
    ]}

}, ) {

};
