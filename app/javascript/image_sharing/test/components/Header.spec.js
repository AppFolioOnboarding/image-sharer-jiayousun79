import React from 'react';
import { shallow } from 'enzyme';
import { expect } from 'chai';
import { describe, it } from 'mocha';
import Header from '../../components/Header';

describe('<Header />', () => {
  const wrapper = shallow(<Header title="Tell us what you think" />);

  it('should have title', () => {
    expect(wrapper.find('h3.text-center').text()).to.equal('Tell us what you think');
  });

  it('should be centered, the col grid', () => {
    const colComponent = wrapper.find('Col');
    expect(colComponent.props().lg.size).to.equal(4);
    expect(colComponent.props().lg.offset).to.equal(4);
  });
});
