# Logger UI in Elm

An experimental version of the EKM Logger dashboard written using [Elm](http://elm-lang.org/)


### Install:
Clone this repo into a new project folder, e.g. `my-elm-project`, and install its dependencies:
```
git clone https://github.com/simax/Logger-UI-in-Elm logger-ui-in-elm
cd logger-ui-in-elm
npm install
```

If you haven't done so yet, install Elm globally:
```
npm install -g elm
```

Install Elm's dependencies:
```
elm package install
```

### Serve locally:
```
npm start
```
* Access app at `http://localhost:8080/`
* Get coding! The entry point file is `src/elm/Main.elm`
* Browser will refresh automatically on any file changes..


### Build & bundle for prod:
```
npm run build
```

* Files are saved into the `/dist` folder
* To check it, open `dist/index.html`

### Backend server API

The serverAPI string defined in the main.elm file is set to the URL of the EKM Logger API.
