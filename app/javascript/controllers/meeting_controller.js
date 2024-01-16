import {Controller} from "@hotwired/stimulus"
import DiaryController from "./diary_controller"

// Connects to data-controller="meeting"
export default class extends Controller {
  connect() {
    this.enterToTab();
    console.log("connected");
  }

  csrfToken() {
    const meta = document.querySelector("meta[name=csrf-token]");
    const token = meta && meta.getAttribute("content");

    return token ?? false;
  }

  enterToTab() {
    document.addEventListener("keypress", function (event) {
      if (event.keyCode === 13 && event.target.nodeName === "INPUT") {
        event.preventDefault();
        var form = event.target.form;
        var index = Array.prototype.indexOf.call(form, event.target);
        console.log(index);
        if (form.elements[index + 1] === undefined) {
          alert("다음 입력란이 없습니다.");
          return;
        }
        form.elements[index + 1].focus();
      }
    });
  }

  async saveMeeting(event) {
    console.log(event);
    const form = document.getElementById("newMeetingForm");
    console.log(form.elements);
    if (
      form.elements["at"].value === "" ||
      form.elements["user"].value === "" ||
      form.elements["title"].value === "" ||
      form.elements["is_exterior"].value === "" ||
      form.elements["attendee"].value === "" ||
      form.elements["description"].value === ""
    ) {
      alert("빈 값이 있습니다.");
      console.log(1);
      return;
    }
    let url = "";
    if (event.params.type === "create") {
      url = '/api/v1/meeting/create';
    } else if (event.params.type === "update") {
      url = '/api/v1/meeting/update/' + event.params.meetingId.toString();
    }

    let response = await fetch(url, {
      method: 'post',
      headers: {
        'X-CSRF-Token': this.csrfToken(),
        'Content-type': "application/json"
      },
      body: JSON.stringify({
        at: form.elements["at"].value,
        user: form.elements["user"].value,
        title: form.elements["title"].value,
        is_exterior: form.elements["is_exterior"].value,
        attendee: form.elements["attendee"].value,
        description: form.elements["description"].value,
        footnote: form.elements["footnote"].value,
      })
    });
    let data = await response.json();
    if (data.code === "not_found_user") {
      alert("작성자를 찾을 수 없습니다.");
      return;
    }

    if (response.status >= 200 && response.status < 300) {
      alert('저장되었습니다.');
      let url = '/api/v1/meeting/list';
      window.location.replace(url);
      return;
    } else if (response.status == 500) {
      alert('서버에 문제가 발생했습니다.');
      return;
    }
  }

}
