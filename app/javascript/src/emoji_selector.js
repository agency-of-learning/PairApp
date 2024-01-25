document.addEventListener('click', (event) => {
  const emojiSelections = document.querySelectorAll('details[open].emoji-selection');

  if (emojiSelections.length > 0) {
    const selectionClicked = [...emojiSelections].some(
      (selection) => selection.contains(event.target),
    );

    if (selectionClicked === false) {
      emojiSelections.forEach((selection) => selection.removeAttribute('open'));
    }
  }
});
