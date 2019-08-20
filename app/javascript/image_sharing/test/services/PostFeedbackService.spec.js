import nock from 'nock';
import { expect } from 'chai';
import { describe, it } from 'mocha';
import PostFeedbackService from '../../services/PostFeedbackService';

describe('PostFeedbackService', () => {
  it('should make a post request', () => {
    const postFeedbackService = new PostFeedbackService();

    nock('http://example.appfolio.com')
      .post('/api/feedbacks', { feedbackName: 'Foo', feeedbackText: 'Bar' })
      .reply(200, { received: true });

    const mockWindow = { location: { origin: 'http://example.appfolio.com' } };
    return postFeedbackService
      .postFeedback({ feedbackName: 'Foo', feeedbackText: 'Bar' }, mockWindow)
      .then((res) => {
        expect(res.received).to.equal(true);
      });
  });
});
