This project is bootstrapped with [Create Elm App](https://github.com/halfzebra/create-elm-app).

## Folder structure

```
my-app/
├── .gitignore
├── README.md
├── elm-package.json
├── elm-stuff
├── public
│   ├── favicon.ico
│   ├── index.html
│   ├── logo.svg
│   └── manifest.json
└── src
    ├── Main.elm
    ├── index.js
    ├── main.css
    └── registerServiceWorker.js
```

For the project to build, these files must exist with exact filenames:

- `public/index.html` is the page template;
- `public/favicon.ico` is the icon you see in the browser tab;
- `src/index.js` is the JavaScript entry point.

You can delete or rename the other files.

You may create subdirectories inside src.

## Available scripts
In the project directory you can run:
### `elm-app build`
Builds the app for production to the `build` folder.

By default, Create Elm App produces a build assuming your app is hosted at the server root.<br>
To override this, specify the `homepage` in your `elm-package.json`, for example:

```js
  "homepage": "http://mywebsite.com/relativepath",
```

This will let Create Elm App correctly infer the root path to use in the generated HTML file.

The build is minified, and the filenames include the hashes.
Your app is ready to be deployed!

### `elm-app install`

An alias for [`elm-app package install`](#package)

### `elm-app start`
Runs the app in the development mode.
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

## Adding a Stylesheet

This project setup uses [Webpack](https://webpack.js.org/) for handling all assets. Webpack offers a custom way of “extending” the concept of `import` beyond JavaScript. To express that a JavaScript file depends on a CSS file, you need to **import the CSS from the JavaScript file**:

### `main.css`

```css
body {
  padding: 20px;
}
```

### `index.js`

```js
import './main.css'; // Tell Webpack to pick-up the styles from main.css
```

