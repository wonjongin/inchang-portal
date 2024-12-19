import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="car"
export default class extends Controller {
  connect() {
    this.enterToTab();
    this.autoComma();
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

  autoComma() {
    const inputs = document.getElementsByClassName("number-auto-comma");
    Array.from(inputs).forEach((input) => {
      input.addEventListener("keyup", function (e) {
        let value = e.target.value;
        value = +value.replaceAll(",", "");
        if (isNaN(value)) {
          input.value = 0;
        } else {
          input.value = value.toLocaleString("ko-KR");
        }
      });
    });
  }

  async saveCar(event) {
    console.log(event);
    const numberValidation =
      /^\d{2,3}[가나다라마거너더러머버서어저고노도로모보소오조구누두루무부수우주바사아자하허호배]\d{4}$/;
    const form = document.getElementById("newCarForm");
    console.log(form.elements);
    if (
      form.elements["date"].value === "" ||
      form.elements["number"].value === "" ||
      form.elements["manufacturer"].value === "" ||
      form.elements["model"].value === "" ||
      form.elements["insurance_company"].value === "" ||
      form.elements["insurance_start"].value === "" ||
      form.elements["insurance_end"].value === ""
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
        insurance_company: form.elements["insurance_company"].value,
        insurance_start: form.elements["insurance_start"].value,
        insurance_end: form.elements["insurance_end"].value,
        insurance_desc: form.elements["insurance_desc"].value,
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

  async sellCar(event) {
    console.log(event);
    const numberValidation =
      /^\d{2,3}[가나다라마거너더러머버서어저고노도로모보소오조구누두루무부수우주바사아자하허호배]\d{4}$/;
    const form = document.getElementById("newCarForm");
    console.log(form.elements);
    if (form.elements["date"].value === "") {
      alert("빈 값이 있습니다.");
      console.log(1);
      return;
    }
    if (!numberValidation.test(form.elements["number"].value)) {
      alert("자동차번호를 형식에 맞게 입력해주십시오. (띄어쓰기 없이 작성)");
    }

    let url = "";
    url = "/api/v1/car/dispose_car/" + event.params.carId.toString();

    let response = await fetch(url, {
      method: "post",
      headers: {
        "X-CSRF-Token": this.csrfToken(),
        "Content-type": "application/json",
      },
      body: JSON.stringify({
        disposed_at: form.elements["date"].value,
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
        odo: +form.elements["odo"].value.replaceAll(",", ""),
        center: form.elements["center"].value,
        desc: form.elements["desc"].value,
        price: +form.elements["price"].value.replaceAll(",", ""),
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

  async saveCarFuel(event) {
    console.log(event);
    const form = document.getElementById("newCarFuelForm");
    console.log(form.elements);
    if (
      form.elements["refueled_at"].value === "" ||
      form.elements["odo"].value === "" ||
      form.elements["station"].value === "" ||
      form.elements["price"].value === "" ||
      form.elements["unit_price"].value === "" ||
      form.elements["fuel_type"].value === ""
    ) {
      alert("빈 값이 있습니다.");
      console.log(1);
      return;
    }

    let url = "";
    if (event.params.type === "create") {
      url = "/api/v1/car/create_fuel/" + event.params.carId.toString();
    } else if (event.params.type === "update") {
      url = "/api/v1/car/update_fuel/" + event.params.fuelId.toString();
    }

    let response = await fetch(url, {
      method: "post",
      headers: {
        "X-CSRF-Token": this.csrfToken(),
        "Content-type": "application/json",
      },
      body: JSON.stringify({
        refueled_at: form.elements["refueled_at"].value,
        odo: +form.elements["odo"].value.replaceAll(",", ""),
        station: form.elements["station"].value,
        price: +form.elements["price"].value.replaceAll(",", ""),
        footnote: form.elements["footnote"].value,
        unit_price: +form.elements["unit_price"].value.replaceAll(",", ""),
        fuel_type: form.elements["fuel_type"].value,
      }),
    });

    if (response.status >= 200 && response.status < 300) {
      alert("저장되었습니다.");
      let url = "/api/v1/car/fuel_list/" + event.params.carId.toString();
      window.location.replace(url);
      return;
    } else if (response.status == 500) {
      alert("서버에 문제가 발생했습니다.");
      return;
    }
  }

  async saveCarLog(event) {
    console.log(event);
    const form = document.getElementById("newCarLogForm");
    console.log(form.elements);
    if (
      form.elements["at"].value === "" ||
      form.elements["number"].value === "" ||
      form.elements["user"].value === "" ||
      form.elements["depart"].value === "" ||
      form.elements["arrive"].value === "" ||
      form.elements["odo"].value === "" ||
      form.elements["purpose"].value === ""
    ) {
      alert("빈 값이 있습니다.");
      console.log(1);
      return;
    }

    let url = "";
    if (event.params.type === "create") {
      url = "/api/v1/car_log/create/" + event.params.carId.toString();
    } else if (event.params.type === "update") {
      url = "/api/v1/car_log/update/" + event.params.fuelId.toString();
    }

    let response = await fetch(url, {
      method: "post",
      headers: {
        "X-CSRF-Token": this.csrfToken(),
        "Content-type": "application/json",
      },
      body: JSON.stringify({
        at: form.elements["at"].value,
        number: form.elements["number"].value,
        user: form.elements["user"].value,
        depart: form.elements["depart"].value,
        arrive: form.elements["arrive"].value,
        odo: +form.elements["odo"].value.replaceAll(",", ""),
        purpose: form.elements["purpose"].value,
      }),
    });

    if (response.status >= 200 && response.status < 300) {
      alert("저장되었습니다.");
      let url = "/api/v1/car_log/list/" + event.params.carId.toString();
      window.location.replace(url);
      return;
    } else if (response.status == 500) {
      alert("서버에 문제가 발생했습니다.");
      return;
    }
  }

  async getXlsxLog(event) {
    console.log(event);
    const form = document.getElementById("getXlsxLogForm");
    console.log(form.elements);
    let start = form.elements["start"].value;
    let end = form.elements["end"].value;
    if (start === "" || end === "") {
      alert("빈 값이 있습니다.");
      console.log(1);
      return;
    }

    let url = `/api/v1/car_log/xlsx_log/${event.params.carId.toString()}/${start}/${end}`;
    window.location.replace(url);
  }

  async admit(event) {
    console.log(event.target.checked);

    let response = await fetch(
      "/api/v1/car/admit/" +
        event.params.whatToAdmit.toString() +
        "/" +
        event.params.id.toString(),
      {
        method: "post",
        headers: {
          "X-CSRF-Token": this.csrfToken(),
          "Content-type": "application/json",
        },
        body: JSON.stringify({
          is_admitted: event.target.checked,
        }),
      },
    );

    if (response.status >= 200 && response.status < 300) {
      return;
    } else if (response.status == 500) {
      alert("서버에 문제가 발생했습니다.");
      return;
    }
  }
}
