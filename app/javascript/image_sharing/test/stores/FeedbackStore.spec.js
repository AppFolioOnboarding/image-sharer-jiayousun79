import { expect } from 'chai';
import { describe, it } from 'mocha';
import FeedbackStore from '../../stores/FeedbackStore';

describe('FeedbackStore', () => {
  const feedbackStore = new FeedbackStore();

  it('should set name', () => {
    feedbackStore.setName('my name');
    expect(feedbackStore.feedbackName).to.equal('my name');
  });

  it('should set text', () => {
    feedbackStore.setText('something');
    expect(feedbackStore.feedbackText).to.equal('something');
  });
});
