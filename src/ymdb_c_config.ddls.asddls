@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection view of config'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity YMDB_C_CONFIG as projection on YMDB_I_CONFIG as Config {
  
  @UI.lineItem: [{ position: 0 }, { type: #FOR_ACTION, dataAction: 'signup', label: 'Sign Up', position: 0 }, 
//                                   { type: #FOR_ACTION, dataAction: 'signin', label: 'Change User', position: 10 },
//                                   { type: #FOR_ACTION, dataAction: 'signout', label: 'Sign Out', position: 20 },
                                   { type: #FOR_ACTION, dataAction: 'delete_user', label: 'Delete User', position: 30 }]
    key Uname_ABAP,
    @UI.lineItem: [{ position: 10 }]
    key UserName,
    ApiKey
}
