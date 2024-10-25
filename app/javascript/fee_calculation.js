const price = () => {

window.addEventListener('load', () => {
  const priceInput = document.getElementById( "item-price" );

  priceInput.addEventListener( 'input',()  => {
    const feeDisplay = document.getElementById( "add-tax-price" );
    feeDisplay.innerHTML = Math.floor ( priceInput.value * 0.1 );
    
    const profitDisplay = document.getElementById("profit");
    profitDisplay.innerHTML = Math.floor( priceInput.value - Math.floor( priceInput.value * 0.1 ))
})
});

};
window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);