Router.map ->
  @route 'home', path: '/', controller: MainPageController
  @route 'main', path: '/main/:module', controller: MainPageController
  
Router.configure
  layout: "layout"
  notFoundTemplate: "notFound"
  loadingTemplate: "loading"


