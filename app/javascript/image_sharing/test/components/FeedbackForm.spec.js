import React from 'react';
import { shallow } from 'enzyme';
import { expect } from 'chai';
import { describe, it, beforeEach, afterEach } from 'mocha';
import sinon from 'sinon';
import FeedbackForm from '../../components/FeedbackForm';
import FeedbackStore from '../../stores/FeedbackStore';
import PostFeedbackService from '../../services/PostFeedbackService';

describe('<FeedbackForm />', () => {
  const tempStore = new FeedbackStore();
  const wrapper = shallow(<FeedbackForm store={tempStore} />).dive();

  let sandbox;

  beforeEach(() => {
    sandbox = sinon.createSandbox();
  });

  afterEach(() => {
    sandbox.restore();
  });

  it('should display the form correctly', () => {
    expect(wrapper.find('Label').at(0).dive().text()).to.equal('Your name:');
    expect(wrapper.find('Label').at(1).dive().text()).to.equal('Comments');
    expect(wrapper.find('Input').length).to.equal(2);
    expect(wrapper.find('Button').dive().text()).to.equal('Submit');
  });

  it('should call feedbackStore.setName', () => {
    const setNameSpy = sandbox.spy(tempStore, 'setName');
    const namechange = { target: { value: 'my name' } };
    wrapper.find('Input').at(0).props().onChange(namechange);
    sandbox.assert.calledWith(setNameSpy, 'my name');
  });

  it('should call feedbackStore.setText', () => {
    const setTextSpy = sandbox.spy(tempStore, 'setText');
    const textchange = { target: { value: 'something' } };
    wrapper.find('Input').at(1).props().onChange(textchange);
    sandbox.assert.calledWith(setTextSpy, 'something');
  });

  it('should call submitFeedback when submit button is clicked', () => {
    const tempStoreSubmitFeedback = new FeedbackStore();
    tempStoreSubmitFeedback.feedbackName = 'Foo';
    tempStoreSubmitFeedback.feedbackText = 'Bar';
    const localWrapper = shallow(<FeedbackForm store={tempStoreSubmitFeedback} />);
    const fakeData = { feedbackName: tempStoreSubmitFeedback.feedbackName, feedbackText: tempStoreSubmitFeedback.feedbackText };
    const submitFeedbackStub = sandbox.stub(FeedbackForm.prototype, 'submitFeedback');
    localWrapper.find('Button').simulate('click');
    sandbox.assert.calledWith(submitFeedbackStub, fakeData);
  });


  it('should call postFeedback when submitFeedback is called', () => {
    const localWrapper = shallow(<FeedbackForm store={tempStore} />);
    const postFeedbackStub = sandbox.stub(PostFeedbackService.prototype, 'postFeedback');

    localWrapper.instance().submitFeedback({ fake: 'data' });

    sandbox.assert.calledWith(postFeedbackStub, { fake: 'data' });
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
