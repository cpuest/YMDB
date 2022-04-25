@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Data Projection Country'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity YMDB_C_COUNTRY as projection on YMDB_I_COUNTRY {

    @UI.facet: [{
            id: 'idGeneralInfo',
            type: #COLLECTION,
            label: 'Country',
            position: 10 
        }, { 
            id: 'idCountryData',
            parentId: 'idGeneralInfo',
            type: #IDENTIFICATION_REFERENCE,
            label: 'Country Data',
            position: 10
        }]

    @ObjectModel.text.element: ['CountryName']
    @UI.lineItem: [{ position: 0 }]
    @UI.textArrangement: #TEXT_ONLY
    @EndUserText.label: 'Country name'
    key CountryId,
    @UI.identification: [{ position: 10 }]
    @EndUserText.label: 'Country name'
    _Country_t.CountryName as CountryName : localized,
    @UI.lineItem: [{ position: 10 }]
    @EndUserText.label: 'Fallback Language'
    _Country_t[ 1:LanguageCode = 'E' ].CountryName as FallBackLang,
    
    _Country_t
}
