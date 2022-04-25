@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Data Definition Config'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity YMDB_I_CONFIG as select from ymdb_config as Config {
    key uname_abap as Uname_ABAP,
    key user_name as UserName,
    api_key as ApiKey
}
