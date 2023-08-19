import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="diary"
export default class extends Controller {
  static targets = []

  connect() {
    console.log("Connected");
  }

  async saveDiary(event) {
    console.log(event);
    const timeValidation = /^([01]?[0-9]|2[0-3]):[0-5][0-9]$/;
    const form = document.getElementById("newDiaryForm");
    // const form = this.diaryFormTarget;
    if (
      form.elements["desc_content[]"][0].value === "" ||
      form.elements["desc_start_time[]"][0].value === "" ||
      form.elements["author"].value === "" ||
      form.elements["date"].value === ""
    ) {
      alert("빈 값이 있습니다.");
      console.log(1);
      return;
    }

    const descs = [];
    const start_times_entries = form.elements["desc_start_time[]"].entries();
    const end_times = form.elements["desc_end_time[]"]
    for (const [index, t] of start_times_entries) {
      if (t.value === "") {
        continue;
      }
      const vali_start = !timeValidation.test(t.value);
      const vali_end = !timeValidation.test(end_times[index].value);
      if (vali_start) {
        alert(t.value + " 시간이 형식에 맞지 않습니다.");
        console.log(vali_start);
        console.log(t.value);
        return;
      }
      if (end_times[index].value === "") {
        // if (form.elements["desc_start_time[]"][index + 1] !== "" || form.elements["desc_start_time[]"][index + 1] !== undefined) {
        //   end_times[index].value = form.elements["desc_start_time[]"][index + 1].value
        // }
      } else if (vali_end) {
        alert(end_times[index].value + " 시간이 형식에 맞지 않습니다.");
        console.log(vali_end);
        console.log(end_times[index].value);
        return;
      }

      descs.push({
        start_time: t.value,
        end_time: end_times[index].value,
        content: form.elements["desc_content[]"][index].value
      });
    }
    console.log(descs);

    let url = "";
    if (event.params.type === "create") {
      url = '/api/v1/diary/create3';
    } else if (event.params.type === "update") {
      console.log(event.params.diaryId);
      url = '/api/v1/diary/update3/' + event.params.diaryId.toString();
    }

    let response = await fetch(url, {
      method: 'post',
      headers: {
        'X-CSRF-Token': csrfToken(),
        'Content-type': "application/json"
      },
      body: JSON.stringify({
        date: form.elements["date"].value,
        author: form.elements["author"].value,
        desc: descs,
      })
    });
    let data = await response.json();
    if (data.code === "not_found_user") {
      alert("작성자를 찾을 수 없습니다.");
      return;
    }

    if (response.status >= 200 && response.status < 300) {
      alert('저장되었습니다.');
      let url = '/api/v1/diary/detail/' + data.diary_id.toString();
      window.location.replace(url);
      return;
    } else if (response.status == 500) {
      alert('서버에 문제가 발생했습니다.');
      return;
    }
  }
}
