import _ from 'lodash';
import axios from 'axios';
import React, { Component } from 'react';

import UsersGuestsShowMessages from './_messages.jsx';
import UsersGuestsShowNotifications from './_notifications.jsx';
import UsersGuestsShowMessageSender from './_message_sender.jsx';


export default class UsersGuestsShow extends Component {
  constructor(props) {
    super(props);
    this.state = { messages: [], notifications: []};
    this.onMessageReceived = this.onMessageReceived.bind(this);
    this.onNotificationReceived = this.onNotificationReceived.bind(this);
  }

  componentDidMount() {
    this.loadMessages();
    this.loadNotifications();
  }

  getChannel() {
    return `RT:MESSAGE_RECEIVED:${this.props.guest_id}`;
  }
  getNotificationChannel() {
    return `RT:NOTIFICATION_RECEIVED:${this.props.guest_id}`;
  }

  componentWillMount() {
    window.addEventListener(this.getChannel(), this.onMessageReceived);
    window.addEventListener(this.getNotificationChannel(), this.onNotificationReceived);
  }

  componentWillUnmount() {
    window.removeEventListener(this.getChannel(), this.onMessageReceived);
    window.removeEventListener(this.getNotificationChannel(), this.onNotificationReceived);
  }

  onMessageReceived(e) {
    const messages = _.union([e.detail.message], this.state.messages);
    this.setState({ messages });
  }

  onNotificationReceived(e) {
    const notifications = _.union([e.detail], this.state.notifications);
    this.setState({ notifications });
  }

  loadMessages() {
    const params = { guest_id: this.props.guest_id };
    axios
      .get('/api/v1/messages', { params })
      .then((resp) => {
        this.setState({ messages: resp.data.messages });
      })
      .catch((err) => {
        console.log(err);
      });
  }
  loadNotifications() {
    const params = { guest_id: this.props.guest_id };
    axios
      .get('/api/v1/notifications', { params })
      .then((resp) => {
        this.setState({ notifications: resp.data });
      })
      .catch((err) => {
        console.log(err);
      });
  }

  renderMessages() {
    const props = { messages: this.state.messages };
    return <UsersGuestsShowMessages { ...props } />;
  }

  renderNotifications() {
    const props = { notifications: this.state.notifications,
    onSuccess: (data) => {
        const notifications = _.filter(this.state.notifications, function(notif) { return notif.id != data.id; });
        this.setState({ notifications });
      }
    };
    return <UsersGuestsShowNotifications { ...props } />;
  }

  renderMessageSender() {
    const props = {
      guest_id: this.props.guest_id,
      onSuccess: (data) => {
        const messages = _.union([data.message], this.state.messages);
        this.setState({ messages });
      }
    };
    return <UsersGuestsShowMessageSender { ...props }/>;
  }

  render() {
    return (
      <div>
        <h3>Conversation</h3>
        { this.renderMessageSender() }
        { this.renderNotifications() }
        { this.renderMessages() }
      </div>
    );
  }
}
