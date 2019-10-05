import { html, render } from 'lit-html'
import i18next from 'i18next'
import { css } from 'emotion'
import { loadXhr } from '../libs/actions.js'

import './attraction-info.js'

export class TabInfo extends HTMLElement {
	constructor() {
		super()
        
		this.brewerImg = `/img/white.png`
	}

	connectedCallback() {
		render(this.render(), this)   
        
		this.contentLoading()
	}

	render() {
		return html`
        <div class="${style}">
            <header>
                <a class="btn-back" href="/"><i class="f7-icons">chevron_left</i></a>
                <div class="brew-name">${this.brewerName}</div>
            </header>
            <main>      
                <img src="${this.brewerImg}" alt="브루어리 이미지" />

                <div class="btn-list">
                    <button class="col button button-raised" @click="${this.clickHomepage}">${i18next.t(`HOMEPAGE`)}</button>
                    <button class="col button button-raised" @click="${this.clickSearchRoad}">${i18next.t(`FIND_PUBLIC_TRANSPORT`)}</button>
                    <button class="col button button-raised" @click="${this.clickNavigation}">${i18next.t(`TMAP_NAVIGATION`)}</button>
                </div>

                <attraction-info></attraction-info>
            </main>
        </div>
        `
	}
    
	async contentLoading() {
		let res = await loadXhr({
			url: `https://mac-tour-dot-mac-tour-251517.appspot.com/detail-page/brewery?BreweryName=${window.mainView.router.currentRoute.params.brewerName}`,
			method: `GET`,
		})

		res = JSON.parse(res)
        
		this.brewerName = res.brewery.name
		this.brewerImg = res.brewery.url_img
		this.homepageUrl = res.brewery.home_page
		this.location = {
			lon: res.brewery.location[0],
			lat: res.brewery.location[1],
		}
        
		this.logo = res.brewery.url_logo
        
		render(this.render(), this)
	}
    
	get clickHomepage() {
		const root = this
		return {
			handleEvent() {
				cordova.InAppBrowser.open(root.homepageUrl, `_self`)
			},
			capture: false,
		}
	} 
    
	get clickSearchRoad() {
		const root = this
		return {
			handleEvent() {
				cordova.InAppBrowser.open(`https://map.kakao.com/link/to/${root.brewerName},${root.location.lat},${root.location.lon}`, `_system`)
			},
			capture: false,
		}
	}
    
	get clickNavigation() {
		const root = this
		return {
			handleEvent() {
				cordova.InAppBrowser.open(`https://apis.openapi.sk.com/tmap/app/routes?appKey=20a000fc-d6c7-4bdd-909c-3e5f89c4868e&name=${root.brewerName}&lon=${root.location.lon}&lat=${root.location.lat}`, `_system`)
			},
			capture: false,
		}
	}
}

const style = css`
& {    
    border: 1px solid #595959;
    width: 100%;
    margin: 0 auto;
    padding: 0;
    border-radius: 2px;    

    display: grid;
    grid-template-rows: 50px auto;

    & header {
        display: grid;
        grid-template-columns: 50px auto;
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

        & .btn-back {
            display: flex;
            align-items: center;
            justify-content: center;        
        }        

        & .brew-name {    
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 0;
            padding-left: 20px;
            padding-right: 50px;
            font-weight: bold;
        }
    }

    & main {
        display: grid;
        grid-auto-rows: 150px 40px auto;
        grid-row-gap: 5px;
        overflow: hidden;

        & > img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }

        & #divTMap {
            height: 100%;
            margin: 3px !important;
            position: relative;
            background-color: #EEEEEE;
        }

        & .btn-list {
            margin: 5px;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            grid-column-gap: 10px;

            & span {
                background-color: #EEEEEE;
                height: 50px;
                margin: 5px;
                border-radius: 3px;
                color: #999999;
                display: flex;
                justify-content: center;
                align-items: center;
                text-align: center;
            }
        }

        & .logo, & .title, & .select-local, & .my-local, & footer span {
            background-color: #EEEEEE;
            margin: 5px;
            border-radius: 3px;
            color: #999999;
            display: flex;
            justify-content: center;
            align-items: center;
        }        
    }
}
`

customElements.define(`tab-info`, TabInfo)
