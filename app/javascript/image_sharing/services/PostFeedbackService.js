import { post } from '../utils/helper';

export default class PostFeedbackService {
  postFeedback(data, wnd = window) {
    const origin = wnd.location.origin;
    return post(`${origin}/api/feedbacks`, data);
  }
}
