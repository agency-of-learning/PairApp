import Trix from 'trix';

// fix for inline code formatting
// https://github.com/basecamp/trix/issues/552#issuecomment-427141510
Trix.config.textAttributes.inlineCode = {
  tagName: 'code',
  inheritable: true,
};

function getCodeFormattingType(editor) {
  if (editor.attributeIsActive('code')) return 'block';
  if (editor.attributeIsActive('inlineCode')) return 'inline';

  const range = editor.getSelectedRange();
  if (range[0] === range[1]) return 'block';

  const text = editor.getSelectedDocument().toString().trim();
  return /\n/.test(text) ? 'block' : 'inline';
}

document.addEventListener('trix-initialize', (event) => {
  const element = event.target;
  const { toolbarElement, editor } = element;

  const blockCodeButton = toolbarElement.querySelector('[data-trix-attribute=code]');
  const inlineCodeButton = blockCodeButton.cloneNode(true);

  inlineCodeButton.hidden = true;
  inlineCodeButton.dataset.trixAttribute = 'inlineCode';
  blockCodeButton.insertAdjacentElement('afterend', inlineCodeButton);

  element.addEventListener('trix-selection-change', () => {
    const type = getCodeFormattingType(editor);
    blockCodeButton.hidden = type === 'inline';
    inlineCodeButton.hidden = type === 'block';
  });
});
