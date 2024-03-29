import { configure } from '@storybook/polymer';

// automatically import all files ending in *.stories.js
const req = require.context('../src/stories', true, /\.stories\.js$/);
function loadStories() {

  // align: center
  document.body.style.display = `flex`;
  document.body.style.justifyContent = `center`;
  document.body.style.alignItems = `center`;
  document.body.style.margin = `0`;
  document.body.style.height = `100%`;
  document.body.appendChild(document.createElement(`main`))

  req.keys().forEach(filename => req(filename));
}

configure(loadStories, module);
