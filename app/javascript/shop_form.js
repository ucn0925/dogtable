document.addEventListener("turbo:load", () => {
  const blockSelect = document.getElementById("shop_block_id");
  const citySelect = document.getElementById("shop_city_id");

  console.log(blockSelect);
  console.log(citySelect);

  if (!blockSelect || !citySelect) return;

  blockSelect.addEventListener("change", () => {
    console.log(blockSelect.value);

    const cityOptions = Array.from(citySelect.options);

    cityOptions.forEach((option) => {
      const isSameBlock = option.dataset.blockId === blockSelect.value;

      option.hidden = !isSameBlock;
    });
  });
});