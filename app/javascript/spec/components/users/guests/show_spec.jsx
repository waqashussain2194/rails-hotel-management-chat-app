import React from 'react';
import { mount } from 'enzyme';
import moxios from 'moxios';

import UsersGuestsShow from '../../../../components/users/guests/show.jsx';

describe('UsersGuestsShow', () => {
  let wrapper;
  const guest_id = 1;

  beforeEach(() => {
    moxios.install();
    wrapper = mount(<UsersGuestsShow guest_id={ guest_id } />);
  });
  afterEach(() => { moxios.uninstall(); });

  it('should list messages for provided guest', (done) => {
    moxios.stubRequest(`/api/v1/messages?guest_id=${ guest_id }`, {
      response: {
        messages: [
          { id: 1, content: 'A dummy content', guest: { profile: { name: 'G1' } } }
        ]
      }
    });
    moxios.wait(() => {
      wrapper.update();
      const message = wrapper.find('.message');
      expect(message.find('p').text()).toEqual('A dummy content');
      done();
    });
  });

  it('shows no messages text when there are no messages', (done) => {
    moxios.stubRequest(`/api/v1/messages?guest_id=${ guest_id }`, {
      response: { messages: [] }
    });
    moxios.wait(() => {
      wrapper.update();
      expect(wrapper.find('p').text()).toEqual('No messages');
      done();
    });
  });
});
