using IncidentsService as service from '../../srv/risk-service';
using from '../../srv/incidents-service-ui';



annotate service.Incidents with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Main',
            Target : '@UI.FieldGroup#Main',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Mitigations',
            ID : 'Mitigations',
            Target : 'mitigations/@UI.LineItem#Mitigations',
        },
    ]
);
annotate service.Incidents with @(
    UI.FieldGroup #Mitigation1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : mitigations.description,
            },{
                $Type : 'UI.DataField',
                Value : mitigations.timeline,
            },],
    }
);
annotate service.Mitigations with @(
    UI.LineItem #Mitigations : [
        {
            $Type : 'UI.DataField',
            Value : description,
        },{
            $Type : 'UI.DataField',
            Value : timeline,
        },]
);
