import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user"
export default class extends Controller {
  connect() {
  }


  csrfToken() {
    const meta = document.querySelector("meta[name=csrf-token]");
    const token = meta && meta.getAttribute("content");

    return token ?? false;
  }


  async saveUser(event) {
    console.log(event);
    const form = document.getElementById("newUserForm");
    console.log(form.elements);
    if (
      form.elements["name"].value === "" ||
      form.elements["hire_date"].value === "" ||
      form.elements["position"].value === "" ||
      form.elements["status"].value === ""
    ) {
      alert("빈 값이 있습니다.");
      console.log(1);
      return;
    }

    let url = "";
    if (event.params.type === "update") {
      url = "/api/v1/user/update/" + event.params.userId.toString();
    }

    let response = await fetch(url, {
      method: "post",
      headers: {
        "X-CSRF-Token": this.csrfToken(),
        "Content-type": "application/json",
      },
      body: JSON.stringify({
        name: form.elements["name"].value,
        hire_date: form.elements["hire_date"].value,
        position: form.elements["position"].value,
        status: form.elements["status"].value,
      }),
    });

    if (response.status >= 200 && response.status < 300) {
      alert("저장되었습니다.");
      let url = "/api/v1/user/list";
      window.location.replace(url);
      return;
    } else if (response.status == 500) {
      alert("서버에 문제가 발생했습니다.");
      return;
    }
  }

}
