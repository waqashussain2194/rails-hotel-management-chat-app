import React, { Component } from 'react';

export default class UsersStaffConsolesIndexTab extends Component {
  constructor(props) {
    super(props);
  }

  renderGuest(g, i) {
    const img_url = `https://dummyimage.com/100x100/cdcdcd/ffffff.png&text=${ g.initials }`;
    const link = `/staff/guests/${ g.id }`;
    return (
      <div className="guest col-sm-2 text-center" key={ i } title={ g.profile.name }>
        <a href={ link }>
          <img src={ img_url } className="img-fluid rounded-circle" />
        </a>
        <p><b>{ g.profile.name }</b></p>
      </div>
    );
  }

  render() {
    return (
      <div className={`tab-pane ${ this.props.className }`}>
        <div className="container pt-5">
          <div className="row">
            { this.props.guests.map((g, i) => this.renderGuest(g, i)) }
          </div>
        </div>
      </div>
    );
  }
}
