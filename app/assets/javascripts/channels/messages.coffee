'use strict'

App.messages = App.cable.subscriptions.create('MessagesChannel', {
  received: (data) ->
    evt1 = new CustomEvent('RT:MESSAGE_RECEIVED', { detail: data })
    evt2 = new CustomEvent("RT:MESSAGE_RECEIVED:#{data.message.guest.id}", { detail: data })

    window.dispatchEvent(evt1)
    window.dispatchEvent(evt2)
})

App.notifications = App.cable.subscriptions.create('NotificationsChannel', {
  received: (data) ->
    evt1 = new CustomEvent("RT:NOTIFICATION_RECEIVED:#{data.guest_id}", { detail: data })

    window.dispatchEvent(evt1)
})
