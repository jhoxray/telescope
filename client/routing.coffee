Router.map ->
  @route 'home', path: '/', controller: MainPageController
  @route 'main', path: '/main/:module', controller: MainPageController
  @route 'logging', path: '/logging', -> Router.go '/main/jupiter'
  
Router.configure
  layout: "layout"
  notFoundTemplate: "notFound"
  loadingTemplate: "loading"


