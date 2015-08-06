'use strict'

angular.module 'webappApp'
.config ($stateProvider) ->
  $stateProvider.state 'cms',
    url: '/cms'
    templateUrl: 'app/cms/cms.html'
    controller: 'CmsCtrl'
