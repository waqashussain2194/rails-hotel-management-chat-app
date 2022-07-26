import 'babel-polyfill';

import Adapter from 'enzyme-adapter-react-16';
import React from 'react';
import Enzyme from 'enzyme';
import jasmineEnzyme from 'jasmine-enzyme';

Enzyme.configure({ adapter: new Adapter() });
beforeEach(() => {
  jasmineEnzyme();
});

// function to require all modules for a given context
const requireAll = requireContext => {
  requireContext.keys().forEach(requireContext);
};

// require all js files except testHelper.js in the test folder
requireAll(require.context('./', true, /^((?!spec_helper).)*\.jsx?$/));

// require all js files except main.js in the src folder
requireAll(require.context('../components/', true, /^((?!main).)*\.jsx?$/));

// output to the browser's console when the tests run
console.info(`TESTS RAN AT ${new Date().toLocaleTimeString()}`);
