import React from 'react';
import { mount } from 'enzyme';
import moxios from 'moxios';

import UsersGuestsIndex from '../../../../components/users/guests/index.jsx';

describe('UsersGuestsIndex', () => {
  let wrapper;
  beforeEach(() => {
    moxios.install();
    wrapper = mount(<UsersGuestsIndex />);
  });
  afterEach(() => { moxios.uninstall(); });

  it('should list checked-in guests in active pane', (done) => {
    moxios.stubRequest('/api/v1/guests?checked_in=true', {
      response: { guests: [{ id: 1, profile: { name: 'G1' }}] }
    });

    moxios.wait(() => {
      wrapper.update();
      const active_pane = wrapper.find('.tab-pane.active');
      expect(active_pane.find('.guest').text()).toEqual('G1');
      done();
    });
  });

  it('should list checked-out guests in inactive pane', (done) => {
    moxios.stubRequest('/api/v1/guests?checked_out=true', {
      response: { guests: [{ id: 2, profile: { name: 'G2' }}] }
    });

    moxios.wait(() => {
      wrapper.update();
      const inactive_pane = wrapper.find('.tab-pane').last();
      expect(inactive_pane.find('.guest').text()).toEqual('G2');
      done();
    });
  });
});
