window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");

  priceInput.addEventListener("input",()  => {
    const feeDisplay = document.getElementById("add-tax-price");
    feeDisplay.innerHTML = Math.round (priceInput.value*0.1);
    
    const profitDisplay = document.getElementById("profit");
    profitDisplay.innerHTML = Math.round(priceInput.value - Math.round(priceInput.value * 0.1 ))
})
});