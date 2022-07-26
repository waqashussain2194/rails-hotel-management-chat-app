import axios from 'axios';
import moment from 'moment';
import React, { Component } from 'react';

export default class UsersGuestsShowNotifications extends Component {
  constructor(props) {

    super(props);
  }

  deleteNotification(m)
  {
    axios
      .delete('/api/v1/notifications/'+m.id)
      .then((resp) => {
        this.props.onSuccess(m);
      })
      .catch((resp) => {
        console.log(resp);
      });
  }

  renderNotification(m, i) {
    const time = moment(m.created_at).format('MMM DD, YYYY h:mmA');
    return (

        <div className="alert alert-danger " key={i}>
          <span><small className="time"> | { time }</small></span> <br />
          <a href="JavaScript:Void(0);" onClick={ () => this.deleteNotification(m)} className="close" aria-label="close">×</a>
          <strong>Alert! </strong> { m.content }
        </div>
    );
  }

  renderNotifications(notifications) {
    return (
      <div className="messages-wrap">
        <ul className="list-unstyled">
          { notifications.map((m, i) => this.renderNotification(m, i)) }
        </ul>
      </div>
    );
  }

  render() {
    const notifications = this.props.notifications;
    if(notifications.length) {
      return this.renderNotifications(notifications);

    } else {
      return (
        <div>
        </div>
      );
    }
  }
}
