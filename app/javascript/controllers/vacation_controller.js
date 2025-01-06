import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="vacation"
export default class extends Controller {
  connect() {
  }

  csrfToken() {
    const meta = document.querySelector("meta[name=csrf-token]");
    const token = meta && meta.getAttribute("content");

    return token ?? false;
  }

  saveVacation(event) {

    const form = document.getElementById("newVacationForm");

    if (
      form.elements["start_date"].value === "" ||
      form.elements["end_date"].value === "" ||
      form.elements["reason"].value === "" ||
      form.elements["vacation_type"].value === ""
    ) {
      alert("빈 값이 있습니다.");
      return;
    }

    if (form.elements["start_date"].value > form.elements["end_date"].value) {
      alert("종료일이 시작일보다 빠를 수 없습니다.");
      return;
    }

    let url = "";
    if (event.params.type === "update") {
      url = "/api/v1/vacations/update/" + event.params.vacationId.toString();
    } else if (event.params.type === "create") {
      url = "/api/v1/vacations/create";
    }

    fetch(url, {
      method: "post",
      headers: {
        "X-CSRF-Token": this.csrfToken(),
        "Content-type": "application/json",
      },
      body: JSON.stringify({
        start_date: form.elements["start_date"].value,
        end_date: form.elements["end_date"].value,
        reason: form.elements["reason"].value,
        vacation_type: form.elements["vacation_type"].value
      }),
    })
      .then((response) => {
        if (response.status >= 200 && response.status < 300) {
          alert("저장되었습니다.");
          let url = "/api/v1/vacations/";
          window.location.replace(url);
        } else if (response.status == 500) {
          alert("서버에 문제가 발생했습니다.");
        }
      })
  }
}
