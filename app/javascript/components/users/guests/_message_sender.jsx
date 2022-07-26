import axios from 'axios';
import moment from 'moment';
import React, { Component } from 'react';

export default class UsersGuestsShowMessageSender extends Component {
  constructor(props) {
    super(props);
    this.state = { message: '', loading: false };
  }

  resetForm() {
    this.setState({ message: '', loading: false });
  }

  handleSubmit(e) {
    e.preventDefault();
    this.setState({ loading: true });
    const body = { content: this.state.message, guest_id: this.props.guest_id };
    axios
      .post('/api/v1/messages', body)
      .then((resp) => {
        this.props.onSuccess(resp.data);
        this.resetForm();
      })
      .catch((resp) => {
        console.log(resp);
        this.setState({ loading: false });
      });
  }

  render() {
    const txt_area_props = {
      disabled: this.state.loading,
      className: 'form-control',
      onChange: (e) => this.setState({ message: e.target.value }),
      required: true,
      value: this.state.message,
    };
    return (
      <div>
        <form onSubmit={ this.handleSubmit.bind(this) }>
          <div className="form-group">
            <textarea { ...txt_area_props } ></textarea>
          </div>
          <div className="form-group">
            <button className="btn btn-primary btn-sm" disabled={ this.state.loading }>
              Send
            </button>
          </div>
        </form>
      </div>
    );
  }
}
