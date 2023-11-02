using IncidentsService as service from '../../srv/risk-service';

// These annotations add a few titles to the fields in the Incidents service
// Titles are displayed in the UI as labels for the fields or headers for the columns
annotate IncidentsService.Incidents with {
    title  @title: 'Title';
    prio   @title: 'Priority';
    descr  @title: 'Description';
    impact @title: 'Impact';
}

//These annotations add a few titles to the fields in the Mitigations service
annotate IncidentsService.Mitigations with {
    description   @title: 'Description';
    timeline      @title: 'Timeline';
}

//See the annotation starting with @(UI: { below? That indications we're adding UI annotations. 
//In this case, the annotations specifcy the UI elements that should be displayed for the Incidents service.
//More specifically, we're adding a header, a selection field, a line item, and a facet.
//The facet is displayed in the body of the object page and are referenced by the ID 'Mitigations' and 'Main' respectively.
annotate IncidentsService.Incidents with @(UI: {
    //HeaderInfo defines the header of the object page
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
    //SelectionFields define the fields in the filter bar
    SelectionFields        : [prio],
    //LineItem defines the columns in the table in the List Report
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
    //Facets define the sections in the object page
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
    //QuickViewFacets define the sections in the quick view
    FieldGroup #Main       : {Data: [
        {Value: prio, },
        {Value: impact, },
        {Value: descr, },
        {Value: type_code }
    ]},

    //QuickViewFacets define the sections in the quick view
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
    //These are FIELD annotations, like the @title's above. In this case, we specify that type should be a selection field with 
    // a dropdown list of values. The values are defined in the ValueList annotation below.
    type @title: 'Type' 
    @(Common : {
        Text            : type.name,
        TextArrangement : #TextOnly,
        ValueListWithFixedValues: true,
        ValueList       : {
            Label          : '{i18n>Type}',
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
};

//More Line item annotations. These are for the Mitigations service. This specifies the columns in the table for Mitigations
//inside of the the Object page
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


//These annotations add a few titles to the fields in the Type service. 
annotate IncidentsService.Type with {
    code @title: 'Type'
      @(Common : {
        Text            : name,
        TextArrangement : #TextOnly
    });
    name @title: 'Name';
}