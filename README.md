# DeepX Challenge: A Github Favorites application

The goal of this project is to create a webpage to show Github repository issues and let the user favorite them. The data used is provided by the [v3](https://developer.github.com/v3/) api.

## Technologies
The technologies used in this project are:
* [NodeJs](https://nodejs.org/en/)
* [Create Elm App](https://www.npmjs.com/package/create-elm-app)  1.10.4
    * Basic project with [Elm](http://elm-lang.org/) support 
* [elm-lang](https://github.com/elm-lang)
    * [core](https://github.com/elm-lang/core), [html](https://github.com/elm-lang/html), [http](https://github.com/elm-lang/http) and [navigation](https://github.com/elm-lang/navigation) - latest
* [evancz/url-parser](https://github.com/evancz/url-parser)
* [krisajenkins/remotedata](https://github.com/krisajenkins/remotedata)
* [NoRedInk/elm-decode-pipeline](https://github.com/NoRedInk/elm-decode-pipeline)
* [Bootstrap](https://github.com/twbs/bootstrap) 4.1.2
* [ace-css](http://basscss.com/ace/) 1.1.0 / [font-awesome](https://fontawesome.com/) 4.7.0
* [JQuery](https://jquery.com/) 3.3.1

## Future work
* Research and test new possible UX/UI implementations.
* Improve issues http request to retrieve more than 100 issues.

## Installations and dependencies
It is necessary to have nodejs and create-elm-app installed to be able to install and run this project:
  * Download nodejs from [here](https://nodejs.org/en/download/)
  * Install create-elm-app by running `npm install create-elm-app -g`

Run `npm install` on the main application folder to load and install the project dependencies.

## Running the application

Run `elm-app start` for a dev server. Navigate to `http://localhost:3000/` to visualize the webpage running.

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


## 
