'use strict'

describe 'Controller: MainCtrl', ->

  # load the controller's module
  beforeEach module 'cmsApp'
  MainCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    MainCtrl = $controller 'MainCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
