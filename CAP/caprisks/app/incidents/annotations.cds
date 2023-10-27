using IncidentsService as service from '../../srv/risk-service';

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
    timeline      @title: 'Timeline';
}

annotate IncidentsService.Incidents with @(UI: {
    HeaderInfo             : {
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
    SelectionFields        : [prio],
    LineItem               : [
        {Value: title},
        {Value: descr},
        {
            Value: mitigations.description,
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
    Facets                 : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Main',
            Target: '@UI.FieldGroup#Main',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Mitigations',
            ID    : 'Mitigations',
            Target: 'mitigations/@UI.LineItem#Mitigations',
        },
    ],
    FieldGroup #Main       : {Data: [
        {Value: prio, },
        {Value: impact, },
        {Value: descr, },
        {Value: type_code }
    ]},


    FieldGroup #Mitigation1: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: mitigations.description,
            },
            {
                $Type: 'UI.DataField',
                Value: mitigations.timeline,
            },
        ],
    }

}, ) {
    type @title: 'Type' 
    @(Common : {
        Text            : type.name,
        TextArrangement : #TextOnly,
        ValueListWithFixedValues: true,
        ValueList       : {
            Label          : '{i18n>criticality}',
            CollectionPath : 'Type',
            Parameters     : [
                {
                    $Type               : 'Common.ValueListParameterInOut',
                    ValueListProperty   : 'code',
                    LocalDataProperty   : type_code
                }
                
            ]
        }
    });
    type_code @title: 'Type' 
      @(Common : {
        Text            : type.name,
        TextArrangement : #TextOnly,
        ValueListWithFixedValues: true,
    });
};

annotate IncidentsService.Mitigations with @(UI.LineItem #Mitigations: [
    {
        $Type: 'UI.DataField',
        Value: description,
    },
    {
        $Type: 'UI.DataField',
        Value: timeline,
    },
]);

annotate IncidentsService.Type with {
    code @title: 'Type'
      @(Common : {
        Text            : name,
        TextArrangement : #TextOnly
    });
    name @title: 'Name';
}