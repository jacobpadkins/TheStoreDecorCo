'use strict'

describe 'Controller: CmsCtrl', ->

  # load the controller's module
  beforeEach module 'cmsApp'
  CmsCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    CmsCtrl = $controller 'CmsCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
