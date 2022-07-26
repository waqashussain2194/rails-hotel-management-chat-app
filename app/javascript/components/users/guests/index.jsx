import axios from 'axios';
import React, { Component } from 'react';

import UsersGuestsIndexTab from './_tab.jsx';

export default class UsersGuestsIndex extends Component {
  constructor(props) {
    super(props);
    this.state = {
      current_tab: 'checked_in',
      checked_in: [],
      checked_out: []
    };
  }

  loadGuests(params, key) {
    axios
      .get('/api/v1/guests', { params })
      .then((resp) => {
        this.setState({ [key]: resp.data.guests });
      })
      .catch((err) => {
        console.log(err);
      });
  }

  componentDidMount() {
    this.loadGuests({ checked_in: true }, 'checked_in')
    this.loadGuests({ checked_out: true }, 'checked_out')
  }

  renderTab(guests, id) {
    const props = {
      guests: (guests || []),
      className: (id == this.state.current_tab ? 'active' : '')
    };

    return <UsersGuestsIndexTab { ...props } />;
  }

  renderTabLink(text, id) {
    const active = (id == this.state.current_tab ? 'active' : '');
    const onClick = () => { this.setState({ current_tab: id }) };

    return (
      <li className="nav-item">
        <a className={ `nav-link ${ active }` } href="javascript:void(0);" onClick={ onClick }>
          { text }
        </a>
      </li>
    );
  }

  render() {
    return (
      <div>
        <h3>Guests</h3>
        <ul className="nav nav-tabs">
          { this.renderTabLink('Checked in', 'checked_in') }
          { this.renderTabLink('Checked out', 'checked_out') }
        </ul>
        <div className="tab-content">
          { this.renderTab(this.state.checked_in, 'checked_in') }
          { this.renderTab(this.state.checked_out, 'checked_out') }
        </div>
      </div>
    );
  }
}
