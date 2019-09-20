const routes = [
	{
		path: `/`,
		url: `./index.html`,
		name: `home`,
	},
	{
		path: `/about/`,
		url: `./pages/about.html`,
		name: `about`,
	},
	{
		path: `(.*)`,
		url: `./index.html`,
	},
]

// Theme
let theme = `auto`
if (document.location.search.indexOf(`theme=`) >= 0) {
	theme = document.location.search.split(`theme=`)[1].split(`&`)[0]
}

// Init App
window.app = new Framework7({
	id: `com.example.mac.tour`,
	name: `맥투`,
	root: `#app`,
	theme: theme,
	routes: routes,
	touch: {
		fastClicks: true,
	},
})

window.mainView = window.app.views.create(`.view-main`, {
	url: `/`,
})
