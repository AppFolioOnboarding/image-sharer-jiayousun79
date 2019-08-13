import React from 'react';
import { shallow } from 'enzyme';
import { expect } from 'chai';
import { describe, it } from 'mocha';
import Footer from '../../components/Footer';

describe('<Footer />', () => {
  const wrapper = shallow(<Footer text="Copyright: Appfolio Inc. Onboarding" />);

  it('hould display text prop', () => {
    expect(wrapper.find('div.text-center').text()).to.equal('Copyright: Appfolio Inc. Onboarding');
  });

  it('should center Col component', () => {
    const colComponent = wrapper.find('Col');
    expect(colComponent.props().lg.size).to.equal(4);
    expect(colComponent.props().lg.offset).to.equal(4);
  });

  it('should display correct font size', () => {
    const footerComponent = wrapper.find('div.text-center');
    expect(footerComponent.props().style.fontSize).to.equal('10px');
  });
});
