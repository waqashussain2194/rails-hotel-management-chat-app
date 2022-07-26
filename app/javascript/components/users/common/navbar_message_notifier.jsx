import _ from 'lodash';
import moment from 'moment';
import React, { Component } from 'react';
import { Badge, Popover, PopoverHeader, PopoverBody } from 'reactstrap';

const CHANNEL = 'RT:MESSAGE_RECEIVED';
const STATE_KEY = 'navbar-message-notifier-state';
const INITIAL_STATE = { messages: {}, counts: {} };

export default class UsersNavbarMessageNotifier extends Component {
  constructor(props) {
    super(props);
    this.state = INITIAL_STATE;
    this.handleMessageReceived = this.handleMessageReceived.bind(this);
  }

  componentDidMount() {
    const stored_state = JSON.parse(localStorage.getItem(STATE_KEY));
    this.setState(stored_state || INITIAL_STATE);
  }

  componentDidUpdate() {
    const messages = _.extend({}, this.state.messages);
    const counts = _.extend({}, this.state.counts);
    localStorage.setItem(STATE_KEY, JSON.stringify({ messages, counts }));
  }

  componentWillMount() {
    window.addEventListener(CHANNEL, this.handleMessageReceived);
  }

  componentWillUnmount() {
    window.removeEventListener(CHANNEL, this.handleMessageReceived);
  }

  handleMessageReceived(e) {
    const message = e.detail.message;
    const guest_id = message.guest.id;
    const messages = _.extend({}, this.state.messages, { [guest_id]: message });
    const counts = _.extend({}, this.state.counts, {
      [guest_id]: (this.state.counts[guest_id] || 0) + 1
    })

    this.setState({ messages, counts });
  }

  renderMessage(m, i) {
    const guest_id = m.guest.id;
    const user = m.user ? 'Hotel' : m.guest.profile.name;
    const time = moment(m.created_at).format('MMM DD, YYYY h:mmA');
    const onClick = () => {
      _.unset(this.state.messages, `[${guest_id}]`);
      _.unset(this.state.counts, `[${guest_id}]`);
      this.setState({ messages: this.state.messages, counts: this.state.counts });
      window.location = `/staff/guests/${ guest_id }`;
    };

    return (
      <li className="media" key={ i }>
        <a href="javascript:void(0);" className="media-body" onClick={ onClick }>
          <h5 className="mt-0">
            { user }
            <small className="time"> | { time }</small>
          </h5>
          { m.content }
        </a>
      </li>
    );
  }

  renderMessages(messages) {
    messages = _.chain(messages).values().orderBy('created_at', 'desc').value();
    return (
      <div className="messages-wrap">
        <ul className="list-unstyled">
          { messages.map((m, i) => this.renderMessage(m, i)) }
        </ul>
      </div>
    );
  }

  render() {
    const messages = this.state.messages;
    const count = _.chain(this.state.counts).values().sum().value();
    const onClick = () => { this.setState({ open: !this.state.open }) };
    const popover_props = {
      className: 'message-notifier-popover',
      placement: 'bottom-end',
      isOpen: this.state.open,
      target: 'messages-lnk',
      toggle: onClick
    };
    return (
       <div>
        <a className="nav-link" href="javascript:void(0);" id="messages-lnk" onClick={ onClick }>
          Messages <Badge color="warning">{ count }</Badge>
        </a>
        <Popover { ...popover_props }>
          <PopoverHeader>{ count } new message(s)</PopoverHeader>
          <PopoverBody>{ this.renderMessages(messages) }</PopoverBody>
        </Popover>
      </div>
    );
  }
}
