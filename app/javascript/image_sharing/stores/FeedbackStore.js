import { observable, action } from 'mobx';

export default class FeedbackStore {
  @observable feedbackName = '';
  @observable feedbackText = '';

  @action
  setName(name) {
    this.feedbackName = name;
  }

  @action
  setText(text) {
    this.feedbackText = text;
  }
}
