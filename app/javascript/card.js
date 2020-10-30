const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    // id"charge-form"取得、FormDataオブジェクト生成
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);
    // FormDataからクレジットカードの情報を取得し、変数cardに代入するオブジェクトを定義
    const card = {
      number: formData.get("form_objects[number]"),
      cvc: formData.get("form_objects[cvc]"),
      exp_month: formData.get("form_objects[exp_month]"),
      exp_year: `20${formData.get("form_objects[exp_year]")}`,
    };
    // 第一引数cardにはクレジットカードの情報が入り、第二引数にはPAY.JP側からのレスポンスとステータスコードが含まれる
    // statusにはトークンの作成がうまくなされたかどうかを確認するHTTPステータスコードが入る
    // responseには↑のレスポンス内容が含まれ、response.idとすることでトークンの値を取得する
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        // HTMLのinput要素にトークンの値を埋め込み、フォームに追加
        const renderDom = document.getElementById("charge-form");
        // hiddenでブラウザ上には非表示に
        // valueは実際に送られる値、nameはその値を示すプロパティ名(params[:name]のように取得できるようになる)
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;
        // フォームの中に作成したinput要素を追加
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      // フォームに存在するクレジットカードの各情報を削除
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      // フォームの情報をサーバーサイドに送信
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);