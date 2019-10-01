import { html, render } from 'lit-html'
import { styleMap } from 'lit-html/directives/style-map.js'
import { css } from 'emotion'

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
		<div id="pageMain" class="page-content ${styles}">
            <header>				
                <region-selector></region-selector>
            </header>
            <main></main>
		</div>
        `
	}
    
	async contentLoading(regions = [`경기`, `서울`, `충청`, `강원`, `전라`, `경상`, `부산`, `제주`]) {        
		let res = await Promise.all(regions.map(region => loadXhr({
			url: `https://mac-tour-dot-mac-tour-251517.appspot.com/main-page/?region=${region}`,
			method: `GET`,
		})))        
		res = res.map(each => JSON.parse(each))
		const data = {}
		regions.forEach((region, index) => {
			data[region] = res[index]
		})
                
		render(regions.map(region => html`
		${data[region][`breweries`].length ? html`<span class="region-title">${region}</span>` : html``}
		${this.contents(data[region])}
		`), this.querySelector(`main`))
	}
    
	contents(regionData) {
		return regionData[`breweries`].map(li => {
			const styles = {
				backgroundImage: `url(${li.url_img})`,
			}
			return html`
		    <div class="content" @click="${this.clickContent}" style=${styleMap(styles)}>
		        <span class="region-text">${li.region}</span>
		        <span class="brewer-name">${li.name}</span>
		    </div>`})
	}
    
	get clickContent() {
		return {
			handleEvent(event) {
				const target = event.target
				const brewerName = target.matches(`.brewer-name`) ? target.textContent : target.querySelector(`.brewer-name`).textContent
				window.mainView.router.navigate({
					name: `detail`,
					params: {
						brewerName: brewerName,
					},
				})
			},
			capture: false,
		}
	}    
}

const styles = css`
& {
    border: 1px solid #595959;
    width: 100%;
    height: 100%;
    margin: 0 auto;
    padding: 0;
    border-radius: 2px;    

    display: grid;
    grid-template-rows: 50px auto;

    & header {
        display: flex;
        justify-content: center;
        align-items: center;
        position: relative;

        &:after {
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
    }

    & main {
        overflow: scroll;

        & .content {
            height: 150px;
            cursor: pointer;

            background-repeat: no-repeat;
            background-position: center;
            background-size: cover;
            
            border-radius: 10px;

            color: white;
            text-transform: uppercase;

            position: relative;

            & .region-text {
                display: none;
                position: absolute;
                top: 5px;
                left: 5px;
                font-size: 20px;
                padding: 0 5px;
                height: 25px;
                line-height: 25px;
            }

            & > span {    
                font-family: 'Jua', sans-serif;    
                font-size: 25px;
                background-color: rgba(0, 0, 0, 0.3);
                padding: 0 10px;
            }
        }

        & .region-title {
            font-size: 24px;
            margin-top: 10px;
            display: block;
            text-align: center;
            font-family: Jua;
        }        
    }

    & .logo, & .title, & .select-local, & .my-local, & footer span, & .content, & .search {
        background-color: #EEEEEE;
        margin: 5px;
        border-radius: 3px;
        color: #999999;
        display: flex;
        justify-content: center;
        align-items: center;
    }
}
`

customElements.define(`page-main`, PageMain)
