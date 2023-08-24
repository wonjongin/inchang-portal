import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="cashio"
export default class extends Controller {
  connect() {
    this.enterToTab();
    console.log("connected");
  }

  csrfToken() {
    const meta = document.querySelector('meta[name=csrf-token]');
    const token = meta && meta.getAttribute('content');

    return token ?? false;
  }

  enterToTab() {
    document.addEventListener("keypress", function (event) {
      if (event.keyCode === 13 && event.target.nodeName === 'INPUT') {
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

  async saveCashio(event) {
    console.log(event);
    const priceValidation = /^[0-9]*$/;
    const form = document.getElementById("newCashioForm");
    console.log(form.elements);
    if (
      form.elements["date"].value === "" ||
      form.elements["account"].value === "" ||
      form.elements["desc"].value === "" ||
      form.elements["io"].value === ""
    ) {
      alert("빈 값이 있습니다.");
      console.log(1);
      return;
    }
    if (
      form.elements["price"].value === ""
    ) {
      alert("금액을 형식에 맞게 입력해주세요.");
      console.log(1);
      return;
    }

    if (!priceValidation.test(form.elements["price"].value)) {
      alert("금액이 숫자형식이 아닙니다.");
      return;
    }

    let url = "";
    if (event.params.type === "create") {
      url = '/api/v1/cashio/create';
    } else if (event.params.type === "update") {
      url = '/api/v1/cashio/update/' + event.params.cashioId.toString();
    }

    let response = await fetch(url, {
      method: 'post',
      headers: {
        'X-CSRF-Token': this.csrfToken(),
        'Content-type': "application/json"
      },
      body: JSON.stringify({
        date: form.elements["date"].value,
        account: form.elements["account"].value,
        desc: form.elements["desc"].value,
        note: form.elements["note"].value,
        price: form.elements["price"].value,
        io: form.elements["io"].value,
      })
    });

    if (response.status >= 200 && response.status < 300) {
      alert('저장되었습니다.');
      let url = '/api/v1/cashio/list';
      window.location.replace(url);
      return;
    } else if (response.status == 500) {
      alert('서버에 문제가 발생했습니다.');
      return;
    }
  }

  async saveBalance(event) {
    console.log(event);
    const priceValidation = /^[0-9]*$/;
    const form = document.getElementById("newBalanceForm");
    console.log(form.elements);
    if (form.elements["date"].value === "") {
      alert("빈 값이 있습니다.");
      console.log(1);
      return;
    }
    if (form.elements["price"].value === "") {
      alert("금액을 형식에 맞게 입력해주세요.");
      console.log(1);
      return;
    }

    if (!priceValidation.test(form.elements["price"].value)) {
      alert("금액이 숫자형식이 아닙니다.");
      return;
    }

    let url = '/api/v1/cashio/create_base_balance';
    let response = await fetch(url, {
      method: 'post',
      headers: {
        'X-CSRF-Token': this.csrfToken(),
        'Content-type': "application/json"
      },
      body: JSON.stringify({
        date: form.elements["date"].value,
        price: form.elements["price"].value,
      })
    });

    if (response.status >= 200 && response.status < 300) {
      alert('저장되었습니다.');
      let url = '/api/v1/cashio/list';
      window.location.replace(url);
      return;
    } else if (response.status == 500) {
      alert('서버에 문제가 발생했습니다.');
      return;
    }
  }


  async admit(event) {
    console.log(event.target.checked);

    let response = await fetch(
      '/api/v1/cashio/admit/' + event.params.cashioId.toString(), {
        method: 'post',
        headers: {
          'X-CSRF-Token': this.csrfToken(),
          'Content-type': "application/json"
        },
        body: JSON.stringify({
          is_admitted: event.target.checked,
        })
      });

    if (response.status >= 200 && response.status < 300) {
      return;
    } else if (response.status == 500) {
      alert('서버에 문제가 발생했습니다.');
      return;
    }
  }


}
