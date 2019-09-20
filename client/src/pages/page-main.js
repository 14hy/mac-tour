import { html, render } from 'lit-html'
import { styleMap } from 'lit-html/directives/style-map.js'

// import i18next from 'i18next'
import { loadXhr } from '../libs/actions.js'

import '../components/region-selector.js'

export class PageMain extends HTMLElement {
	constructor() {
		super()
	}

	connectedCallback() {
		render(this.render(), this)
        
		this.contentLoading()
	}

	render() {
		return html`
		${style}
		<div id="pageMain" class="page-content">
            <header>				
                <region-selector></region-selector>
            </header>
            <main></main>
		</div>
        `
	}
    
	async contentLoading(region = `all`) {
		const data = JSON.parse(await loadXhr({
			url: `https://mac-tour-dot-mac-tour-251517.appspot.com/main-page/?region=${region}`,
			method: `GET`,
		}))
        
		render(data.breweries.map(li => {
			const styles = {
				backgroundImage: `url(${li.url_img})`,
			}
			return html`
            <div class="content" @click="${this.clickContent}" style=${styleMap(styles)}>
                <span class="region-text">${li.region}</span>
                <span>${li.name}</span>
            </div>`
		}), this.querySelector(`main`))
	}
    
	get clickContent() {
		return {
			handleEvent() {				
				window.mainView.router.navigate(`/detail/`)
			},
			capture: true,
		}
	}
}

const style = html`
<style>
page-main {
    display: flex;
    position: absolute;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    margin: 0;
    padding: 0;
    justify-content: center;
    align-items: center;
    overflow: hidden;    
}

#pageMain {
    border: 1px solid #595959;
    width: 100vw;
    height: 100vh;
    margin: 0 auto;
    padding: 0;
    border-radius: 2px;    

    display: grid;
    grid-template-rows: 50px auto;
}

page-main header {
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
}

page-main header:after {
    content: '';
    position: absolute;
    right: 0;
    width: 100%;
    top: 100%;
    bottom: auto;
    height: 10px;
    pointer-events: none;
    background: linear-gradient(to bottom,rgba(0,0,0,.3) 0,rgba(0,0,0,.1) 40%,rgba(0,0,0,.05) 50%,rgba(0,0,0,0) 80%,rgba(0,0,0,0) 100%);
}

page-main main {
    overflow: scroll;
}

#pageMain .content {
    height: 150px;
    cursor: pointer;

    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
     
    border-radius: 10px;

    color: white;
    text-transform: uppercase;

    position: relative;
}

#pageMain .content .region-text {
    position: absolute;
    top: 5px;
    left: 5px;
    font-size: 20px;
    padding: 0 5px;
    height: 25px;
    line-height: 25px;
}

#pageMain .content > span {    
    font-family: 'Jua', sans-serif;    
    font-size: 25px;
    background-color: rgba(0, 0, 0, 0.3);
    padding: 0 10px;
}

page-main .logo, page-main .title, page-main .select-local, page-main .my-local, page-main footer span, page-main .content, page-main .search {
    background-color: #EEEEEE;
    margin: 5px;
    border-radius: 3px;
    color: #999999;
    display: flex;
    justify-content: center;
    align-items: center;
}
</style>
`

customElements.define(`page-main`, PageMain)
