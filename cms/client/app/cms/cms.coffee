'use strict'

angular.module 'cmsApp'
.config ($stateProvider) ->
  $stateProvider.state 'cms',
    url: '/cms'
    templateUrl: 'app/cms/cms.html'
    controller: 'CmsCtrl'
