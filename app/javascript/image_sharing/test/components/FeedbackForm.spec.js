import React from 'react';
import { shallow } from 'enzyme';
import { expect } from 'chai';
import { describe, it } from 'mocha';
import sinon from 'sinon';
import FeedbackForm from '../../components/FeedbackForm';
import FeedbackStore from '../../stores/FeedbackStore';

describe('<FeedbackForm />', () => {
  const tempStore = new FeedbackStore();
  const wrapper = shallow(<FeedbackForm store={tempStore} />).dive();

  it('should display the form correctly', () => {
    expect(wrapper.find('Label').at(0).dive().text()).to.equal('Your name:');
    expect(wrapper.find('Label').at(1).dive().text()).to.equal('Comments');
    expect(wrapper.find('Input').length).to.equal(2);
    expect(wrapper.find('Button').dive().text()).to.equal('Submit');
  });

  it('should call feedbackStore.setName', () => {
    const setNameSpy = sinon.spy(tempStore, 'setName');
    const namechange = { target: { value: 'my name' } };
    wrapper.find('Input').at(0).props().onChange(namechange);
    sinon.assert.calledWith(setNameSpy, 'my name');
  });

  it('should call feedbackStore.setText', () => {
    const setTextSpy = sinon.spy(tempStore, 'setText');
    const textchange = { target: { value: 'something' } };
    wrapper.find('Input').at(1).props().onChange(textchange);
    sinon.assert.calledWith(setTextSpy, 'something');
  });

  it('shows feedbackName value from feedbackStore', () => {
    tempStore.feedbackName = 'John';
    const localWrapper = shallow(<FeedbackForm store={tempStore} />).dive();
    expect(localWrapper.find('Input').at(0).dive().props().value).to.equal('John');
  });

  it('shows feedbackText value from feedbackStore', () => {
    tempStore.feedbackText = 'Something';
    const localWrapper = shallow(<FeedbackForm store={tempStore} />).dive();
    expect(localWrapper.find('Input').at(1).dive().props().value).to.equal('Something');
  });
});
