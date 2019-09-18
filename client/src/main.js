import './libs/i18n.js'
import store from './libs/store.js'

import './components/app-loading.js'

import './pages/page-main.js'

export const main = new class {
	constructor() {
		this.path = location.pathname
		this.isContinue = true
	}

	init() {
		this.connectRoute()
	}

	// Init functions

	connectRoute(pathName = this.path.split(`/`)[1] || `main`) {
		const isRoute = () => Object.keys(store.getState().router).includes(pathName)

		if (isRoute()) {
			this.renderPage(`page-${pathName}`, `/${this.pathName}`)
			return
		}
		this.otherwise()
	}

	otherwise() {
		this._onLoad(() => history.replaceState({}, null, `/`))
		this.renderPage(`page-main`, `/`)
	}

	// Functions

	_onLoad(callback) {
		window.addEventListener(`load`, () => {			
			callback()
		})
	}

	loadingDOM() {
		const root = document.querySelector(`#root`)
		const loading = document.createElement(`app-loading`)
				
		this.emptyDOM()
		root.appendChild(loading)
	}

	renderPage(pageName, path) {		
		this.emptyDOM()
		const pageElement = document.createElement(pageName)
		document.querySelector(`#root`).appendChild(pageElement)
		history.pushState({}, pageName, path)
	}	

	emptyDOM() {
		document.querySelector(`#root`).innerHTML = ``	
	}

	isIE() {		
		return navigator.userAgent.includes(`Trident`) || navigator.userAgent.includes(`MSIE`)
	}
}

main.init()
