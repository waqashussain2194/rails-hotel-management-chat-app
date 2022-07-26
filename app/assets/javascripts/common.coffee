'use strict'

$(document).on 'turbolinks:before-cache', ->
  WebpackerReact.unmountComponents()
