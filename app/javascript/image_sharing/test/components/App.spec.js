import React from 'react';
import { shallow } from 'enzyme';
import { expect } from 'chai';
import { describe, it } from 'mocha';
import App from '../../components/App';
import FeedbackForm from '../../components/FeedbackForm';

describe('<App />', () => {
  const feedbackStore = { feedback_name: 'Someone', feedback_text: 'something' };
  const wrapper = shallow(<App stores={{ feedbackStore }} />).dive();
  it('should display header, footer and feedback form components', () => {
    const headerComponent = wrapper.find('Header');
    expect(headerComponent.props().title).to.equal('Tell us what you think');
    const footerComponent = wrapper.find('Footer');
    expect(footerComponent.props().text).to.equal('Copyright: Appfolio Inc. Onboarding');
  });

  it('should render feedbackForm with correct store', () => {
    expect(wrapper.find(FeedbackForm).props().store).to.equal(feedbackStore);
  });
});
