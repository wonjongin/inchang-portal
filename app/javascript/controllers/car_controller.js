import {Controller} from "@hotwired/stimulus";

// Connects to data-controller="car"
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

  async saveCar(event) {
    console.log(event);
    const numberValidation = /^\d{2,3}[가나다라마거너더러머버서어저고노도로모보소오조구누두루무부수우주바사아자하허호배]\d{4}$/;
    const form = document.getElementById("newCarForm");
    console.log(form.elements);
    if (
      form.elements["date"].value === "" ||
      form.elements["number"].value === "" ||
      form.elements["manufacturer"].value === "" ||
      form.elements["model"].value === ""
    ) {
      alert("빈 값이 있습니다.");
      console.log(1);
      return;
    }
    if (!numberValidation.test(form.elements["number"].value)) {
      alert("자동차번호를 형식에 맞게 입력해주십시오. (띄어쓰기 없이 작성)");
    }

    let url = "";
    if (event.params.type === "create") {
      url = "/api/v1/car/create_car";
    } else if (event.params.type === "update") {
      url = "/api/v1/car/update_car/" + event.params.carId.toString();
    }

    let response = await fetch(url, {
      method: "post",
      headers: {
        "X-CSRF-Token": this.csrfToken(),
        "Content-type": "application/json",
      },
      body: JSON.stringify({
        date: form.elements["date"].value,
        number: form.elements["number"].value,
        manufacturer: form.elements["manufacturer"].value,
        model: form.elements["model"].value,
      }),
    });

    if (response.status >= 200 && response.status < 300) {
      alert("저장되었습니다.");
      let url = "/api/v1/car/car_list";
      window.location.replace(url);

    } else if (response.status == 500) {
      alert("서버에 문제가 발생했습니다.");

    }
  }

  async saveCarRepair(event) {
    console.log(event);
    const form = document.getElementById("newCarRepairForm");
    console.log(form.elements);
    if (
      form.elements["repaired_at"].value === "" ||
      form.elements["odo"].value === "" ||
      form.elements["center"].value === "" ||
      form.elements["price"].value === "" ||
      form.elements["desc"].value === ""
    ) {
      alert("빈 값이 있습니다.");
      console.log(1);
      return;
    }

    let url = "";
    if (event.params.type === "create") {
      url = "/api/v1/car/create_repair/" + event.params.carId.toString();
    } else if (event.params.type === "update") {
      url = "/api/v1/car/update_repair/" + event.params.repairId.toString();
    }

    let response = await fetch(url, {
      method: "post",
      headers: {
        "X-CSRF-Token": this.csrfToken(),
        "Content-type": "application/json",
      },
      body: JSON.stringify({
        repaired_at: form.elements["repaired_at"].value,
        odo: form.elements["odo"].value,
        center: form.elements["center"].value,
        desc: form.elements["desc"].value,
        price: form.elements["price"].value,
        footnote: form.elements["footnote"].value,
      }),
    });

    if (response.status >= 200 && response.status < 300) {
      alert("저장되었습니다.");
      let url = "/api/v1/car/repair_list/" + event.params.carId.toString();
      window.location.replace(url);
      return;
    } else if (response.status == 500) {
      alert("서버에 문제가 발생했습니다.");
      return;
    }
  }
}