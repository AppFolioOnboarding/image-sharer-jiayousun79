import React from 'react';
import { shallow } from 'enzyme';
import { expect } from 'chai';
import { describe, it } from 'mocha';
import App from '../../components/App';

describe('<App />', () => {
  const wrapper = shallow(<App stores={{}} />).dive();
  it('should display header and footer component', () => {
    const headerComponent = wrapper.find('Header');
    expect(headerComponent.props().title).to.equal('Tell us what you think');
    const footerComponent = wrapper.find('Footer');
    expect(footerComponent.props().text).to.equal('Copyright: Appfolio Inc. Onboarding');
  });
});

