import '@hotwired/turbo-rails'
import { Application } from '@hotwired/stimulus'

let application

if (typeof window.Stimulus === "undefined") {
  application = Application.start()
  application.debug = false
  window.Stimulus = application
} else {
  application = window.Stimulus
}

import SpreePostsController from 'spree_posts/controllers/spree_posts_controller' 

application.register('spree_posts', SpreePostsController)