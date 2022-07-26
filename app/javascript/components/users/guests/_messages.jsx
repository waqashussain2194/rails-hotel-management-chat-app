import moment from 'moment';
import React, { Component } from 'react';

export default class UsersGuestsShowMessages extends Component {
  constructor(props) {
    super(props);
  }

  renderMessage(m, i) {
    const user = m.user ? 'Hotel' : ( m.is_agent ? " Dialogflow Agent" : m.guest.profile.name) ;
    const img = `https://dummyimage.com/60x60/cdcdcd/ffffff.png&text=${ user }`;
    const time = moment(m.created_at).format('MMM DD, YYYY h:mmA');
    return (
      <li className="media message" key={ i }>
        <img className="mr-3 rounded-circle" src={ img } alt={ user } />
        <div className="media-body">
          <h5 className="mt-0">
            { user }
            <small className="time"> | { time }</small>
          </h5>
          <p>{ m.content }</p>
        </div>
      </li>
    );
  }

  renderMessages(messages) {
    return (
      <div className="messages-wrap">
        <ul className="list-unstyled">
          { messages.map((m, i) => this.renderMessage(m, i)) }
        </ul>
      </div>
    );
  }

  render() {
    const messages = this.props.messages;

    if(messages.length) {
      return this.renderMessages(messages);

    } else {
      return (
        <div>
          <p><i>No messages</i></p>
        </div>
      );
    }
  }
}
