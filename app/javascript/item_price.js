// load ページが読み込まれた後に発火
window.addEventListener('load', () => {
  // 金額を入力した数値をpriceInputという変数に格納する
  // getElementById("HTMLのid名")を取得
  const priceInput = document.getElementById("item-price");
  // inputイベントで入力があるたびにイベント発火
  priceInput.addEventListener("input", () => {
    // inputValueにpriceInputで入力された数値を取得
    const inputValue = priceInput.value;
    //innerHTMLで取得したid名に表示させる
    //Math.floorで小数点以下表示させない
    const addTaxDom = document.getElementById('add-tax-price');
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1)
    const addProfitDom = document.getElementById('profit');
    addProfitDom.innerHTML = Math.floor(inputValue * 0.9)
  })
});